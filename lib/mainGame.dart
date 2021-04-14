import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BoardType tcolor = BoardType.brown;
  ChessBoardController _chessBoardController = new ChessBoardController();
  @override
  Widget build(BuildContext context) {
    setState(() {
      tcolor = tcolor;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Chess"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Board Theme',
                  ),
                  value: tcolor,
                  items: [
                    DropdownMenuItem(
                      child: Text("Brown"),
                      value: BoardType.brown,
                    ),
                    DropdownMenuItem(
                      child: Text("Dark Brown"),
                      value: BoardType.darkBrown,
                    ),
                    DropdownMenuItem(
                        child: Text("Green"), value: BoardType.green),
                    DropdownMenuItem(
                        child: Text("Orange"), value: BoardType.orange)
                  ],
                  onChanged: (value) {
                    setState(() {
                      tcolor = value;
                    });
                  }),
            ),
            ChessBoard(
              onMove: (move) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text('Made move $move'),
                  ),
                );
              },
              onCheckMate: (color) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Check Mate. Match has been completed.'),
                  ),
                );
                setState(() {
                  _chessBoardController.game.reset();
                });
              },
              onDraw: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Match is Draw better luck next time.'),
                  ),
                );
                setState(() {
                  _chessBoardController.game.reset();
                });
              },
              size: MediaQuery.of(context).size.width,
              enableUserMoves: true,
              boardType: tcolor,
              chessBoardController: _chessBoardController,
              onCheck: (color) {
                switch (color) {
                  case PieceColor.Black:
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text('Player 2 got check'),
                      ),
                    );
                    break;
                  case PieceColor.White:
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text('Player 1 got check'),
                      ),
                    );
                    break;
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                setState(() {
                  _chessBoardController.game.reset();
                })
              },
          mini: true,
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.undo_rounded)),
    );
  }
}
