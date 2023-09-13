import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataOfUser extends StatefulWidget {
  const DataOfUser({Key? key});

  @override
  State<DataOfUser> createState() => _DataOfUserState();
}

class _DataOfUserState extends State<DataOfUser> {
  final CollectionReference _user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TextFormFields')),
        backgroundColor: Color.fromARGB(255, 232, 202, 241),
      ),
      body: StreamBuilder(
        stream: _user.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator while data is loading.
          }
          if (streamSnapshot.hasError) {
            return Text('Error: ${streamSnapshot.error}');
          }
          if (!streamSnapshot.hasData) {
            return Text('No data available'); // Handle the case when there is no data.
          }

          // If you want to display a list of cards, you can use ListView.builder.
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                child: Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name : ' + documentSnapshot['Name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text('Mobile No : ' + documentSnapshot['MObile No'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                        Text('Address : ' + documentSnapshot['Address'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
