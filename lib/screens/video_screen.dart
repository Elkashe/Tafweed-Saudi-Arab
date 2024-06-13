import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/track/track_cubit.dart';
import 'package:video_player/video_player.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class VideoScreen extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoScreen({super.key, required this.controller});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final chewieController;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: widget.controller,
      autoPlay: true,
      looping: false,
      showOptions: false,
    );
    chewieController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.watch),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: Chewie(controller: chewieController,),
                ),
                // Center(
                //   child: AspectRatio(
                //     aspectRatio: widget.controller.value.aspectRatio,
                //     child: Opacity(
                //       opacity: 0.3,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           IconButton(
                //             onPressed: (){
                //               int current = widget.controller.value.position.inSeconds;
                //               if(current + 10 > widget.controller.value.duration.inSeconds){
                //                 widget.controller.seekTo(Duration(seconds: widget.controller.value.duration.inSeconds));
                //               }
                //               else{
                //                 widget.controller.seekTo(Duration(seconds: current + 10));
                //               }
                //               setState(() {});
                //             }, 
                //             icon: Icon(Icons.keyboard_double_arrow_right_rounded, size: 45, color: Colors.white,),
                //           ),
                //           IconButton(
                //             onPressed: (){
                //               if(widget.controller.value.isPlaying){
                //                 widget.controller.pause();
                //               }
                //               else{
                //                 widget.controller.play();
                //               }
                //               setState(() {});
                //             }, 
                //             icon: Icon(widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow_rounded, size: 45, color: Colors.white,),
                //           ),
                //           IconButton(
                //             onPressed: (){
                //               int current = widget.controller.value.position.inSeconds;
                //               if(current < 10){
                //                 widget.controller.seekTo(Duration(seconds: 0));
                //               }
                //               else{
                //                 widget.controller.seekTo(Duration(seconds: current - 10));
                //               }
                //               setState(() {});
                //             }, 
                //             icon: Icon(Icons.keyboard_double_arrow_left_rounded, size: 45, color: Colors.white,),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            // Slider(
            //   activeColor: mainColor,
            //   value: _currentSliderValue,
            //   max: widget.controller.value.duration.inSeconds.toDouble(),
            //   divisions: widget.controller.value.duration.inSeconds,
            //   label: _currentSliderValue.round().toString(),
            //   onChanged: (double value) {
            //     setState(() {
            //       _currentSliderValue = value;
            //       widget.controller.seekTo(Duration(seconds: value.toInt()));
            //       //widget.controller.play();
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}