import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/All_Students.dart';


void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Simple Crud Application'),
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

  TextEditingController  nom_controller =  TextEditingController();
  TextEditingController prenom_controller =  TextEditingController();
  TextEditingController ville_controller =  TextEditingController();


  // _MyHomePageState(
  //     this.nom_controller, this.prenom_controller, this.ville_controller);

  final docstudent =  FirebaseFirestore.instance;
  create() async {
    try{
        await docstudent.collection("Students").doc().set({
        'nom': nom_controller.text,
        'prenom': prenom_controller.text,
        'ville':ville_controller.text,
      }
      );

    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor:Color(0x9ecff7),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(17.0),
            child : ListTile(
                title: TextFormField(
                  controller: nom_controller,
                  decoration: const InputDecoration(
                      labelText: "Nom",
                      fillColor: Colors.white,
                  ),
                  onChanged: (String name){
                    // getName(name);
                  },
                ),
                leading: const Icon(Icons.person_outline,size: 50,color: Colors.blueGrey,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child : ListTile(
              title: TextFormField(
                controller: prenom_controller,
                decoration: const InputDecoration(
                  labelText: "Prenom",
                  fillColor: Colors.white,
                ),
                onChanged: (String name){
                  // getName(name);
                },
              ),
              leading: const Icon(Icons.person_outline,size: 50,color: Colors.blueGrey,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child : ListTile(
              title: TextFormField(
                controller: ville_controller,
                decoration: const InputDecoration(
                  labelText: "Ville",
                  fillColor: Colors.white,
                ),
                onChanged: (String name){
                  // getName(name);
                },
              ),
              leading: const Icon(Icons.house_outlined,size: 50,color: Colors.blueGrey,),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: (){
                  create();
                  nom_controller.clear();
                  prenom_controller.clear();
                  ville_controller.clear();
                  },
                label: const Text(
                  "CREATE",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.source),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Second_screen()));
                },
                label: const Text(
                  "DATA",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ],

      ),
    );


  }
}
