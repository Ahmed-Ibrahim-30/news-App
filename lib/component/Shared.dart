import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Layouts/Web_View_Screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget newsApi({required List<dynamic>allNews}){
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    separatorBuilder: (context,index)=>const SizedBox(height: 5,),
    itemCount: allNews.length,
    itemBuilder: (context,index)=>InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_)=> Web_View(url: allNews[index]['url'],))
        );
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.3)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: allNews[index]['image']!=null?
                      NetworkImage(allNews[index]['image']):
                      const AssetImage("assets/images/noimage.png")as ImageProvider,
                    )
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        allNews[index]['title'],
                        style: Theme.of(context).textTheme.headline1,
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(height: 9.0,),
                    Text(
                      allNews[index]['published_at'],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}