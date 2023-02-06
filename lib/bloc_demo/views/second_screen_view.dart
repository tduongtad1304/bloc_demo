import 'package:bloc_demo/bloc_demo/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';
import 'sumcount_view.dart';

class SecondScreenView extends StatelessWidget {
  const SecondScreenView({Key? key}) : super(key: key);

  static String secondRoute = '/second';
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
            Text(
              'Name: ' +
                  context.watch<TextConfirmCubit>().state.user.name.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Counter: ' +
                  context.watch<CounterCubit>().state.counterValue.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Sum: ' + context.watch<SumCubit>().state.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter a number'),
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
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  label: const Text(
                    'Increase Sum!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => context
                      .read<SumCubit>()
                      .incrementSum(_numberSumController),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan.withBlue(150)),
              icon: const Icon(Icons.looks_one),
              label: const Text(
                'Go back to First Page with Sum value',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                ScaffoldMessenger.of(context).showSnackBar(snackBar(
                    snackBarContent: 'Sum received from Second Page: ' +
                        context.read<SumCubit>().state.toString()));
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.repeat_one_outlined),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              label: const Text(
                'Reset Sum and back to First Page',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                context.read<SumCubit>().resetSum();
                Navigator.of(context).popUntil((route) => route.isFirst);
                ScaffoldMessenger.of(context).showSnackBar(snackBar(
                    snackBarContent: 'Sum received from Second Page: ' +
                        context.read<SumCubit>().state.toString()));
              },
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(248, 141, 64, 230)),
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
                    builder: (ctx) => MultiBlocProvider(
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
