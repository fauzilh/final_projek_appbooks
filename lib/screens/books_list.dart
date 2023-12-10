import 'dart:convert';
import 'package:books/screens/book_detail_screen.dart';
import 'package:books/screens/home_screen.dart';
import 'package:books/services/apifetch_service.dart';
import 'package:books/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BooksAPI fetchapi = BooksAPI();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'All Books',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: fetchapi.getData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        List datas = snapshot.data!;

                        return ListView.builder(
                          itemCount: datas.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetailPage(datas[index]),
                                  ),
                                );
                              },
                              leading: Image.network(
                                datas[index]["imagePath"],
                                width: 100,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              title: Text(datas[index]["title"]),
                              subtitle: Text(datas[index]["category"]),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
