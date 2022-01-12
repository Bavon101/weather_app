import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/resources/repository.dart';
import 'package:weather_app/src/resources/weather_bloc.dart';
import 'package:weather_app/src/short_calls.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<WeatherBloc>(context),
        builder: (context, state) {
          if (state is WeatherfetchedState) {
            return Scaffold(
              body: Container(
                width: width(context),
                height: height(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/forest_sunny.png"),
                        fit: BoxFit.cover)),
                child: Stack(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
