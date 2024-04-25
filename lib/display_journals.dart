import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_service.dart';
import 'journalmodel.dart';
import 'package:capstone/write_journal.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JournalEntriesScreen extends StatefulWidget {
  const JournalEntriesScreen({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<JournalEntriesScreen> createState() => _JournalEntriesScreenState();
}

class _JournalEntriesScreenState extends State<JournalEntriesScreen> with RestorationMixin {

  List<String> deleteTitles = ['Delete all entries', 'Delete today\'s entries'];
  String? selectedMenu;

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        date = newSelectedDate;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        // ));
      });
    }
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  var date = DateTime.now();
  final dbService = DatabaseService();
  final titleDateFormat = DateFormat.yMMMMd('en_US');
  final journalDateFormat = DateFormat('MM/dd/yyyy');

  void deleteJournal(String id) {
    dbService.deleteJournal(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_outlined),
          onPressed: () {
            setState(() {
              date = date.subtract(const Duration(days: 1));
            });
          },
        ),
        title: Text(
          titleDateFormat.format(date),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          // _deleteButton(),
          _calendarButton(),
          _rightButton()
        ],
      ),
      body: FutureBuilder<List<JournalModel>>(
                future: dbService.getJournalsFromDate(journalDateFormat.format(date)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                            'No Journal Entries found',
                            style: Theme.of(context).textTheme.displaySmall,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Card(
                        color: Theme.of(context).colorScheme.tertiary,
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                            leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: SvgPicture.string(snapshot.data![index].face, width: 100)),
                            title: Text(
                                '${snapshot.data![index].title} - ${snapshot.data![index].emotion}', style: Theme.of(context).textTheme.bodyMedium),
                            subtitle: Text(snapshot.data![index].reflection, style: Theme.of(context).textTheme.bodySmall),
                            trailing:
                            // SizedBox(
                            //   height: 100,
                            //   width: 100,
                            //   child: Row(
                            //     children: [
                                  // IconButton(
                                  //   icon: const Icon(Icons.edit),
                                  //   onPressed: () {},
                                  // ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        deleteJournal(snapshot.data![index].id),
                                  ),
                            //     ],
                            //   ),
                            // )
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      'No Journal Entries found',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  );
                }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WriteJournalScreen()),
            );
          }),
    );
  }

  Widget _rightButton() { // date.compareTo(DateTime.now() == 0
    if (DateFormat('MM/dd/yyyy').format(date) == DateFormat('MM/dd/yyyy').format(DateTime.now())) { // the date shown is today
      print(date);
      return IconButton(
        icon: const Icon(Icons.chevron_right_outlined, color: Colors.grey,),
        onPressed: () {},
      );
    } else {
      print(date);
      return IconButton( // the date shown is not today
        icon: const Icon(Icons.chevron_right_outlined),
        onPressed: () {
          setState(() {
            date = date.add(const Duration(days: 1));
          });
        },
      );
    }
  }

  Widget _calendarButton() {
    return IconButton(
      icon: const Icon(
        Icons.today_outlined,
      ),
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
    );
  }

  // Widget _deleteButton() {
  //   return MenuAnchor(
  //     builder: (BuildContext context, MenuController controller, Widget? child) {
  //       return IconButton(
  //         onPressed: () {
  //           if (controller.isOpen) {
  //             controller.close();
  //           } else {
  //             controller.open();
  //           }
  //         },
  //         icon: const Icon(Icons.more_horiz),
  //       );
  //     },
  //     menuChildren: List<MenuItemButton>.generate(2, (int index) => MenuItemButton(
  //         onPressed: () {
  //           setState(() {
  //             selectedMenu = deleteTitles[index];
  //           });
  //         },
  //         child: Text(''),
  //       ),
  //     ),
  //     );
  // }
}
