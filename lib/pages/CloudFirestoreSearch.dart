import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CloudFirestoreSearchState();
  }
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            // ignore: deprecated_member_use
            ? Firestore.instance
                .collection('Master_Profile')
                .where("Name", arrayContains: name)
                .snapshots()
            // ignore: deprecated_member_use
            : Firestore.instance.collection("Master_Profile").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Card(
                      child: Row(
                        children: <Widget>[
                          // Image.network(
                          //   data['imageUrl'],
                          //   width: 150,
                          //   height: 100,
                          //   fit: BoxFit.fill,
                          // ),
                          // SizedBox(
                          //   width: 25,
                          // ),
                          Text(
                            data['Name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            data['Email'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
