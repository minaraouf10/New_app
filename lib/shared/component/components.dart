import 'dart:developer';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';


Widget defaultFormField(
    {required TextEditingController controller,
      required TextInputType type,
      bool isPassword = false,
      ValueChanged<String>? onSbmitted,
      ValueChanged<String>? onChanged,
      GestureTapCallback? onTap,
      required FormFieldValidator<String>? validate,
      required String label,
      required IconData prefix,
      IconData? suffix,
      VoidCallback? suffixPressed,
      bool isClickable = true}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSbmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );

void navigateTo (context,widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);


Widget bulidArticleItem(article,context) => InkWell (
  onTap: (){
    log('mina');
    navigateTo(context, WebViewExample(article['url']),);
  },
  child:   Padding (

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            Container(

              height: 120.0,

              width: 120.0,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.0),

                image: DecorationImage(

                    image: NetworkImage('${article['urlToImage']}'),

                    fit: BoxFit.cover),

              ),

            ),

            SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: Container(

                height: 120.0,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${article['title']}',

                        style: Theme.of(context).textTheme.bodyText1,

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                      ),

                    ),

                    Text(

                      '${article['publishedAt']}',

                      style: TextStyle(color: Colors.grey),

                    )

                  ],

                ),

              ),

            ),

          ],

        ),

      ),
);

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list,context,{isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => bulidArticleItem(list[index],context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) =>isSearch?Container(): Center(child: CircularProgressIndicator()),
    );
