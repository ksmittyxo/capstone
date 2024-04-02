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
  var startDate = DateFormat.yMd().format(DateTime.now().subtract(const Duration(days: 30)));
  var endDate = DateFormat.yMd().format(DateTime.now());

  final faceDbService = FaceDatabaseService();
  final dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: FutureBuilder<int>(
            future: dbService.countEmotionUse(info),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data == 0) {
                  return const Text(
                    'This emotion has been used 0 times\n',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  );
                } else {
                  return Text(
                    'Number of times this emotion has been used: ${snapshot.data}\n',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  );
                }
              }
              return const Text(
                'This emotion has been used 0 times\n',
                style: TextStyle(
                  fontSize: 20,
                ),
              );
            },
          ),
        ),

        //times the emotion has been used in the past __ days
        SizedBox(
          child: FutureBuilder<int>(
            future: dbService.timesUsedSinceDate(info, date),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data == 0) {
                  return const Center(
                    child: Text(
                      'In the last 7 days you have felt this emotion 0 times.\n',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  return Text(
                    'In the last 7 days you have felt this emotion ${snapshot.data} times.\n',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  );
                }
              }
              return const Center(
                child: Text(
                    'In the last 7 days you have felt this emotion 0 times.\n'),
              );
            },
          ),
        ),

        // times emotion has been used from __ to __
        SizedBox(
            child: FutureBuilder<int>(
          future: dbService.timesUsedWithinDates(info, startDate, endDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data == 0) {
                return Center(
                  child: Text(
                    'Between ${startDate} and ${endDate} you have felt this emotion 0 times.\n',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              } else {
                return Text(
                  'Between ${startDate} and ${endDate} you have felt this emotion ${snapshot.data} times.\n',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                );
              }
            }
            return Center(
              child: Text(
                'Between ${startDate} and ${endDate} you have used this emotion 0 times.\n',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}
