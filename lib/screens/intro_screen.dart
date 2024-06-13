import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/packages/country_code/countries_info.dart';
import 'package:tafweed/widgets/custom_button.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    CountriesInfo.getCountriesInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    var langCubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){
              BlocProvider.of<LanguageCubit>(context).showLanguageBottomSheet(context);
            },
            child: Image.asset(
              "assets/images/اللغة-01.png",
              color: Colors.white,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
        ),
        title: Text(AppLocalizations.of(context)!.introduction),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.taffweed, 
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: "Alhadari"),
                          ),
                          SizedBox(height: 5,),
                          Text(AppLocalizations.of(context)!.authorization),
                        ],
                      ),
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                },
              );
            }, 
            icon: Icon(Icons.info_outline),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: OnBoardingSlider(
            headerBackgroundColor: Colors.white,
            finishButtonText: AppLocalizations.of(context)!.login,
            onFinish: (){
              Navigator.pushNamed(context, loginPath);
            },
            skipFunctionOverride: (){

            },
            finishButtonStyle: FinishButtonStyle(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              )
            ),
            //skipTextButton: Text('تخطي', style: TextStyle(color: mainColor),),
            background: [
              Container(),
              Container(),
              Container(),
              Container(),
            ],
            totalPage: 4,
            speed: 1.8,
            pageBodies: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/tawaf_vector.jpg",
                        width: 340,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(AppLocalizations.of(context)!.introduction, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text(AppLocalizations.of(context)!.we_are_happy, style: TextStyle(),),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/tawaf_vector5.jpg",
                            width: 300,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(AppLocalizations.of(context)!.our_goals, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text(AppLocalizations.of(context)!.opening_doors,),
                        
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/tawaf_vector6.jpg",
                            width: 300,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(AppLocalizations.of(context)!.values, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text(AppLocalizations.of(context)!.values_description,),
                        
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/tawaf_vector4.jpg",
                          width: 260,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(AppLocalizations.of(context)!.our_message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Text(AppLocalizations.of(context)!.facilitating_muslims,),
                      //SizedBox(height: 80,),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
        ),
      );
  }
}

// ListView(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.asset(
//                       "assets/images/rLogo.png",
//                       width: 100,
//                     ),
//                     SizedBox(height: 30,),
//                     Text(
//                       AppLocalizations.of(context)!.you,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.grey[700],
//                         height: 0.8,
//                       ),
//                     ),
//                     Text(
//                       AppLocalizations.of(context)!.umrah_student,
//                       style: TextStyle(
//                         fontSize: 40,
//                         color: mainColor,
//                         fontFamily: "Alhadari",
//                         height: 1.2,
//                       ),
//                     ),
//                     //SizedBox(height: 5,),
//                     Text(
//                       AppLocalizations.of(context)!.register_now,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Material(
//                 elevation: 6,
//                 shadowColor: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(6),
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     AppLocalizations.of(context)!.we_are_happy,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10,),
//               Material(
//                 elevation: 6,
//                 shadowColor: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(6),
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: ReadMoreText(
//                     AppLocalizations.of(context)!.authorization,
//                     trimLines: 5,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                     colorClickableText: mainColor,
//                     trimMode: TrimMode.Line,
//                     trimCollapsedText: AppLocalizations.of(context)!.more,
//                     trimExpandedText: AppLocalizations.of(context)!.less,
//                     moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainColor),
//                     lessStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainColor),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               CustomButton(
//                 text: AppLocalizations.of(context)!.next, 
//                 onPressed: (){
//                   Navigator.pushNamed(context, ourGoalPath);
//                 },
//               )
//             ],
//           )