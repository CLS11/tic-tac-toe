import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int filledBoxes = 0;
  int oScore = 0;
  int xScore = 0;
  var myTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 30,
  );
  bool oTurn = true;
  late List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] != '') {
        displayXO[index] = 'O';
        filledBoxes += 1;
      } else if (!oTurn && displayXO[index] != '') {
        displayXO[index] = 'X';
        filledBoxes += 1;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      _showWinner(displayXO[0]);
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      _showWinner(displayXO[3]);
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      _showWinner(displayXO[6]);
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      _showWinner(displayXO[0]);
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      _showWinner(displayXO[1]);
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      _showWinner(displayXO[2]);
    }
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      _showWinner(displayXO[0]);
    }
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      _showWinner(displayXO[6]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinner(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            FloatingActionButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text(
            'WINNER : ' + winner,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    _clearBoard;
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            FloatingActionButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
          title: Text(
            'DRAW',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );

    _clearBoard;
  }

  void _clearBoard() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
    filledBoxes = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player X',
                        style: myTextStyle,
                      ),
                      Text(
                        xScore.toString(),
                        style: myTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player O',
                        style: myTextStyle,
                      ),
                      Text(
                        oScore.toString(),
                        style: myTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[700]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        displayXO[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
