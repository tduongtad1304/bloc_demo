import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter.dart';
import 'counter_view.dart';
import 'second_screen_view.dart';

class SumCountView extends StatelessWidget {
  const SumCountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SumCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Third Page | Sum View'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.toString(),
                  style: Theme.of(context).textTheme.headline3,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.restore),
                  label: const Text('Back to Initial First Page'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.looks_one),
                  label: const Text("Back to First Page"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.looks_two),
                  label: const Text("Back to Second Page"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.withAlpha(120),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
