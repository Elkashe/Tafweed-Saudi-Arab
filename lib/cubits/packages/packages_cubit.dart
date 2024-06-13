import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tafweed/models/package.dart';
import 'package:tafweed/screens/login_screen.dart';
import 'package:tafweed/services/dio/home_packages_services.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  List<Package> packages = []; // [ object from package, object from package, object from package,object from package ]

  PackagesCubit() : super(PackagesInitial());

  void getPackages(BuildContext context, String langCode) async{
    if(packages.isNotEmpty) return;
    try{
      emit(LoadingPackagesState());
      HomePackageServices().get().then((response){
        if(response != null){
          //Map<String, dynamic> data = response.data;
          for(var p in response.data['services']){ // [ {}, {}, {}, {}, {} ]
            Package newPackage = Package.fromJson(p);
            packages.add(newPackage);
          }
          emit(SuccessPackagesState());
        }
        else{
          emit(FailPackagesState());
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
        }
      });
    }
    catch(e){
      emit(FailPackagesState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
    }
  }

  
}
