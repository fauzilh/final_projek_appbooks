import 'package:books/category/category_button.dart';
import 'package:books/category/category_page.dart';
import 'package:books/screens/book_detail_screen.dart';
import 'package:books/services/apifetch_service.dart';
import 'package:books/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SearchBar.dart' as MySearchBar;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BooksAPI fetchapi = BooksAPI();
  List<dynamic> displayedData = []; // Menyimpan data yang ditampilkan
//--------------  INISIALISASI PENGOLAHAN DATA ---------------------------------
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  // Metode untuk memuat data
  void fetchData() {
    fetchapi.getData().then((result) {
      setState(() {
        displayedData = result;
      });
    }).catchError((error) {
      print("Error during data fetch: $error");
    });
  }

  // Metode untuk melakukan pencarian
  void performSearch(String query) {
    fetchapi.searchData(query).then((result) {
      setState(() {
        displayedData = result;
      });
    }).catchError((error) {
      print("Error during search: $error");
    });
  }

//-----navigasi ke halaman kategori ----
  void navigateToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(category),
      ),
    );
  }

//--------------BODY--------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // profil
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 24,
                              child: Icon(
                                Icons.person,
                                color: Colors.blue,
                                size: 36,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Find your dream book here',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                //----------------LISTVIEW SAMPUL BUKU--------------------------
                FutureBuilder(
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
                        List datas = displayedData;
                        return Container(
                          height: 230,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: datas.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BookDetailPage(datas[index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  width: 160,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 160,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          datas[index]["imagePath"] ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        datas[index]["title"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            datas[index]["rating"],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
                SizedBox(height: 8),
                //-------------------BUTTON KATEGORI BUKU------------------------------
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CategoryButton(
                              categoryName: "Romantis",
                              onTap: () => navigateToCategory("Romantis"),
                            ),
                            CategoryButton(
                              categoryName: "Sejarah",
                              onTap: () => navigateToCategory("Sejarah"),
                            ),
                            CategoryButton(
                              categoryName: "Drama",
                              onTap: () => navigateToCategory("Drama"),
                            ),
                            CategoryButton(
                              categoryName: "Fiksi",
                              onTap: () => navigateToCategory("Fiksi"),
                            ),
                            CategoryButton(
                              categoryName: "Adventure",
                              onTap: () => navigateToCategory("Adventure"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //--------------SEARCH BAR--------------------------------------
                MySearchBar.SearchBar(
                  onSearch: performSearch,
                ),
                //--------------LISTVIEW BUKU POPULER---------------------------
                FutureBuilder(
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
                      List datas = displayedData;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      //-----------------BOTTOM BAR---------------------------------------------
      bottomNavigationBar: BottomBar(),
    );
  }
}
