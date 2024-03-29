import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import 'counter_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<TextConfirmCubit>(
          create: (context) => TextConfirmCubit(),
        ),
        BlocProvider<SumCubit>(
          create: (context) => SumCubit(),
        ),
      ],
      child: const CounterView(),
    );
  }
}
