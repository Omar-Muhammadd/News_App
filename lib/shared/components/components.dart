import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildArticleItem(BuildContext context, artical) {
  // ignore: prefer_typing_uninitialized_variables
  var image = artical['urlToImage'];
  if (artical['urlToImage'] != null) {
    image = artical['urlToImage'];
  } else {
    image =
        'https://www.pngkey.com/png/detail/282-2820067_taste-testing-at-baskin-robbins-empty-profile-picture.png';
  }
  return InkWell(
    onTap: () {
      navigateTo(
        context,
        launchUrl(
          Uri.parse(artical['url']),
        ),
      );
    },
    child: Row(
      // crossAxisAlignment: ,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                '$image',
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${artical['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${artical['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Container(
        color: Colors.grey,
        height: 1,
        width: double.infinity,
      ),
    );

Widget articleBuilder(cubit, {isSearch = false}) => Padding(
      padding: const EdgeInsets.all(25),
      child: ConditionalBuilder(
          condition: cubit.length > 0,
          builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildArticleItem(
                  context,
                  cubit[index],
                ),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.length,
              ),
          fallback: (context) => isSearch
              ? Center(
                  child: Container(
                  child: const Text(
                    'Empty',
                    style: TextStyle(color: Colors.grey),
                  ),
                ))
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                )),
    );

void navigateTo(BuildContext context, widget) {
  widget.then((value) {
  }).catchError((e) {
    throw 'Could not launch $widget';
  });
}
