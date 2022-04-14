import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user.dart';

part 'text_confirm_state.dart';

TextConfirmState textConfirmState = TextConfirmState(user: User(name: 'Tad'));

class TextConfirmCubit extends Cubit<TextConfirmState> {
  TextConfirmCubit() : super(textConfirmState);

  void setName(TextEditingController nameController, int counter) {
    textConfirmState =
        TextConfirmState(user: User(name: nameController.text, count: counter));
    emit(textConfirmState);
  }
}
