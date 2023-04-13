import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class PlayMusic extends StatefulWidget {
  const PlayMusic({Key? key}) : super(key: key);
  @override
  _PlayMusicState createState() => _PlayMusicState();
}
class _PlayMusicState extends State<PlayMusic> {
  late AudioPlayer player;
  late AudioCache cache;
  bool isPlaying =false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();
  int index =0;
  List<String> mylist= ['ses.mp3','ses1.mp3','ses2.mp3','ses3.mp3','ses4.mp3',
    'ses5.mp3','ses6.mp3','ses7.mp3','ses8.mp3','ses9.mp3'
  ];
  String imagePath = "assets/resim.jpg ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
    cache = AudioCache(fixedPlayer: player);
    index =0;
    setUp();
  }
  setUp(){
    player.onAudioPositionChanged.listen((d) {
      setState(() {
        currentPostion = d;
      });

      player.onDurationChanged.listen((d) {
        setState(() {
          musicLength= d;
        });
      });

      if (d >= musicLength ) {
        setState(() {
          index = index + 1;
          isPlaying = true;
          imagePath = "assets/resim${index + 1}.jpg";
        });

        cache.play(mylist[index]);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          leadingWidth: 220,
         backgroundColor: Colors.blueGrey.shade900,
          title: const Text('Sabo Music Playist'),
          toolbarHeight: 220,
           centerTitle: false,
    ),
    ),
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${currentPostion.inSeconds}'),
              Container(
                  width: 300,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slider(
                          value: currentPostion.inSeconds.toDouble().clamp(0, musicLength.inSeconds.toDouble()),
                          activeColor: Colors.black,
                          max: musicLength.inSeconds.toDouble(),
                          onChanged: (val){
                            seekTo(val.toInt());
                          }),
                    ),
                  )
              ),
              Text('${musicLength.inSeconds}'),
            ],
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.first_page), iconSize: 35,
                onPressed: (){
                  if(index>0) {
                    setState(() {
                      index--;
                      isPlaying= true;
                      imagePath = "assets/resim${index +1}.jpg";
                      print('$index');
                    });
                    cache.play(mylist[index]);
                  }
                  else{
                    setState(() {
                      isPlaying= true;
                      imagePath = "assets/resim.jpg";
                    });
                    print('$index');
                    cache.play(mylist[index]);

                  }
                }, ),
              IconButton(onPressed: (){
                if(isPlaying)
                {
                  setState(() {
                    isPlaying = false;
                  });
                  stopMusic();
                }
                else {
                  setState(() {
                    isPlaying = true;

                  });
                  playMusic(mylist[index]);
                }
              },
                icon: isPlaying?Icon(Icons.pause):
                Icon(Icons.play_arrow), iconSize: 35,),

              IconButton(
                icon: Icon(Icons.last_page), iconSize: 66,
                onPressed: (){
                  if(index < mylist.length-1 )
                  {  print('$index');
                  setState(() {
                    index=index+1;
                    isPlaying=true;

                    imagePath = "assets/resim${index + 1}.jpg";
                  });
                  print('$index');
                  cache.play(mylist[index]);
                  }
                  else {
                    setState(() {
                      index=0;
                      isPlaying=true;
                      imagePath = "assets/resim.jpg";
                    });
                    print("$index");
                    cache.play(mylist[index]);
                  }
                },
              )
            ],
          ),
          Text('${mylist[index]}')
        ],
      ),
    );
  }
  playMusic(String song)
  {
    cache.play(song);
  }
  stopMusic()
  {
    player.pause();
  }
  seekTo(int sec)
  {
    player.seek(Duration(seconds: sec));
  }
  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
