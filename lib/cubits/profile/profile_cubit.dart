
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafweed/constants.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/services/dio/auth_services.dart';
import 'package:tafweed/widgets/custom_snackbar.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:tafweed/widgets/loading.dart';
part 'profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  late String name;
  late String phone;
  late String password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileCubit() : super(ProfileInitial()){
    name = Cache.getName() ?? "الأسم";
  }

  void onEdit(BuildContext context) async{
    try{
      formKey.currentState!.save();
      if(password.isEmpty){
        return;
      }
      Map<String, dynamic> data = {
        "user_id": Cache.getUserId(),
        "new_password": password,
      };
      emit(LoadingState());
      AuthServices().edit(data).then((response){
        if(response != null){
          // Cache.setName(name);
          // Cache.setPhone(phone);
          emit(SuccessState());
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.data_modified, Colors.green));
        }
        else{
          throw();
        }
      });
    }
    catch(e){
      emit(FailState());
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.red));
    }
  }

  void deleteDialog(BuildContext context){
    Widget okButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.confirmation,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: ()  async{
        emit(LoadingState());
        var response = await AuthServices().deleteAccount(Cache.getToken()!);
        if(response != null){
          emit(SuccessState());
          Cache.clear().then((value){
            Navigator.pushNamedAndRemoveUntil(context, loginPath, (route) => false);
          });
        }
        else{
          emit(FailState());
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar(AppLocalizations.of(context)!.retry_again, Colors.green));
        }
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      title: Text(AppLocalizations.of(context)!.sure_delete_account),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.your_account_will_be_deleted_forever),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state){
              if(state is LoadingState){
                return Center(child: Loading(),);
              }
              else return Container();
            },
          )
        ],
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
