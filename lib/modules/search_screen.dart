import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class searchScreen extends StatefulWidget {
  searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = NewsCubit.get(context).search;
        var mode = NewsCubit.get(context).isMode;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  style: TextStyle(
                    color: mode ? Colors.white : Colors.black,
                  ),
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'search most not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    enabled: true,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(cubit, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
