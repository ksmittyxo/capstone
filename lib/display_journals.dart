import 'package:flutter/material.dart';
import 'database_service.dart';
import 'journalmodel.dart';
import 'package:capstone/write_journal.dart';

class JournalEntriesScreen extends StatefulWidget {
  const JournalEntriesScreen({super.key});

  @override
  State<JournalEntriesScreen> createState() => _JournalEntriesScreenState();
}
  class _JournalEntriesScreenState extends State<JournalEntriesScreen> {
    final dbService = DatabaseService();

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
                        title: Text('${snapshot.data![index].title} - ${snapshot.data![index].emotion} - ${snapshot.data![index].date}'),
                        subtitle: Text(snapshot.data![index].reflection),
                        trailing: SizedBox(
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
                MaterialPageRoute(builder: (context) => const WriteJournalScreen()),
              );
            }
        ),
      );
    }
  }

