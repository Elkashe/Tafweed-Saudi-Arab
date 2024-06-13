import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/prices/price_cubit.dart';
import 'package:tafweed/cubits/track/track_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/models/order.dart';
import 'package:tafweed/models/person_cases.dart';
import 'package:tafweed/models/request.dart';
import 'package:tafweed/models/request_video.dart';
import 'package:tafweed/screens/pdf_screen.dart';
import 'package:tafweed/screens/track_bodies/arrived_body.dart';
import 'package:tafweed/screens/track_bodies/cutting_hair_body.dart';
import 'package:tafweed/screens/track_bodies/safaAndMarwa_body.dart';
import 'package:tafweed/screens/track_bodies/tawaf_body.dart';
import 'package:tafweed/screens/video_screen.dart';
import 'package:tafweed/services/dio/pdf_services.dart';
import 'package:tafweed/services/dio/request_services.dart';
import 'package:tafweed/services/dio/video_services.dart';
import 'package:tafweed/widgets/custom_button.dart';
import 'package:tafweed/widgets/list_loading.dart';
import 'package:tafweed/widgets/order_row.dart';
import 'package:tafweed/widgets/track_line.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:video_player/video_player.dart';

class TrackScreen extends StatefulWidget {
  final Request request;
  const TrackScreen({super.key, required this.request});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  List<RequestVideo> videos = [];
  bool isLoading = false;
  bool recievedVideos = true;
  late Request myRequest;

