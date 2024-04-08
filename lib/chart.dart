import 'package:capstone/journalmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:capstone/face_database_service.dart';
import 'package:capstone/store_faces.dart';
import 'package:intl/intl.dart';
import 'database_service.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool showAvg = false;

  String info = '';
  int number = -1;
  var date =
      DateFormat.yMd().format(DateTime.now().subtract(const Duration(days: 7)));
  var startDate = DateFormat.yMd()
      .format(DateTime.now().subtract(const Duration(days: 30)));
  var endDate = DateFormat.yMd().format(DateTime.now());

  int dropdownValue = 7;

  final List<int> days = [7, 30, 365];

  final faceDbService = FaceDatabaseService();
  final dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
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
                    return const SizedBox(
                      width: 60,
                      height: 34,
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        icon: SvgPicture.string(snapshot.data![index].svg),
                        onPressed: () {
                          setState(() {
                            info = snapshot.data![index].emotion;
                          });
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox(
                  width: 60,
                  height: 34,
                );
              },
            ),
          ),

          //total times emotion has been used
          SizedBox(
              child: Wrap(
            spacing: 1.0,
            direction: Axis.horizontal,
            children: [
              const Text(
                'You\'ve felt this emotion ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              FutureBuilder<int>(
                future: dbService.countEmotionUse(info),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data == 0) {
                      return const Text(
                        '0 times.\n',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    } else {
                      if (snapshot.data == 1) {
                        return Text(
                          '${snapshot.data} time.\n',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                      } else {
                        return Text(
                          '${snapshot.data} times.\n',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                      }
                    }
                  }
                  return const Text(
                    '0 times\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ],
          )),

          //times the emotion has been used in the past __ days
          SizedBox(
            child: Wrap(spacing: 10.0, direction: Axis.horizontal, children: [
              const Text(
                'In the last ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              DropdownMenu(
                width: 100,
                initialSelection: days.first,
                onSelected: (int? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    days.map<DropdownMenuEntry<int>>((int value) {
                  return DropdownMenuEntry(
                      value: value, label: value.toString());
                }).toList(),
              ),
              FutureBuilder<int>(
                future: dbService.timesUsedSinceDate(info, DateFormat.yMd().format(DateTime.now().subtract(Duration(days: dropdownValue)))),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data == 0) {
                      print(dropdownValue);
                      return const Center(
                        child: Text(
                          ' days you have felt this emotion 0 times\n',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      if (snapshot.data == 1) {
                        return Text(
                          ' days you have felt this emotion ${snapshot.data} time.\n',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                      } else {
                        return Text(
                          ' days you have felt this emotion ${snapshot.data} times.\n',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                      }
                    }
                  }
                  return const Center(
                    child: Text(
                      ' days you have felt this emotion 0 times.\n',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),

          // times emotion has been used from __ to __
          SizedBox(
              child: Wrap(
            children: [
              const Text('Between ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: startDate,
                  ),
                ),
              ),
              const Text(' and ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: endDate,
                  ),
                ),
              ),
              FutureBuilder<int>(
                future:
                    dbService.timesUsedWithinDates(info, startDate, endDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data == 0) {
                      return const Center(
                        child: Text(
                          ' you have felt this emotion 0 times.\n',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else {
                      if (snapshot.data == 1) {
                        return Text(
                          ' you have felt this emotion ${snapshot.data} time.\n',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                      } else {
                        return Text(
                          ' you have felt this emotion ${snapshot.data} times.\n',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                      }
                    }
                  }
                  return const Center(
                    child: Text(
                      ' you have used this emotion 0 times.\n',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              )
            ],
          ))
        ],
      ),
    ));
  }
}
