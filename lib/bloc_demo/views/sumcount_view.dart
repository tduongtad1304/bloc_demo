import 'package:bloc_demo/bloc_demo/views/second_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';

class SumCountView extends StatelessWidget {
  const SumCountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 117, 57, 185),
        title: const Text('Third Screen | Only Sum View'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<SumCubit>().state.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.restore),
              label: const Text(
                'Back to Initial State Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.looks_one),
              label: const Text(
                'Back to First Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.looks_two),
              label: const Text(
                'Back to Second Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan.withBlue(150)),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
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
                      child: const SecondScreenView(),
                    ),
                  ),
                  (route) => route.isFirst,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
