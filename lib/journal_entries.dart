import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_service.dart';
import 'journalmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class JournalEntriesScreen extends StatefulWidget {
  const JournalEntriesScreen({Key? key}) : super(key: key);
  @override
  State<JournalEntriesScreen> createState() => _JournalEntriesScreenState();
}
class _JournalEntriesScreenState extends State<JournalEntriesScreen> {
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
                height: 10,
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
      appBar: AppBar(
        title: const Text('Journal Entries'),
      ),
      body: FutureBuilder<List<JournalModel>>(
          future: dbService.getJournals(),
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
                      title: Text(snapshot.data![index].title +
                          ' - ' +
                          snapshot.data![index].emotion +
                          ' - ' + snapshot.data![index].date),
                      subtitle: Text(snapshot.data![index].reflection),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => editJournal(snapshot.data![index]),
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
        onPressed: () => addJournal(),
      ),
    );
  }
}