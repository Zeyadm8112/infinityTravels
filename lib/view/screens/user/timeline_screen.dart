import 'package:bus/view/widgets/anim_error_widget.dart';
import 'package:bus/view/widgets/drawer.dart';
import 'package:bus/view_model/post_view_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../consts/app_colors.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/menu_bar_widget.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PostsViewModel>(context);

    return ZoomDrawer(
      menuScreen: MyDrawer(),
      mainScreen: Scaffold(
        backgroundColor: Colors.white.withOpacity(.4),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Posts',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: 'BebasNeue',
                fontSize: 25.dp),
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         // showSearch(context: context, delegate: TravelsSearchDelegate(mHeight: mHeight,list:provider.travels!));
          //       },
          //       icon: Icon(Icons.search)),
          // ],
          leading: MenuWidget(AppColors.primaryColor),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Column(children: [
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100.h,
                child: FutureBuilder(
                    future: provider.getPosts(),
                    builder: ((context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor),
                          );

                        case ConnectionState.done:

                        default:
                          if (snapshot.hasError) {
                            return ErrorAnimWidget();
                          } else if (snapshot.hasData) {
                            if (provider.posts!.isEmpty) {
                              return EmptyWidget();
                            } else {
                              return SizedBox(
                                height: 73.h,
                                child: ListView.builder(
                                  itemCount: provider.posts!.length,
                                  itemBuilder: ((context, index) => Card(
                                    elevation: 5,
                                          child: ExpansionTile(
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                         'by ${provider.posts![index].userName}',
                                              style: TextStyle(
                                                  color: AppColors.primaryColor
                                                      .withOpacity(.8),
                                                  fontFamily: 'Cairo',
                                                  fontSize: 16.dp,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Text(
                                              provider.posts![index].time,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14.dp,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            // Text(provider.posts![index].userName),
                                          ],
                                        ),
                                        title: Text(
                                          provider.posts![index].header,
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 18.dp,
                                              fontFamily: 'Cairo'),
                                        ),
                                        children: [
                                          SizedBox(
                                            width: 100.w,
                                            height: 50.h,
                                            child: ListView(
                                              scrollDirection: Axis.vertical,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(2.w),
                                                  child: ExpandableText(
                                                    provider.posts![index].text,
                                                    expandOnTextTap: true,
                                                    expandText: 'Show More',
                                                    collapseText: 'Show less',
                                                  ),
                                                )
                                              ],
                                            ),
                                          )

                                          //   Container(

                                          //     color:Colors.amber ,

                                          //     height: 60.h ,

                                          //     width: 100.w,

                                          //     child: AutoSizeText(

                                          //   'A really long String  A really long String A really long String A really long String A really long String A really long String A really long String A really long String A really long String A really long String A really long String A really long String A really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long StringA really long String',

                                          //   style: TextStyle(fontSize:30.dp,letterSpacing: 1),

                                          //   minFontSize: 13,

                                          //   // stepGranularity: 10,

                                          //   maxLines: 14,

                                          //   overflow: TextOverflow.ellipsis,

                                          // ) ,

                                          //   )
                                        ],
                                      ))),
                                ),
                              );
                            }
                          } else {
                            return Text("noData");
                          }
                      }
                    })),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
