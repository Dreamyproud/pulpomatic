import 'package:flutter/material.dart';
import 'package:netflix_clone/utils/path_mapping.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screens/download_screen.dart';
import 'screens/more_screen.dart';
import 'screens/search_screen.dart';
import 'screens/soon_screen.dart';
import 'screens/start_screen.dart';

class Home extends StatefulWidget {
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //Pantalla inicial

    Row rowTittle = new Row(
      children: <Widget>[
        Container(
          height: 35,
          width: 20,
          child: Image.asset(
            PathMapping.netflixIcon,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          'Tv Shows',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        Text('Movies',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16)),
        Text('My List',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16)),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );

    SliverAppBar sliverAppBar = new SliverAppBar(
      title: rowTittle,
      floating: false,
      pinned: true,
      snap: false,
      backgroundColor: Colors.black,
      expandedHeight: 460,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          fit: StackFit.expand, // Para expandir la imagen por
          children: [
            Image.network(
              'https://image.winudf.com/v2/image1/Y29tLnJrLmhhcnJ5LndhbGxwYXBlcl9zY3JlZW5fMF8xNTQ5NTYzMzE3XzAzMA/screen-0.jpg?fakeurl=1&type=.jpg',
              fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment(0.0, 0.0),
                  colors: <Color>[
                    Color(0x60000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.0, right: 45, left: 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        "Mi lista",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      )
                    ],
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 25,
                        ),
                        Text(
                          "Reproducir",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.info_outline, color: Colors.white),
                      Text(
                        "Información",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    //Demas pantallas

    List<Widget> listScreens = [
      new StartScreen(),
      new SearchScreen(),
      new SoonScreen(),
      new DownloadScreen(),
      new MoreScreen(),
    ];

    Stack stackOtherViews = new Stack(
      children: <Widget>[
        listScreens.elementAt(selectedIndex),
        new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 35,
                    width: 20,
                    child: Image.asset(
                      PathMapping.netflixIcon,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            //No more green
          ),
        ),
      ],
    );

    BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            label: 'Inicio',
            icon: Icon(
              Icons.home,
            )),
        BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search,
            )),
        BottomNavigationBarItem(
            label: 'Coming soon',
            icon: Icon(
              Icons.play_circle_filled,
            )),
        BottomNavigationBarItem(
            label: 'Downloads',
            icon: Icon(
              Icons.file_download,
            )),
        BottomNavigationBarItem(
            label: 'More',
            icon: Icon(
              Icons.view_headline,
            )),
      ],
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );

    Scaffold scaffold = new Scaffold(
      body: selectedIndex == 0
          ? CustomScrollView(
              slivers: <Widget>[sliverAppBar, StartScreen()],
            )
          : stackOtherViews,
      bottomNavigationBar: bottomNavigationBar,
    );

    return scaffold;
  }
}
