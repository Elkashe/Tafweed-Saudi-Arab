import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  Gender selectedGender = Gender.male;
  Gender goalGender = Gender.male;

  GenderCubit() : super(GenderInitial()){
    selectedGender = Cache.getGender();
  }

  void changeGender(Gender gender){
    selectedGender = gender;
    Cache.setGender(gender);
    emit(GenderChanged());
  }

  void setGoalGender(Gender gender){
    goalGender = gender;
    emit(GenderChanged());
  }
}
