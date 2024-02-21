import 'package:capstone/display_journals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_service.dart';
import 'journalmodel.dart';
import 'package:uuid/uuid.dart';

class WriteJournalScreen extends StatefulWidget {
  const WriteJournalScreen({Key? key}) : super(key: key);
  @override
  State<WriteJournalScreen> createState() => _WriteJournalScreenState();
}
class _WriteJournalScreenState extends State<WriteJournalScreen> {
  final dbService = DatabaseService();
  final titleController = TextEditingController();
  final reflectionController = TextEditingController();
  final emotionController = TextEditingController();
  final dateFormat = DateFormat('yMd');
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
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emotionController,
                  decoration: const InputDecoration(
                    hintText: 'Emotion',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: reflectionController,
                  decoration: const InputDecoration(
                    hintText: 'Reflection',
                    border: OutlineInputBorder(),
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
          date: dateFormat.format(DateTime.now()),
          title: titleController.text,
          reflection: reflectionController.text,
          emotion: emotionController.text);
      dbService.insertJournal(journal);
      setState(() {});
      titleController.clear();
      reflectionController.clear();
      emotionController.clear();
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
          emotion: emotionController.text);
      dbService.editJournal(updatedJournal);
      titleController.clear();
      reflectionController.clear();
      emotionController.clear();
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
          title: const Text(
            'New Entry',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 60),

          ),
          toolbarHeight: 100,
        ),
        body: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(hintText: 'Title',),
                      ),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            const Icon(Icons.mood_outlined, size: 50,),
                            const Icon(Icons.mood_bad_outlined, size: 50,),
                            IconButton(
                                icon: const Icon(Icons.add_reaction_outlined, size: 50),
                                onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      TextField(
                        controller: emotionController,
                        decoration: const InputDecoration(hintText: 'What emotion are you feeling right now?'),
                      ),
                      const Divider(),
                      TextField(
                        controller: reflectionController,
                        decoration: const InputDecoration(hintText: 'Reflect on your emotions...'),
                        minLines: 5,
                        maxLines: 7,
                      )
                    ],
                  ),
                )
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Finish Entry'),
        onPressed: () {},
      ),
    );
  }
}