import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../counter.dart';

import '../widgets/custom_textfield.dart';
import 'second_screen_view.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _numberController = TextEditingController();

    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        if (state.counterValue != 0 && state.wasIncremented == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            _snackBar(
                snackBarContent:
                    'Increase to ' + state.counterValue.toString()),
          );
        }
        if (state.counterValue != 0 && state.wasIncremented == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            _snackBar(
                snackBarContent:
                    'Decrease to ' + state.counterValue.toString()),
          );
        }
        if (state.counterValue == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            _snackBar(snackBarContent: 'Return to 0'),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('First Page | BLoC'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Count Value: ' + state.counterValue.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: _nameController,
                    isAlign: false,
                    keyboardType: TextInputType.name,
                    labelText: 'Enter your name',
                    fontSize: 19,
                  ),
                ),
                BlocConsumer<TextConfirmCubit, TextConfirmState>(
                    builder: ((context, state) {
                  return Column(
                    children: [
                      Text(
                        'Name: ' + state.user.name.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'Stored Count: ' + state.user.count.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  );
                }), listener: (context, state) {
                  if (state.user.name!.isNotEmpty || state.user.count != 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      _snackBar(
                          snackBarContent: 'Name: ' +
                              state.user.name.toString() +
                              '\nStored Count: ' +
                              state.user.count.toString()),
                    );
                  }
                }),
                BlocBuilder<SumCubit, int>(
                  builder: (context, state) {
                    return Text(
                      'Sum: ' + state.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  key: const Key('update-name-and-count'),
                  child: const Text(
                    'Update Name & Stored Count',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () {
                    context.read<TextConfirmCubit>().setName(
                          _nameController,
                          context.read<CounterCubit>().state.counterValue,
                        );
                  },
                ),
                ElevatedButton(
                    key: const Key('navigating-to-sum-view'),
                    child: const Text(
                      'Sum Screen',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: BlocProvider.of<CounterCubit>(context),
                              ),
                              BlocProvider.value(
                                value:
                                    BlocProvider.of<TextConfirmCubit>(context),
                              ),
                              BlocProvider.value(
                                value: BlocProvider.of<SumCubit>(context),
                              ),
                            ],
                            child: const SecondScreenView(),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Enter a number '),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CustomTextField(
                    fontSize: 15,
                    isAlign: true,
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: 'increment',
                backgroundColor: Colors.green,
                key: const Key('counterView_increment_floatingActionButton'),
                child: const Icon(
                  Icons.add,
                ),
                onPressed: () =>
                    context.read<CounterCubit>().increment(_numberController),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'decrement',
                backgroundColor: Colors.red,
                key: const Key('counterView_decrement_floatingActionButton'),
                child: const Icon(
                  Icons.remove,
                ),
                onPressed: () =>
                    context.read<CounterCubit>().decrement(_numberController),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'reset',
                backgroundColor: Colors.grey,
                key: const Key('counterView_reset_floatingActionButton'),
                child: const Icon(
                  Icons.restart_alt,
                ),
                onPressed: () => context.read<CounterCubit>().reset(),
              ),
            ],
          ),
        );
      },
    );
  }

  //return custom snackBar
  SnackBar _snackBar({required String snackBarContent}) {
    return SnackBar(
      padding: const EdgeInsets.all(5),
      width: 140,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 1,
      content: Text(
        snackBarContent,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      duration: const Duration(seconds: 1),
    );
  }
}
