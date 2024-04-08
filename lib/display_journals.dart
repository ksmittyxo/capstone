import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_service.dart';
import 'journalmodel.dart';
import 'package:capstone/write_journal.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JournalEntriesScreen extends StatefulWidget {
  const JournalEntriesScreen({super.key});

  @override
  State<JournalEntriesScreen> createState() => _JournalEntriesScreenState();
}

class _JournalEntriesScreenState extends State<JournalEntriesScreen> {
  var date = DateTime.now();
  final dbService = DatabaseService();
  final titleDateFormat = DateFormat.yMMMMd('en_US');
  final journalDateFormat = DateFormat.yMd();

  void deleteJournal(String id) {
    dbService.deleteJournal(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_outlined),
          onPressed: () {
            setState(() {
              date = date.subtract(const Duration(days: 1));
            });
          },
        ),
        title: Text(titleDateFormat.format(date)),
        actions: [
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
                      return const Center(
                        child: Text('No Journal Entries found'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.yellow[200],
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                            leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: SvgPicture.string(snapshot.data![index].face, width: 100)),
                            title: Text(
                                '${snapshot.data![index].title} - ${snapshot.data![index].emotion}'),
                            subtitle: Text(snapshot.data![index].reflection),
                            trailing: SizedBox(
                              height: 100,
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        deleteJournal(snapshot.data![index].id),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  }
                  return const Center(
                    child: Text('No Journal Entries found'),
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
    if (DateFormat.yMd().format(date) == DateFormat.yMd().format(DateTime.now())) { // the date shown is today
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
}
