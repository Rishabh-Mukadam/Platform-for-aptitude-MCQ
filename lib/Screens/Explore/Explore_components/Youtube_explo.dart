import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class Expo_youtube extends StatefulWidget {
  const Expo_youtube({super.key});

  @override
  State<Expo_youtube> createState() => _Expo_youtubeState();
}

class _Expo_youtubeState extends State<Expo_youtube> {

  List<String> _vedioId=[
    'DBgZYD0Ptlg',
    '6eTvNWkPrS8',
    'KE7tQf9spPg',
    'G4st5-0LYso'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _vedioId.length,
          itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: _vedioId[index],
                        flags: YoutubePlayerFlags(
                          autoPlay: true,
                          mute: true
                        )
                      )
                  ),
                );
          }
      ),
    );
  }
}
