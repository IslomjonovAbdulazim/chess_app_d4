import 'package:flutter/material.dart';
import 'package:squares/squares.dart';

class ChessPage extends StatefulWidget {
  const ChessPage({super.key});

  @override
  State<ChessPage> createState() => _ChessPageState();
}

class _ChessPageState extends State<ChessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              BoardController(
                playState: PlayState.ourTurn,
                pieceSet: PieceSet.merida(),
                theme: BoardTheme.brown,
                moves: [],
                markerTheme: MarkerTheme(
                  empty: MarkerTheme.dot,
                  piece: MarkerTheme.corners(),
                ),
                promotionBehaviour: PromotionBehaviour.autoPremove,
                state: BoardState(
                  board: ['Q'],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
