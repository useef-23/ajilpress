class Post
{
    String title;
    String Content;
    String date;
    String author;
    String excerpt;
    String categories;
    String tags;
    String image;
    String url_image="";


    Post({this.title, this.Content, this.date, this.author, this.excerpt,
      this.categories, this.tags, this.image,this.url_image});


    @override
   String toString() {
     return 'Post{date: $image}';
   }

  factory Post.fromJson(Map<String, dynamic> json)
  {
      return  Post(
          title       :json['title']['rendered']  ,
          Content     :json['content']['rendered']  ,
          date        :json['date'].toString() ,
          author      :json['author'].toString(),
          excerpt     :json['excerpt']['rendered']  ,
          categories  :json['categories'].toString(),
          tags        :"tags"  ,
          image       :json['featured_media'].toString(),
          url_image   :json['_embedded']['wp:featuredmedia'][0]['source_url']
       );
  }
   // _embedded wp:featuredmedia  source_url media_details

    static List<Post> postFromSnaphot(List snaphot)
    {
        return snaphot.map((data) {return Post.fromJson(data);}).toList();
    }
}