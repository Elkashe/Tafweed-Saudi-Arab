import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/cubits/language/language_cubit.dart';
import 'package:tafweed/cubits/order/order_cubit.dart';
import 'package:tafweed/cubits/packages/packages_cubit.dart';
import 'package:tafweed/cubits/prices/price_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/screens/new_order_screen.dart';
import 'package:tafweed/widgets/list_loading.dart';
import 'package:tafweed/widgets/loading.dart';
import 'package:tafweed/widgets/package_card.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class PackagesBody extends StatefulWidget {
  const PackagesBody({super.key});

  @override
  State<PackagesBody> createState() => _PackagesBodyState();
}

class _PackagesBodyState extends State<PackagesBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String lang = BlocProvider.of<LanguageCubit>(context).lang;
    BlocProvider.of<PackagesCubit>(context).getPackages(context, lang);
  }

  @override
  Widget build(BuildContext context) {
    var lang = BlocProvider.of<LanguageCubit>(context).lang;
    var packageCubit = BlocProvider.of<PackagesCubit>(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  if (state is LoadingPackagesState) {
                    return ListLoading();
                  } else if (state is SuccessPackagesState) {
                    return ListView.separated(
                      itemBuilder: (context, i){
                        return PackageCard(
                          text: packageCubit.packages[i].getName(lang),
                          image: packageCubit.packages[i].image ?? "assets/images/kaaba2.jpg",
                          price: packageCubit.packages[i].cost!,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => 
                              NewOrderScreen(package: packageCubit.packages[i])));
                            // orderCubit.orderType = OrderType.ramadan;
                            // Navigator.pushNamed(
                            //   context,
                            //   newOrderPath,
                            //   arguments: ramadanPackageOriginalPrice,
                            // );
                          }
                        );
                      },
                      separatorBuilder: (context, i) => SizedBox(height: 10,),
                      itemCount: packageCubit.packages.length,
                    );
                  }
                  else{
                    return Center(
                      child: TextButton(
                        onPressed: (){
                          String lang = BlocProvider.of<LanguageCubit>(context).lang;
                          BlocProvider.of<PackagesCubit>(context).getPackages(context, lang);
                        }, 
                        child: Text(
                          AppLocalizations.of(context)!.retry_again,
                          style: TextStyle(
                            fontSize: 18,
                            color: mainColor,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
