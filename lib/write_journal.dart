import 'package:capstone/display_journals.dart';
import 'package:capstone/emotions.dart';
import 'package:capstone/face_database_service.dart';
import 'package:capstone/store_faces.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_service.dart';
import 'journalmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({Key? key}) : super(key: key);
  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}

class _WriteJournalScreenState extends State<WriteJournalScreen> {
  final dbService = DatabaseService();
  final faceDbService = FaceDatabaseService();
  final titleController = TextEditingController();
  final reflectionController = TextEditingController();
  final emotionController = TextEditingController();
  // remove this later!!!!!
  final dateController = TextEditingController();
  String face = '';
  bool filledSelected = false;
  // DateFormat.yMd()
  final dateFormat = DateFormat('MM/dd/yyyy');
  void showBottomSheet(String functionTitle, Function()? onPressed) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: Theme.of(context).textTheme.displayMedium,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emotionController,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.displayMedium,
                      hintText: 'Emotion',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: reflectionController,
                    decoration: InputDecoration(
                      hintText: 'Reflection',
                      hintStyle: Theme.of(context).textTheme.displayMedium,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    child: Text(functionTitle),
                  )
                ],
              ),
            ));
  }

  void addJournal() {
    showBottomSheet('Add Journal', () async {
      var journal = JournalModel(
          id: Uuid().v4(),
          // date: dateFormat.format(DateTime.now()),
          date: dateController.text,
          title: titleController.text,
          reflection: reflectionController.text,
          emotion: emotionController.text,
          face: face);
      dbService.insertJournal(journal);
      setState(() {});
      // remove this!!!!!
      dateController.clear();
      titleController.clear();
      reflectionController.clear();
      emotionController.clear();
      face = '';
      Navigator.of(context).pop();
    });
  }

  void createJournal() {
    var journal = JournalModel(
        id: const Uuid().v4(),
        // date: dateFormat.format(DateTime.now()),
        date: dateController.text,
        title: titleController.text,
        reflection: reflectionController.text,
        emotion: emotionController.text,
        face: face);
    dbService.insertJournal(journal);
    setState(() {
      //remove this!!!!
      dateController.clear();
      titleController.clear();
      reflectionController.clear();
      emotionController.clear();
      face = '';
      Navigator.of(context).pop();
    });
  }

  void editJournal(JournalModel journal) {
    titleController.text = journal.title;
    reflectionController.text = journal.reflection;
    emotionController.text = journal.emotion;
    showBottomSheet('Update Journal', () async {
      var updatedJournal = JournalModel(
          id: journal.id,
          date: journal.date,
          title: titleController.text,
          reflection: reflectionController.text,
          emotion: emotionController.text,
          face: face);
      dbService.editJournal(updatedJournal);
      titleController.clear();
      reflectionController.clear();
      emotionController.clear();
      face = '';
      setState(() {});
      Navigator.of(context).pop();
    });
  }

  void deleteJournal(String id) {
    dbService.deleteJournal(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'New Entry',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        toolbarHeight: 100,
      ),
      body: Card(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 50,
                child: FutureBuilder<List<StoreFaces>>(
                  future: faceDbService.getFaces(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Text('no faces');
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              icon:
                                  SvgPicture.string(snapshot.data![index].svg),
                              onPressed: () {
                                emotionController.text =
                                    snapshot.data![index].emotion;
                                face = snapshot.data![index].svg;
                              },
                            )),
                      );
                    }
                    return const Text('no faces');
                  },
                ),
              ),
              ElevatedButton(
                child: Text('New', style: Theme.of(context).textTheme.displayMedium),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmotionScreen()),
                  );
                },
              ),
              const Divider(),
              TextField(
                controller: emotionController,
                decoration: InputDecoration(
                    hintText: 'What emotion are you feeling right now?',
                    hintStyle: Theme.of(context).textTheme.displayMedium
                ),
              ),
              const Divider(),
              TextField(
                controller: reflectionController,
                decoration: InputDecoration(
                    hintText: 'Reflect on your emotions...',
                    hintStyle: Theme.of(context).textTheme.displayMedium
                ),
                minLines: 5,
                maxLines: 7,
              ),
              const Divider(),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: 'date',
                  hintStyle: Theme.of(context).textTheme.displayMedium
                ),
              ),
            ],
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Finish Entry', style: Theme.of(context).textTheme.displaySmall,),
        onPressed: () {
          createJournal();
        },
      ),
    );
  }
}
