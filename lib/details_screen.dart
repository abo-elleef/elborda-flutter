import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io' show Platform;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';



class Details extends StatefulWidget {
  var poem;
  String id;
  List items;
  List links;
  Details(this.poem, this.items, this.links);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsState(poem, '...', items, links);
  }
}

class DetailsState extends State<Details> {
  var poem;
  String pageTitle;
  String id ;
  List items;
  YoutubePlayerController _controller;
  AdmobBannerSize bannerSize;
  String ids = '';
  String type = "";
  DetailsState(this.poem, this.pageTitle, this.items, this.links);
   List<dynamic> lines = [];
  List<dynamic> links = [];
  @override
  void initState() {
    getPoem();
    bannerSize = AdmobBannerSize.BANNER;
    super.initState();
    print(links);
    if (!(links.isEmpty || links.first["link"].isEmpty)){
      type = links.first["source"];
      if (links.first['source'] == "you_tube"){
        ids = links.first["link"].split("/embed/").last;
      }
      if (links.first['source'] == "sound_cloud"){
        ids = links.first["link"];
      }

    }
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
      lines = items;
      pageTitle = poem["name"];
      id = poem["id"];
    });
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
                  height: 300,
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
    List<Container> items = lines.asMap().entries.map((pair) {
      // pair.key to get the index of each item
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
          pair.value['body'].join('\n'),
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(34, 34, 34, 1),
          ),
        ),
      );
    }).toList();
    body.addAll(items);
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
