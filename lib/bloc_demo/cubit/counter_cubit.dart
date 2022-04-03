import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'counter_state.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}

CounterState counterState =
    CounterState(counterValue: 0, wasIncremented: false);

class CounterCubit extends Cubit<CounterState> {
  /// {@macro counter_cubit}
  CounterCubit() : super(counterState);

  /// Add 1 to the current state and return true if the value was incremented.
  void increment(TextEditingController numberController) {
    if (numberController.text.isNotEmpty) {
      emit(CounterState(
          counterValue:
              state.counterValue + int.parse(numberController.value.text),
          wasIncremented: true));
    } else {
      emit(CounterState(
          counterValue: state.counterValue + 1, wasIncremented: true));
    }
  }

  /// Subtract 1 from the current state and return false if the value was decremented.
  void decrement(TextEditingController numberController) {
    if (numberController.text.isNotEmpty) {
      emit(CounterState(
          counterValue:
              state.counterValue - int.parse(numberController.value.text),
          wasIncremented: false));
    } else {
      emit(CounterState(
          counterValue: state.counterValue - 1, wasIncremented: false));
    }
  }

  /// Reset the current state to 0.
  void reset() => emit(CounterState(counterValue: 0));
}
