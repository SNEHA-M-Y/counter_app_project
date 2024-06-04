import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String count = "Count";
int? counter;
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void setState(VoidCallback fn) async {
    final sharedpref = await SharedPreferences.getInstance();
    if (sharedpref.getInt(count) == null) {
      counter = 0;
    } else {
      counter = sharedpref.getInt(count);
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 181, 213, 238),
        title: Text(
          "Counter App",
          style: GoogleFonts.agdasima(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 164, 120, 240),
            Color.fromARGB(255, 245, 118, 160),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: GoogleFonts.aBeeZee(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final _sharedpref = await SharedPreferences.getInstance();
                    setState(
                      () {
                        _sharedpref.setInt(count, counter! + 1);
                      },
                    );
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final _sharedpref = await SharedPreferences.getInstance();
                    setState(
                      () {
                        _sharedpref.setInt(count, counter! - 1);
                      },
                    );
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
