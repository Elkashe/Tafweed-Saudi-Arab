import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/widgets/custom_button.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class OurGoalScreen extends StatelessWidget {
  const OurGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.our_message),
        actions: [
          InkWell(
            onTap: (){
              BlocProvider.of<LanguageCubit>(context).showLanguageBottomSheet(context);
            },
            child: Image.asset(
              "assets/images/اللغة-01.png",
              width: 30,
              color: Colors.white,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/rLogo.png",
                      width: 100,
                    ),
                    //SizedBox(height: 30,),
                    // Text(
                    //   "أنت",
                    //   style: TextStyle(
                    //     fontSize: 26,
                    //     color: Colors.grey[700],
                    //     height: 0.5,
                    //   ),
                    // ),
                    // Text(
                    //   "رسالتنا",
                    //   style: TextStyle(
                    //     fontSize: 40,
                    //     color: mainColor,
                    //     fontFamily: "Alhadari",
                    //     height: 0.5,
                    //   ),
                    // ),
                    // SizedBox(height: 20,),
                    // Text(
                    //   "سجل الأن بكل سهولة لطلب عمرتك الأن 🕋",
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            // ReadMoreText(
            //   "التيسير على المسلمين من كل بقاع الأرض عن طريق حلول تقنية متطورة تساعدهم فى تحصيل.الأجر والثواب والنفع فى الدنيا والآخرة : أهدافنا (فتح باب البشرى والأمل أمام المسلمين (المستفيدين من خدماتنا لتحصيل الثواب والأجر وتحقيق مبدأ وتعاونوا تقديم نموذج تقنى متطور يخدم إحتياجات مجتمعاتنا العربية والإسلامية قيمناالتعاون بين أفراد المجتمعات واجب وضرورة وليس من المثاليات .الدلالة على الخير من أوجب واجبات الأمة التيسير على أفراد الأمة خاصة أصحاب الرخص منهم حق نسعى لإيصاله لمستحقيه",
            //   trimLines: 3,
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            //   colorClickableText: mainColor,
            //   trimMode: TrimMode.Line,
            //   trimCollapsedText: "...المزيد",
            //   trimExpandedText: '...أقل',
            //   moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainColor),
            //   lessStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainColor),
            // ),
            Material(
              elevation: 6,
              shadowColor: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.our_message,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.facilitating_muslims,
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Material(
              elevation: 6,
              shadowColor: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.our_goals,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.opening_doors,
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            CustomButton(
              text: AppLocalizations.of(context)!.next, 
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, loginPath, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}