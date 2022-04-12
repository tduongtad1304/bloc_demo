import 'package:bloc_demo/bloc_demo/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_textfield.dart';
import 'sumcount_view.dart';

class SecondScreenView extends StatelessWidget {
  const SecondScreenView({Key? key}) : super(key: key);

  SnackBar _snackBar({
    required String snackBarContent,
  }) {
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
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _numberSumController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan.withBlue(150),
        centerTitle: true,
        title: const Text(
          'Second Screen | Sum Control Screen',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<TextConfirmCubit, TextConfirmState>(
                builder: (context, state) {
              return Text(
                'Name: ' + state.user.name.toString(),
                style: Theme.of(context).textTheme.headline5,
              );
            }),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<CounterCubit, CounterState>(builder: (context, state) {
              return Text(
                'Counter: ' + state.counterValue.toString(),
                style: Theme.of(context).textTheme.headline5,
              );
            }),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<SumCubit, int>(builder: (context, state) {
              return Text(
                'Sum: ' + state.toString(),
                style: Theme.of(context).textTheme.headline5,
              );
            }, listener: (context, state) {
              if (state == 0) {
                ScaffoldMessenger.of(context).showSnackBar(_snackBar(
                    snackBarContent:
                        'Sum received from Second Page: ' + state.toString()));
              }
            }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter a number '),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CustomTextField(
                      color: Colors.cyan.withBlue(150),
                      fontSize: 15,
                      isAlign: true,
                      controller: _numberSumController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  label: const Text(
                    'Increase Sum!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    context.read<SumCubit>().incrementSum(_numberSumController);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SumCubit, int>(
              builder: (context, state) {
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.cyan.withBlue(150)),
                  icon: const Icon(Icons.looks_one),
                  label: const Text(
                    'Go back to First Page with Sum value',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst
                        // MaterialPageRoute(
                        //   builder: (ctx) => MultiBlocProvider(providers: [
                        //     BlocProvider.value(
                        //       value: BlocProvider.of<CounterCubit>(context),
                        //     ),
                        //     BlocProvider.value(
                        //       value: BlocProvider.of<TextConfirmCubit>(context),
                        //     ),
                        //     BlocProvider.value(
                        //       value: BlocProvider.of<SumCubit>(context),
                        //     ),
                        //   ], child: const CounterView()),
                        // ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(_snackBar(
                        snackBarContent: 'Sum received from Second Page: ' +
                            state.toString()));
                  },
                );
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.repeat_one_outlined),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              label: const Text(
                'Reset Sum and back to First Page',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                context.read<SumCubit>().resetSum();
                Navigator.of(context).popUntil((route) => route.isFirst
                    // MaterialPageRoute(
                    //   builder: (ctx) => MultiBlocProvider(providers: [
                    //     BlocProvider.value(
                    //       value: BlocProvider.of<CounterCubit>(context),
                    //     ),
                    //     BlocProvider.value(
                    //       value: BlocProvider.of<TextConfirmCubit>(context),
                    //     ),
                    //     BlocProvider.value(
                    //       value: BlocProvider.of<SumCubit>(context),
                    //     ),
                    //   ], child: const CounterView()),
                    // ),
                    );
              },
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(248, 141, 64, 230),
              ),
              icon: const Icon(Icons.looks_3),
              label: const Text(
                'Only Sum Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MultiBlocProvider(providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<CounterCubit>(context),
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<TextConfirmCubit>(context),
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<SumCubit>(context),
                      ),
                    ], child: const SumCountView()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
