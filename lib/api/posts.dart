import 'dart:convert';

import 'package:ajilpress/models/post.dart';
import 'package:http/http.dart' as http;

class Posts{



  static Future<List<Post>> getAllPost() async{
//?per_page=100

    final queryParameters = {
      '_embed':'true',
      'per_page': '100'
    };
    
    var uri=Uri.http("3ajilpress.com","/wp-json/wp/v2/posts",queryParameters);
    final response =await http.get(uri,headers: {
      "Accept":"application/json"
    });
    var data =jsonDecode(response.body);
   // print("--------------------ola");
 //   print(data);
    return Post.postFromSnaphot(data);

  }

  static Future getImageByUrl(url) async{
    var uri=Uri.http("3ajilpress.com","/wp-json/wp/v2/media/"+url);
    final response =await http.get(uri,headers: {
      "Accept":"application/json"
    });

    var data =jsonDecode(response.body);
    return data;
    //print("this is image $url --> $data['guid']");
  }




}