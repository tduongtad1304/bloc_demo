import 'package:bloc_demo/bloc_demo/counter.dart';
import 'package:bloc_demo/bloc_demo/views/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_textfield.dart';
import 'sumcount_view.dart';

class SecondScreenView extends StatelessWidget {
  const SecondScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _numberSumController = TextEditingController();
    return BlocConsumer<SumCubit, int>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Second Page | Sum Screen'),
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
              BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                return Text(
                  'Counter: ' + state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline5,
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sum: ' + state.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
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
                  ElevatedButton(
                    child: const Text("Increase Sum!"),
                    onPressed: () {
                      context
                          .read<SumCubit>()
                          .incrementSum(_numberSumController);
                    },
                  ),
                ],
              ),
              ElevatedButton(
                child: const Text("Go back to First Page with Sum value"),
                onPressed: () {
                  Navigator.of(context).pop(
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
                      ], child: const CounterView()),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar(
                      snackBarContent: 'Sum received from Second Page: ' +
                          state.toString()));
                },
              ),
              ElevatedButton(
                child: const Text("Reset Sum and back to First Page"),
                onPressed: () {
                  context.read<SumCubit>().resetSum();
                  Navigator.of(context).pop(
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
                      ], child: const CounterView()),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text("Only Sum Screen"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx_) => MultiBlocProvider(providers: [
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
    }, listener: (context, state) {
      if (state == 0) {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar(
            snackBarContent:
                'Sum received from Second Page: ' + state.toString()));
      }
    });
  }

  SnackBar _snackBar({
    required String snackBarContent,
  }) {
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
      duration: const Duration(seconds: 1, milliseconds: 500),
    );
  }
}
