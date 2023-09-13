import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:useradddata/dataofuser.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> DataOfUser()));
            }, 
            icon: Icon(Icons.people,size: 30,)
            ),
          SizedBox(width: 7,),
        ],
        title: Center(child: Text('TextFormFields ')),
        backgroundColor: Color.fromARGB(255, 232, 202, 241),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller1,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _controller2,
              decoration: InputDecoration(labelText: 'Mobile No'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _controller3,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Handle form submission here
                String field1Value = _controller1.text;
                String field2Value = _controller2.text;
                String field3Value = _controller3.text;

                // Create a reference to the Firestore collection
                final CollectionReference users = FirebaseFirestore.instance.collection('users');

                // Add a new document with a generated ID
                await users.add({
                  'Name': field1Value,
                  'MObile No': field2Value,
                  'Address': field3Value,
                });

                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> dataOfUser()));
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DataOfUser()));

                // Reset the text fields
                _controller1.clear();
                _controller2.clear();
                _controller3.clear();

                // Display a success message or navigate to another screen
                // Here, you can implement your desired logic after uploading to Firestore
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
