import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

// part 'sum_state.dart';

class SumCubit extends Cubit<int> {
  SumCubit() : super(0);

  void incrementSum(TextEditingController numberSumController) {
    if (numberSumController.text.isNotEmpty) {
      emit(state + int.parse(numberSumController.text));
    } else {
      emit(state + 1);
    }
  }

  void resetSum() {
    emit(0);
  }
}
