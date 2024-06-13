// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/track/track_cubit.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/models/video.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:video_player/video_player.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class SafaAndMarwaBody extends StatefulWidget {
  final Order order;
  const SafaAndMarwaBody({super.key, required this.order});

  @override
  State<SafaAndMarwaBody> createState() => _SafaAndMarwaBodyState();
}

class _SafaAndMarwaBodyState extends State<SafaAndMarwaBody> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TrackCubit>(context).initSafaAndMarwaController();
  }

  @override
  Widget build(BuildContext context) {
    var trackCubit = BlocProvider.of<TrackCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "سعى المؤدي بين الصفا والمرة 🕋",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20,),
          BlocBuilder<TrackCubit, TrackState>(
            builder: (context, state){
              if(state is InitSafaAndMarwaState){
                return InkWell(
                  onTap: () async{
                    await Navigator.pushNamed(context, videoPath ,arguments: trackCubit.safaAndMarwaController);
                    trackCubit.safaAndMarwaController?.pause();
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: VideoPlayer(trackCubit.safaAndMarwaController!),
                        ),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 50,),
                        ),
                      ),
                    ],
                  ),
                );
              }
              else if(state is FailSafaAndMarwaState){
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "حدث خطأ, حاول مرة اخرى لأظهار الفيديو",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          trackCubit.initSafaAndMarwaController(init: true);
                        }, 
                        icon: Icon(Icons.loop),
                      )
                    ],
                  ),
                );
              }
              else{
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                );
              }
            },
          ),
          Spacer(),
          CustomButton(
            bgColor: widget.order.vidoes[3].approved ? mainColor : Colors.grey.shade400,
            text: "التالي", 
            onPressed: widget.order.vidoes[3].approved ?(){
              trackCubit.next();
            } : (){},
          )
        ],
      ),
    );
  }
}