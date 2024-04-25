import 'package:capstone/display_journals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:capstone/home.dart';
import 'package:capstone/sign_up.dart';
import 'package:capstone/login.dart';
import 'firebase_options.dart';
import 'auth_gate.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'logic.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capstone',
      theme: ThemeData(
        navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(const TextStyle())),
        textTheme: TextTheme(
          // date title on display emotions page
          headlineMedium: GoogleFonts.montserrat(
            fontSize: 25,
            fontWeight: FontWeight.w400
          ),
          headlineSmall: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          // chart page
          displayLarge: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w400
          ),
          // write journal entries page
          displayMedium: GoogleFonts.montserrat(
              fontSize: 17,
              fontWeight: FontWeight.w400
          ),
          // no journal entries found
          displaySmall: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w400
          ),
          // title of entry
          bodyMedium: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w400
          ),
          // reflection of entry
          bodySmall: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w400
          ),
          // labels for bottom nav bar
          labelSmall: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w400,
          ),
        ),
        // GoogleFonts.montserratTextTheme(ThemeData(brightness: Brightness.light).textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(244, 247, 255, 1),
          tertiary: const Color.fromRGBO(244, 247, 255, 1),
          background: const Color.fromRGBO(252, 251, 244, 1),
          inversePrimary: const Color.fromRGBO(252, 251, 244, 1),
        ),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}