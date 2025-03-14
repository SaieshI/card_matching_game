import 'package:flutter/material.dart'; 

class DataModel{
    final String id; 
    final String image;
    bool faceUp; 
    bool isSame; 

    DataModel({
        required this.id, 
        required this.image, 
        this.faceUp = false, 
        this.isSame = false, 
    });
}