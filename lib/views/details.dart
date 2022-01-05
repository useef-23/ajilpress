import 'package:ajilpress/api/posts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:octo_image/octo_image.dart';

class Detail extends StatelessWidget{

  final String content;
  final String image;
  final String title;


  Detail({@required this.content,@required this.image,@required this.title});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.red[900],
        title:Text((this.title.length>30)?"..."+this.title.substring(0,30):this.title,
            textAlign: TextAlign.right),
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OctoImage(
              width: MediaQuery.of(context).size.width,
              image: NetworkImage(image),
              placeholderBuilder: OctoPlaceholder.blurHash(
                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
              errorBuilder: OctoError.icon(color: Colors.red[900]),
              fit: BoxFit.fill,
            ),
            Html(
              data: this.content,
              style: {
                "h2,h3,h4,ul":Style(color: Colors.red[900]),
                "*":Style(textAlign: TextAlign.right,padding:const EdgeInsets.all(3.0)),
              },
            ),
          ],

        ),
      ),
    );
  }

}

/*
Expanded(
              child: FutureBuilder(
                  future: Posts.getImageByUrl(this.image),
                  builder: (context,res){
                    if(res.hasData)
                      return Image.network(
                        res.data["guid"]["rendered"],width: MediaQuery.of(context).size.width,);

                    return     AvatarGlow(
                      glowColor: Colors.red[900],
                      endRadius: 90.0,
                      duration: Duration(milliseconds: 1500),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: Duration(milliseconds: 100),
                      child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 60,
                          ),
                          radius: 40.0,
                        ),
                      ),
                    );

                  }),
            ),
* */