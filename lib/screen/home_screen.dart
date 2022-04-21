import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('دوز', style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),),
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
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: getTurn()),

            ],
          ),
        ));
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'O بازیکن' : 'X بازیکن',
      style: TextStyle(
          color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
    );
  }

  void tapped(int index) {
    setState(() {
      if (isTurnO && xOrOList[index] == '') {
        xOrOList[index] = 'O';
        isTurnO = false;
      }
      if (!isTurnO && xOrOList[index] == '') {
        xOrOList[index] = 'X';
        isTurnO = true;
      }
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
                child: Center(
                  child: Text(
                    xOrOList[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color:
                            xOrOList[index] == 'X' ? Colors.white : Colors.red),
                  ),
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
                  'O بازیکن',
                  style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
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
                  'X بازیکن',
                  style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
