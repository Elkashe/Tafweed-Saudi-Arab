import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/performer_requests/performer_requests_cubit.dart';
import 'package:tafweed/cubits/track/track_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/loading.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class VideosSubmissionScreen extends StatefulWidget {
  final int requestIndex;
  const VideosSubmissionScreen({super.key, required this.requestIndex});

  @override
  State<VideosSubmissionScreen> createState() => _VideosSubmissionScreenState();
}

class _VideosSubmissionScreenState extends State<VideosSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    var performerReqCubit = BlocProvider.of<PerformerRequestsCubit>(context);
    print("----------------------");
    print(performerReqCubit.requests[widget.requestIndex].vidoes[0].link);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.upload_videos),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<PerformerRequestsCubit, PerformerRequestsState>(
          builder: (context, state) {
            if(state is LoadingVideoState){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loading(),
                    Text(AppLocalizations.of(context)!.uploading_video_in_progress),
                  ],
                ),
              );
            }
            else{
              return Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    bgColor: performerReqCubit.requests[widget.requestIndex].vidoes[0].link != "none" ?
                       Colors.green.shade600 : mainColor,
                    text: AppLocalizations.of(context)!.kaaba_reached,
                    onPressed: () {
                      performerReqCubit.sendVideo(widget.requestIndex, 1);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    bgColor: performerReqCubit.requests[widget.requestIndex].vidoes[1].link != "none" ?
                       Colors.green.shade600 : mainColor,
                    text: AppLocalizations.of(context)!.circumambulate_around_kaaba,
                    onPressed: () {
                      performerReqCubit.sendVideo(widget.requestIndex, 2);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    bgColor: performerReqCubit.requests[widget.requestIndex].vidoes[2].link != "none" ?
                       Colors.green.shade600 : mainColor,
                    text: AppLocalizations.of(context)!.saee_between_safa_and_marwah,
                    onPressed: () {
                      performerReqCubit.sendVideo(widget.requestIndex, 3);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    bgColor: performerReqCubit.requests[widget.requestIndex].vidoes[3].link != "none" ?
                       Colors.green.shade600 : mainColor,
                    text: AppLocalizations.of(context)!.hair_cutting,
                    onPressed: () {
                      performerReqCubit.sendVideo(widget.requestIndex, 4);
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    bgColor: performerReqCubit.videosCompleted(widget.requestIndex)?
                       mainColor : Colors.grey,
                    text: AppLocalizations.of(context)!.confirm_completion,
                    onPressed: performerReqCubit.videosCompleted(widget.requestIndex)? () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    } : (){},
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
