import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testcrudapp/screen/update.dart';

class Second_screen extends StatelessWidget {

  CollectionReference recipes = FirebaseFirestore.instance.collection('Students');


  delete(id) async {
    try{
      recipes.doc(id).delete();
      print("data delete done");
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: recipes.snapshots(),
          builder: (context,snapshot){
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView.builder(
              itemCount:snapshot.data?.docs.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(snapshot.data?.docs[index]["nom"]+'  '+snapshot.data?.docs[index]["prenom"],style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    leading: const Icon(Icons.person,size: 30,color: Colors.blueGrey,),
                  subtitle: Text(snapshot.data?.docs[index]["ville"],style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)) ,
                  trailing: Row(
                       mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: ()async {
                        await delete(snapshot.data?.docs[index].id);
                        print('path is =>${snapshot.data?.docs[index].reference.path.toString()}');
                      }, icon: Icon(Icons.delete)),
                      IconButton(onPressed: () {
                        // Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Update(name : snapshot.data?.docs[index]['nom'],prenom:snapshot.data?.docs[index]['prenom'],ville:snapshot.data?.docs[index]['ville'],path:snapshot.data?.docs[index].reference.path.toString())));

                      }, icon: Icon(Icons.edit)),
                    ],
                  ),

                );
              },
            );
          }),
    );

  }
}
