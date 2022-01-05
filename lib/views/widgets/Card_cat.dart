import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Card_cat extends StatelessWidget{

  final String storyUrl;
  final String name;
  final String id;
  final bool selected;



  Card_cat({
    @required this.id,
    @required this.name,
    @required this.storyUrl,
    @required this.selected=false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Container(

            decoration: BoxDecoration(

              image: DecorationImage(
                image: NetworkImage(
                  storyUrl,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black26,
                  BlendMode.darken,
                ),
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow:(this.selected)? [
                BoxShadow(color: Colors.red[900], spreadRadius: 2)
              ]:[],

              color: Colors.grey,
            ),
            child:  Center(
              //padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                    color:(this.selected)?Colors.white: Colors.white,
                    fontSize: (this.selected)?23:16,
                    ),
              ),
            ),
          ),


      );

  }


}