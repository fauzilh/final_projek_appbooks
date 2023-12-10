import 'package:books/screens/books_list.dart';
import 'package:books/screens/home_screen.dart';
import 'package:books/screens/profilpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60,
      backgroundColor: Colors.redAccent,
      index: 1,
      items: [
        Icon(Icons.person_outline, size: 30), // index 0 - Ikon Person
        Icon(Icons.home,
            size: 30, color: Colors.redAccent), // index 1 - Ikon Home
        Icon(Icons.library_books, size: 30), // index 2 - Ikon Favorit
      ],
      onTap: (index) {
        if (index == 0) {
          // Navigasi ke halaman profil ketika ikon Person ditekan
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        } else if (index == 2) {
          // Navigasi ke halaman favorit ketika ikon Favorit ditekan
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookListPage(),
            ),
          );
        } else if (index == 1) {
          // Navigasi ke halaman home ketika ikon Home ditekan
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      },
    );
  }
}
