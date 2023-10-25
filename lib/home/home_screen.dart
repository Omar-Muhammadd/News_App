import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import '../shared/cubit/cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        Icon modeIcon = cubit.isMode
            ? const Icon(Icons.light_mode_outlined)
            : const Icon(Icons.dark_mode_outlined);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => searchScreen()),
                  );
                },
                icon: const Icon(
                  Icons.search_rounded,
                ),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeMode();
                },
                icon: modeIcon,
              ),
            ],
          ),
          body: cubit.screens[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.BottomItem,
          ),
        );
      },
    );
  }
}
