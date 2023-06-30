import 'package:bootcamp_oua_f4/screens/add_screen.dart';
import 'package:bootcamp_oua_f4/screens/detail_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: addScreen(),
    );
  }
}
<<<<<<< Updated upstream
=======


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {

  bool isFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();

  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });

    if(FirebaseAuth.instance.currentUser != null) {
      goToNavScreen();
    }

  }

  void goToNavScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NavScreen())); //Normalde NavScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isFirebaseInitialized ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {

                  await signInWithGoogle();

                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseFirestore.instance.collection('users').doc(uid).set({
                    'girisYaptiMi' : true,
                    'sonGirisTarihi' : FieldValue.serverTimestamp(),
                  },
                    SetOptions(merge: true),
                  );
                  print("debug: before reference");
                  CollectionReference kitchen = FirebaseFirestore.instance.collection('users').doc(uid).collection('kitchen');
                  await kitchen.doc('first doc').set({
                    'collection started' : true,
                  },
                  );

                  goToNavScreen();
                },
                child: const Text("Google Sign In")),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () {
                    goToNavScreen();
                  },
                  child: const Text("Giriş Yapmadan Devam Et")),
            ),
          ],
        )
            : const CircularProgressIndicator(
          value: 0.7,
          backgroundColor: Colors.red,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
          strokeWidth: 6.0,
        ),
      ),
    );
  }

}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes
