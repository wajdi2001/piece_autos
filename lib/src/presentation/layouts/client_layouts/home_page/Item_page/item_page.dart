import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container
    (
      
      height: 1500,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(10)
      ),
      child: Column
      (
        children: 
        [
          Text("Item Page"),
        ],
      ),
    );
  }
}