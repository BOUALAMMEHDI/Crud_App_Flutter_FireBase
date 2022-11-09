import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testcrudapp/screen/update.dart';
// import 'package:testcrudapp/main.dart';

class Update extends StatelessWidget {

  CollectionReference recipes = FirebaseFirestore.instance.collection('Students');
  String name,prenom,ville;
  var path;

  Update({required this.name, required this.prenom, required this.ville, required  this.path});
  TextEditingController  nom_controller =  TextEditingController();
  TextEditingController prenom_controller =  TextEditingController();
  TextEditingController ville_controller =  TextEditingController();

  @override
  void initState() {
    nom_controller.text = name.toString();
    prenom_controller.text = prenom.toString();
    ville_controller.text = ville.toString();

  }

  update(String p) async {
    try{
      await recipes.doc(p).update({
        'nom' : nom_controller.text,
        'prenom': prenom_controller.text,
        'ville':ville_controller.text,
      });
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //
                  List<String>result = path.toString().split('/');
                  update(result[1].toString());
                  Navigator.pop(context);
                },
                label: const Text(
                  "Update",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],

          )
    );

  }
}
