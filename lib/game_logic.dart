import 'dart:async';
import 'package:flutter/material.dart';
import 'data_model.dart';

class GameProvider with ChangeNotifier{ 
    List<DataModel> cardList = [];
    List<DataModel> get cards => cardList; 

    DataModel? firstCardPicked; 
    DataModel? secondCardPicked; 
    bool checking = false; 

    GameProvider(){ 
        startGame(); 
    }

    void startGame(){ 
        List<String> cardImages = ['😃', '😅', '😇', '🥰', '😨', '😑', '😎', '🤯'];
        cardImages.shuffle(); 

        cardList = List.generate(cardImages.length * 2, (index) {
            return DataModel(id: index.toString(), image: cardImages[index % cardImages.length],);
        });

        notifyListeners(); 
    }

    void cardFlip(DataModel card){
        if (checking || card.faceUp || card.isSame) return;

        card.faceUp = true; 
        notifyListeners(); 

        if (firstCardPicked == null){ 
            firstCardPicked = card; 
        } else {
            secondCardPicked = card; 
            checking = true; 
            checkIfSame(); 
        }
    }

    void checkIfSame() {
        if(firstCardPicked != null && secondCardPicked != null){
            if(firstCardPicked!.image == secondCardPicked!.image){
                firstCardPicked!.isSame = true; 
                secondCardPicked!.isSame = true; 
            } else { 
                Future.delayed(Duration(seconds: 1), () {
                    firstCardPicked!.faceUp = false; 
                    secondCardPicked!.faceUp = false; 
                    notifyListeners(); 
                });
            }

            firstCardPicked = null; 
            secondCardPicked = null; 
        }

        checking = false; 
        notifyListeners(); 
    }

    bool checkWin(){ 
        return cardList.every((card) => card.isSame);
    }

    void resetGame(){
        startGame(); 
    }
}