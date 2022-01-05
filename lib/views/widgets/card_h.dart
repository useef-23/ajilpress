import 'package:flutter/material.dart';

class Card_h extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;

  Card_h({
    @required this.title,
    @required this.cookTime,
    @required this.rating,
    @required this.thumbnailUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: NetworkImage(thumbnailUrl),
              fit: BoxFit.cover,
            ),
          ),

          child: Stack(
            children: [
              Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.center,
              ),
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.red[900] ,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Text(rating),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.red[900] ,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Text(cookTime),
                        ],
                      ),
                    )
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),

            ],
          ),
        ),
        Container(

          decoration: BoxDecoration(
            color: Colors.white24,
          ),
          child: ListTile(


            title: Text("item.name"),
            subtitle: Text(
              'waleedarshad@email.com',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              Icons.call,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}

