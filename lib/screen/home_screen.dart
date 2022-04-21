import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

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
        filledBoxes++;

      }
      if (!isTurnO && xOrOList[index] == '') {
        xOrOList[index] = 'X';
        isTurnO = true;
        filledBoxes++;

      }
    });
    _checkWinner();

    print('clicked ${index}');
  }




  void _checkWinner() {

    // Checking rows
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      _showWinDialog(xOrOList[0]);
    }
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      _showWinDialog(xOrOList[3]);
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      _showWinDialog(xOrOList[6]);
    }

    // Checking Column
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      _showWinDialog(xOrOList[0]);
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      _showWinDialog(xOrOList[1]);
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      _showWinDialog(xOrOList[2]);
    }

    // Checking Diagonal
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      _showWinDialog(xOrOList[0]);
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      _showWinDialog(xOrOList[2]);
    } else if (filledBoxes  == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],

            title: Text(   "هست برنده"+" ${winner}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[700]
                ),
                child: Text("شروع دوباره",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            title: Text("کسی برنده نشد",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700]
                ),
                child: Text("شروع دوباره",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        xOrOList[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
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
        Expanded(

          // Button for Clearing the Enter board
          // as well as Scoreboard to start allover again
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // RaisedButton(
                  //   color: Colors.indigo[50],
                  //   textColor: Colors.black,
                  //   onPressed: _clearScoreBoard,
                  //   child: Text("Clear Score Board"),
                  // ),
                  //

                  ElevatedButton(
                    onPressed: () {_clearScoreBoard();},
                    child: Text('پاکسازی'),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      primary: Colors.grey[800  ], // <-- Button color
                      onPrimary: Colors.white, // <-- Splash color
                    ),
                  )
                ],
              ),
            ))
      ],
    );

  }
}
