import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_logic.dart'; 
import 'data_model.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => GameProvider(),
      child: MaterialApp(
        title: 'Card Game',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GameScreen(), 
      ), 
    );
  }
}

class GameScreen extends StatelessWidget{
  const GameScreen({super.key}); 

  Widget build(BuildContext context){
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Matching Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              gameProvider.resetGame(); 
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Text(
                  'Matched Pairs: ${gameProvider.cards.where((cards) => cards.isSame).length ~/ 2}',
                  style: const TextStyle(fontSize: 18), 
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, 
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10, 
              ),
              itemCount: gameProvider.cards.length, 
              itemBuilder: (context, index){
                final card = gameProvider.cards[index];

                return GestureDetector(
                  onTap:(){ 
                    gameProvider.cardFlip(card); 
                  },
                  child: CardWidget(card: card), 
                );
              },
            ),
          ),

          if (gameProvider.checkWin())
          Padding(
            padding: const EdgeInsets.all(16.0), 
            child: const Text('You Win!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}


