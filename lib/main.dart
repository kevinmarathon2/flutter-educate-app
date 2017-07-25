import 'package:flutter/material.dart';
import 'components/add_sub.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'EduTimer',
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new MyHomePage(title: 'EduTimer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page =0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new PageView(children: [
        new AddSubView( operation: "Addition"),
        new AddSubView( operation: "Subtraction"),
        new Container(color: Colors.grey)
      ], controller: _pageController, onPageChanged: onPageChanged),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.add), title: new Text("Addition")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.minimize), title: new Text("Subtraction")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.book), title: new Text("Reading"))
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
