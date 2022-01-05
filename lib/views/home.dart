import 'dart:io';

import 'package:ajilpress/api/posts.dart';
import 'package:ajilpress/models/categorie.dart';
import 'package:ajilpress/models/post.dart';
import 'package:ajilpress/views/widgets/Card_cat.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';
import 'details.dart';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();

}
class _HomePageState extends State<HomePage> {

  List<Post> _listPost=[];
  GlobalKey<RefreshIndicatorState> refreshkey;
  List<Categorie> _categories;
  bool _isloading=false;
  String _search="0";
  String _pathLogo="assets/images/ajil.png";

  var  dateTimeFromStr="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkConnection();

    refreshkey=GlobalKey<RefreshIndicatorState>();
    getCategories();
    getPost();
  }

  @override
  Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.red[900],
         //title: Center(child: Text('عاجل بريس')),
         title:Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             //Image.asset('/images/logo.png', fit: BoxFit.contain, height: 32,),
             //Icon(Icons.ac_unit_rounded),
             Container(
                 padding: const EdgeInsets.all(8.0), child:Text('عاجل بريس'))
           ],

         ),

       ),
       body:  Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
         child:

         (_isloading)?
              Column(
           children: [
             SizedBox(height: 5),
             _buildStoryListView(),
             SizedBox(height: 5),
             _buildCardListView(),
           ],
         ):
            AvatarGlow(
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
                   _pathLogo,
//                   height: 60,
                 ),
               radius: 40.0,
             ),
           ),
         ),
       ),


       //bottomSheet: Container(height: 30,width: MediaQuery.of(context).size.width, color: Colors.red[900],),
       floatingActionButton:
         SizedBox(
         height:MediaQuery.of(context).size.width/15,
         width: MediaQuery.of(context).size.width/15,
         child: FittedBox(
           child:FloatingActionButton(


           onPressed:() => showDialog<String>(
           context: context,
           builder: (BuildContext context) => AlertDialog(
             title: const Text('حول التطبيق',textAlign: TextAlign.center,),
             content:Column(

               children: [
                 Text('عاجل بريس تطبيق يستمد المعلومات من الموقع الالكتروني  :',textAlign: TextAlign.right,),

                 GestureDetector(
                   onTap: () async {
                     const url ="http://3ajilpress.com";
                      if(await canLaunch(url)) await launch(url);

                   },
                   child: Text('http://3ajilpress.com',textAlign: TextAlign.right,),
                 ),
                 Text('صمم التطبيق بتكنلوجيا',textAlign: TextAlign.right,),
                 Text(' flutter',textAlign: TextAlign.right,),
                 Text(' التي تستخدم للغة البرمجة ',textAlign: TextAlign.right,),
                 Text(' dart',textAlign: TextAlign.right,),

                 Expanded(
                   child: Align(
                     alignment: FractionalOffset.bottomCenter,
                     child: Padding(
                         padding: EdgeInsets.only(bottom: 10.0),
                         child: Text("youssef1996ait@gmail.com",style:TextStyle(color:Colors.red[900]))
                     ),
                   ),
                 ),
               ],
             ),
             actions: <Widget>[
               TextButton(
                 onPressed: () => Navigator.pop(context, 'عودة'),
                 child: Icon(Icons.close_sharp,color: Colors.red[900],),
               ),

             ],
             backgroundColor: Colors.grey[300],
           ),
       ),




         backgroundColor:  Colors.red[900],
         child:Icon(Icons.info_outlined,
         color:Colors.white),
       ),
     ),),

       bottomSheet: Padding(padding: EdgeInsets.only(bottom: 20.0)),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,


     );
  }
  Future<void> getPost() async {
    var data=await Posts.getAllPost();
    setState(()  {
      _listPost=data;
      _isloading=true;
    });
    //updateImageUrl();
    /*
    for(var i in _listPost)
    {
     // print(i.toString());
      var data=Posts.getImageByUrl(i.image);
      //print(data);
    }*/
  }
  Widget _buildCardListView() {
    return Expanded(
      child: Container(
     //   width: MediaQuery.of(context).size.width,
        height:600.0,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notif){
            if(notif is ScrollStartNotification)
              print("is Staaaaaaaaaart");
            if(notif is ScrollEndNotification)
              print("is eeeeeeeeeend");

            return true;
          },
          child: RefreshIndicator(


            key: refreshkey ,
            backgroundColor: Colors.white70,
            color: Colors.white70,
            onRefresh: (){
              setState(() {
                _isloading=false;
                //getRecipes();
                getPost();
              });
            },


            child: ListView.builder(

              scrollDirection: Axis.vertical,
              itemCount: _advancedListPost().length,
              itemExtent: 200.0,
              itemBuilder: (context, index) {
                List<Post> _data=_advancedListPost();//_advancedListPost
                var item = _data[index];
                print('holla---');
                print(item.url_image);
                //if(item.categories.contains(_search) || _search=="0")

                return Card(
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
  /*
                      Expanded(
                        child:
                           Container(
                             padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: FutureBuilder(
                                    future: Posts.getImageByUrl(item.image),
                                    builder: (context,res){
                                      if(res.hasData)
                                          return  OctoImage(
                                        width: MediaQuery.of(context).size.width,
                                        image: NetworkImage( res.data["guid"]["rendered"]),
                                        placeholderBuilder: OctoPlaceholder.blurHash(
                                          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                        ),
                                        errorBuilder: OctoError.icon(color: Colors.red[900]),
                                        fit: BoxFit.fill,
                                      );

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
                                )
                              ],
                            ),
                          )

                      ),
*/
                      Expanded(
                        child: OctoImage(
                          width: MediaQuery.of(context).size.width,
                          //image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdx5NkTqe7sjEU1vNXBl-X_v8t5cBM21L-vOs_z6qwVu5JLHjKhw&s"),//item.url_image
                          image: NetworkImage(item.url_image),//
                          placeholderBuilder: OctoPlaceholder.blurHash(
                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          ),
                          errorBuilder: OctoError.icon(color: Colors.red[900]),
                          fit: BoxFit.fill,
                        ),
                      ),
                      ListTile(
                          onTap:(){
                           // print(item.Content);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detail(content:item.Content,image: item.url_image,title:item.title)),
                            );
                           // print(item.title);
                        } ,
                        title: Text(item.title,
                        textAlign: TextAlign.right,),
                        subtitle: Text(

                          getCustomiseDate(item.date),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  SizedBox _buildStoryListView() {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _categories[index];
           return GestureDetector(
             onTap: (){
               setState(() {
                 _search=item.id;
                 for(var cat in _categories)
                    cat.selected=false;
                 item.selected=true;
               });
             },
               child: Card_cat(id:item.id,name:item.name,storyUrl:item.storyUrl,selected: item.selected,)
           );

        },
      ),
    );
  }
  void getCategories() {
    _categories = <Categorie>[
      Categorie(
        id:"0",
        name: 'الرئيسية',
        storyUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdx5NkTqe7sjEU1vNXBl-X_v8t5cBM21L-vOs_z6qwVu5JLHjKhw&s',
        selected: true,
      ),

      Categorie(
        id:"1",
        name: 'المجتمع',
        storyUrl:
        'https://pbs.twimg.com/profile_images/779305023507271681/GJJhYpD2_400x400.jpg',

      ),
      Categorie(
        id:"3",
        name: 'الرياضة',
        storyUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdx5NkTqe7sjEU1vNXBl-X_v8t5cBM21L-vOs_z6qwVu5JLHjKhw&s',
      ),
      Categorie(
        id:"23",
        name: 'الصحة',
        storyUrl:
        'https://pbs.twimg.com/profile_images/779305023507271681/GJJhYpD2_400x400.jpg',

      ),
      Categorie(
        id:"76",
        name: 'المباريات',
        storyUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdx5NkTqe7sjEU1vNXBl-X_v8t5cBM21L-vOs_z6qwVu5JLHjKhw&s',
      ),
      Categorie(
        id:"100",
        name: 'المدونة',
        storyUrl:
        'https://images.unsplash.com/photo-1535370976884-f4376736ab06?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
      ),
//78,derasa 77 wadifa

    ];
  }
  Widget _customImage() {
    return SizedBox(
      height: 150,
      child: OctoImage(
        image: NetworkImage('https://via.placeholder.com/150'),
        progressIndicatorBuilder: (context, progress) {
          double value;
          var expectedBytes = progress?.expectedTotalBytes;
          if (progress != null && expectedBytes != null) {
            value =
                progress.cumulativeBytesLoaded / expectedBytes;
          }
          return CircularProgressIndicator(value: value);
        },
        errorBuilder: (context, error, stacktrace) => Icon(Icons.error),
      ),
    );
  }
  Widget _simpleBlur(String url) {
    return AspectRatio(
      aspectRatio: 269 / 173,
      child: OctoImage(
        image: NetworkImage(url),
        placeholderBuilder: OctoPlaceholder.blurHash(
          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
        ),
        errorBuilder: OctoError.icon(color: Colors.red[900]),
        fit: BoxFit.fill,
      ),
    );
  }
  Widget _circleAvatar() {
    return SizedBox(
      height: 75,
      child: OctoImage.fromSet(
        fit: BoxFit.cover,
        image: NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Macaca_nigra_self-portrait_large.jpg/1024px-Macaca_nigra_self-portrait_large.jpg',
        ),
        octoSet: OctoSet.circleAvatar(
          backgroundColor: Colors.red,
          text: Text("M"),
        ),
      ),
    );
  }
  Future<void> updateImageUrl() async {
    for(var i in _listPost){
      var data=await Posts.getImageByUrl(i.image);

      i.url_image=data["guid"]["rendered"] as String;
      print(i.url_image);
    }

    setState(() {
      _isloading=true;
    });
  }

   List<Post> _advancedListPost(){
      if(_search=="0")
        return _listPost;


      List<Post> _data=[];
      for(var item in _listPost)
        if(item.categories.contains(_search))
          _data.add(item);
      return _data;
  }

  String getCustomiseDate(String currentDate)
  {
    var dateTime1 = DateFormat('yyyy-M-d').parse(currentDate);
    return dateTime1.month.toString()+"-"+dateTime1.day.toString() +"-"+dateTime1.year.toString();
  }

  void checkConnection() async{
    bool etat=false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
        print("is connected to mobile");
        etat=true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
        print("is connected to wifi");
        etat=true;
    }

    if(!etat)
      setState(() {
        _pathLogo="assets/images/no_cnx.png";
      });
  }

}


