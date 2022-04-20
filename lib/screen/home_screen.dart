import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  bool isTurnO = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('دوز'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey[900],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              getScoreBoard(),
              SizedBox(
                height: 40,
              ),
              getGridView(),
              getTurn(),
            ],
          ),
        ));
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  void tapped(int index) {
    setState(() {
      isTurnO = !isTurnO;
    });

    print('clicked ${index}');
  }


  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
          itemCount: 9,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                tapped(index);
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
              ),
            );
          }),
    );
  }

  Widget getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'player O',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'player X',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
