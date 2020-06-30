import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io' show Platform;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'poems.dart';



class Details extends StatefulWidget {
  var poem;
  String id;
  int chapter_index;
  List items;
  List links;
  Details(this.id, this.chapter_index);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsState(id, chapter_index, " ");
  }

}

class DetailsState extends State<Details> {
  var poem ;
  var chapter;
  String pageTitle = "";
  String id;
  int chapter_index;
  List items = [];
  YoutubePlayerController _controller;
  AdmobBannerSize bannerSize;
  String ids = '';
  String type = "";
  bool chapterView;
  DetailsState(this.id, this.chapter_index, this.pageTitle);
   List<dynamic> lines = [];
  List<dynamic> links = [];
  @override
  void initState() {
    getPoem();
    this.chapterView = this.chapter_index.isNegative;
    bannerSize = AdmobBannerSize.BANNER;
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: ids,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  Future<void> getPoem() async {
    setState(() {
      poem = poemsSource[this.id];
      List chapters = this.poem["chapters"] as List;
//      print(chapter_index);
      if(chapter_index.isNegative){
        lines = chapters.map((chapter) {return chapter['lines'];}).expand((pair) => pair).toList();
        links = chapters.map((chapter) {return chapter['links'];}).expand((pair) => pair).toList();
        pageTitle = poem["name"];
      }else{
        chapter = chapters[chapter_index];
        lines = chapter['lines'] as List;
        links = chapter['links'] as List;
        pageTitle = chapter["name"];
      }

      id = poem["id"];
      if (!(links.isEmpty || links.first["link"].isEmpty)){
        type = links.first["source"];
        if (links.first['source'] == "you_tube"){
          ids = links.first["link"].split("/embed/").last;
        }
        if (links.first['source'] == "sound_cloud"){
          ids = links.first["link"];
        }
      }
    });
  }

  void openNext(BuildContext ctx, int chapter_index, String id){
    Navigator.of(ctx).pop();
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Details(id, chapter_index+1);
    }));

  }
  void openPrevious(BuildContext ctx, int chapter_index, String id){
    Navigator.of(ctx).pop();
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Details(id, chapter_index-1);
    }));
  }

  Widget nextButton(){
    if(chapter_index.isNegative) {return SizedBox(width: 1);}
    List chapters = this.poem["chapters"] as List;
    if(chapters.length - 1 > chapter_index){
      return RaisedButton(
        child: Text(
          "التالي",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        onPressed: () {openNext(context, chapter_index, poem['id']);},
        color: Color(0xff4caf50),
      );
    }else{
      return SizedBox(width: 1);
    }

  }
  Widget previousButton(){
    if(chapter_index.isNegative) {return SizedBox(width: 1);}
    if (chapter_index > 0){
      return RaisedButton(
        child: Text(
          "السابق",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        onPressed: () {openPrevious(context, chapter_index, poem['id']);},
        color: Color(0xff4caf50),
      );
    }else{
      return SizedBox(width: 1);
    }

  }

  List<Widget> generateBody(List<dynamic> lines) {
    List<Widget> body = [];
    if (!Platform.isIOS){
      if (!this.ids.isEmpty){
        if (this.type == 'you_tube'){
          body.add(YoutubePlayer(controller: _controller));
        }
        if (this.type == 'sound_cloud'){
          body.add(
              Container(
                  height: 100,
                  child: WebView(
                    initialUrl: Uri.dataFromString('<html><body> <iframe width="100%" height="100%" scrolling="no" frameborder="no" allow="autoplay" src="'+this.ids +'&color=%23547c7c&auto_play=true&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"></iframe></body></html>', mimeType: 'text/html').toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                  )
              )
          );
        }
      }
    }

    body.add(SizedBox(height: 15,));
    body.add(AdmobBanner(
      adUnitId:  Platform.isIOS ? "ca-app-pub-2772630944180636/8356626963" : "ca-app-pub-2772630944180636/3185523871",
      adSize: bannerSize
    ));
    body.addAll(lines.map((pair) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            border: Border.all(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          pair['body'].join('\n'),
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(34, 34, 34, 1),
          ),
        ),
      );
    }));
    body.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        nextButton(),
        previousButton()
      ],
    ));
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.pageTitle),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: generateBody(lines),
            ),
          ),
        ),
      ),
    );
  }
}