  void getVideos() {
    recievedVideos = true;
    setState(() {
      isLoading = true;
    });
    VideoServices().getByRequest(widget.request.id!).then((response) async{ //widget.request.id!
      if (response != null) {
        RequestServices().getDetailsById(widget.request.id!).then((value){
          if(value != null){
            myRequest.paid = value.data["ServiceRequest"]["paid"];
            myRequest.cost = value.data["ServiceRequest"]["cost"];
            myRequest.personCase = PersonCase(
              arName: value.data["ServiceRequest"]["case_ar"],
              enName: value.data["ServiceRequest"]["case_en"],
              trName: value.data["ServiceRequest"]["case_tr"],
              idName: value.data["ServiceRequest"]["case_ind"],
              urName: value.data["ServiceRequest"]["case_ur"],
            );
            setState(() {});
          }
        });
        for (var videoJson in response.data["requestVideos"]) {
          videos.add(
            RequestVideo.fromJson(videoJson),
          );
          
        }
      } else {
        recievedVideos = false;
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myRequest = widget.request;
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    var lang = BlocProvider.of<LanguageCubit>(context).lang;
    var priceCubit = BlocProvider.of<PriceCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.request.personName.toString()),
        // leading: IconButton(
        //   onPressed: (){
        //     //trackCubit.back(context);
        //   },
        //   icon: const Icon(Icons.arrow_back),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Visibility(
          visible: recievedVideos,
          replacement: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.videocam_off_outlined,
                  size: 50,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 10,),
                CustomButton(
                  text: AppLocalizations.of(context)!.retry_again, 
                  onPressed: (){
                    getVideos();
                  },
                )
              ],
            ),
          ),
          child: !isLoading? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderRow(
                      title: AppLocalizations.of(context)!.request_number,
                      value: myRequest.id.toString(),
                    ),
                    SizedBox(height: 10,),
                    OrderRow(
                      title: AppLocalizations.of(context)!.beneficiary_name,
                      value: myRequest.personName.toString(),
                    ),
                    SizedBox(height: 10,),
                    OrderRow(
                      title: AppLocalizations.of(context)!.gender,
                      value: myRequest.gender == Gender.male ? 
                        AppLocalizations.of(context)!.male : AppLocalizations.of(context)!.female,
                    ),
                    SizedBox(height: 10,),
                    OrderRow(
                      title: AppLocalizations.of(context)!.status,
                      value: myRequest.personCase?.getName(lang) ?? "",
                    ),
                    SizedBox(height: 10,),
                    OrderRow(
                      title: AppLocalizations.of(context)!.type,
                      value: myRequest.package?.getName(lang) ?? "",
                    ),
                    SizedBox(height: 10,),
                    OrderRow(
                      title: AppLocalizations.of(context)!.date,
                      value: myRequest.getCreatedAt() ?? "",
                    ),
                    SizedBox(height: 10,),
                    OrderRow(
                      title: AppLocalizations.of(context)!.paid,
                      value: "${priceCubit.currency.sign} ${((double.parse(myRequest.paid!) * priceCubit.currency.rate).ceilToDouble()).toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: mainColor,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    AppLocalizations.of(context)!.follow_rituals,
                    style: TextStyle(
                      fontSize: 17,
                      color: mainColor
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, i){
                    return GestureDetector(
                      onTap: (){
                        if(videos[i].extension == "mp4"){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(controller: videos[i].controller!)));
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PdfScreen(path: videos[i].video!)));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              videos[i].getName(lang),
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                            videos[i].extension == "mp4" ? 
                            Icon(
                              Icons.play_arrow_rounded, 
                              size: 36, 
                              color: Colors.green,
                            ): FaIcon(FontAwesomeIcons.filePdf, color: Colors.green, ),
                          ]
                        ),
                      ),
                    );
                    // return Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Expanded(
                    //           child: Container(
                    //             height: 1,
                    //             color: Colors.grey[300],
                    //           ),
                    //         ),
                    //         SizedBox(width: 10,),
                    //         Text(
                    //           videos[i].getName(lang),
                    //           style: TextStyle(
                    //             fontSize: 17
                    //           ),
                    //         ),
                    //         SizedBox(width: 10,),
                    //         Expanded(
                    //           child: Container(
                    //             height: 1,
                    //             color: Colors.grey[300],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(height: 10,),
                    //     if(videos[i].extension == "mp4")
                    //     InkWell(
                    //       onTap: () async{
                    //         await Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(controller: videos[i].controller!)));
                    //         videos[i].controller?.pause();
                    //       },
                    //       borderRadius: BorderRadius.circular(6),
                    //       child: Stack(
                    //         children: [
                    //           SizedBox(
                    //             width: double.infinity,
                    //             height: 180,
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(6),
                    //               child: VideoPlayer(videos[i].controller!),
                    //             ),
                    //           ),
                    //           Opacity(
                    //             opacity: 0.6,
                    //             child: Container(
                    //               width: double.infinity,
                    //               height: 180,
                    //               decoration: BoxDecoration(
                    //                 color: Colors.black,
                    //                 borderRadius: BorderRadius.circular(6)
                    //               ),
                    //               child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 50,),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     if(videos[i].extension == "pdf")
                    //       GestureDetector(
                    //         onTap: (){
                    //           Navigator.push(context, MaterialPageRoute(builder: (context) => PdfScreen(path: videos[i].video!)));
                    //         },
                    //         child: Container(
                    //           width: double.infinity,
                    //           height: 60,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(6),
                    //             color: mainColor,
                    //           ),
                    //           child: Center(
                    //             child: FaIcon(FontAwesomeIcons.filePdf, color: Colors.white,),
                    //           ),
                    //         ),
                    //       ),
                    //   ],
                    // );
                  },
                  separatorBuilder: (context, i) => Divider(height: 10, color: Colors.grey[300],),
                  itemCount: videos.length,
                ),
              ),
            ],
          ) : ListLoading(),
        ),
      ),
    );
  }
}


// BlocBuilder<TrackCubit, TrackState>(
//         builder: (context, state) {
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     //   children: [
//                     //     Text(AppLocalizations.of(context)!.reached_kaaba),
//                     //     Text(AppLocalizations.of(context)!.circumambulate_around_kaaba, textAlign: TextAlign.center,),
//                     //     Text(AppLocalizations.of(context)!.saee_between_safa_and_marwah, textAlign: TextAlign.center,),
//                     //     Text(AppLocalizations.of(context)!.hair_cutting),
//                     //   ],
//                     // ),
//                     // const SizedBox(height: 20,),
//                     TrackLine(point: trackCubit.currentPage,),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20,),
//               Expanded(
//                 child: PageView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   controller: trackCubit.pageController,
//                   children: [
//                     // ArrivedBody(order: widget.order,),
//                     // TawafBody(order: widget.order,),
//                     // SafaAndMarwaBody(order: widget.order,),
//                     // CuttingHairBody(order: widget.order,),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
