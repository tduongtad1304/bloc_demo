import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';

import '../widgets/widgets.dart';
import 'second_screen_view.dart';
import 'sumcount_view.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('First Screen | BLoC'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<CounterCubit, CounterState>(
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
                return Text(
                  'Current Count Value: ' + state.counterValue.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                color: Colors.blue.withOpacity(0.8),
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
            Text(
              'Sum: ' + context.watch<SumCubit>().state.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.perm_contact_cal),
              key: const Key('update-name-and-count'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              label: const Text(
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
            ElevatedButton.icon(
                icon: const Icon(Icons.radio_button_checked_sharp),
                style: ElevatedButton.styleFrom(
                    primary: Colors.cyan.withBlue(150)),
                key: const Key('navigating-to-sum-view'),
                label: const Text(
                  'Sum Control Screen',
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
                            value: context.read<CounterCubit>(),
                          ),
                          BlocProvider.value(
                            value: context.read<TextConfirmCubit>(),
                          ),
                          BlocProvider.value(
                            value: context.read<SumCubit>(),
                          ),
                        ],
                        child: const SecondScreenView(),
                      ),
                    ),
                  );
                }),
            ElevatedButton.icon(
                icon: const Icon(Icons.add_circle_sharp),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(248, 141, 64, 230),
                ),
                key: const Key('navigating-to-only-sum-view'),
                label: const Text(
                  'Only Sum Screen',
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
                            value: context.read<CounterCubit>(),
                          ),
                          BlocProvider.value(
                            value: context.read<TextConfirmCubit>(),
                          ),
                          BlocProvider.value(
                            value: context.read<SumCubit>(),
                          ),
                        ],
                        child: const SumCountView(),
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
                color: Colors.blue.withOpacity(0.8),
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
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  //return custom snackBar
  SnackBar _snackBar({required String snackBarContent}) {
    return SnackBar(
      padding: const EdgeInsets.all(5),
      width: 180,
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(144, 8, 196, 221),
      content: Text(
        snackBarContent,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: const Duration(seconds: 1),
    );
  }
}
