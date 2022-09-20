import 'package:bus/consts/helpers/delegates/manager_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../view_model/accounts_info_view_model.dart';

class ManagersScreen extends StatefulWidget {
  const ManagersScreen({Key? key}) : super(key: key);

  @override
  State<ManagersScreen> createState() => _ManagersScreenState();
}

class _ManagersScreenState extends State<ManagersScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final provider = Provider.of<AccountsInfoViewModel>(context, listen: false);
    provider.getManagers();
    provider.getManagersNumber();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<AccountsInfoViewModel>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Managers",
        ),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: ManagerSearchDelegate(mHeight: mHeight,list:provider.managers!));
          }, icon: Icon(Icons.search))
        ],
      ),
      
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(2.w),
        child: FutureBuilder(
          future:provider.getManagers(),
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );

              case ConnectionState.done:

              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("error"),
                  );
                } else if (snapshot.hasData) {
                  return Column(children: [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total number",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.dp,
                                                                fontFamily: 'Cairo',

                                  fontWeight: FontWeight.bold),
                            ),

                            Text(
                              provider.managersNumber?.toString()??'0',
                              style: TextStyle(
                                  color: Colors.black,
                                                                fontFamily: 'Cairo',

                                  fontSize: 16.dp,
                                  fontWeight: FontWeight.bold),
                            ),
                            // IconButton(
                            //   alignment: Alignment.topCenter,
                            //   icon: Image.asset(
                            //     "assets/notification.png",
                            //     width: 24,
                            //   ),
                            //   onPressed: () {},
                            // )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 1.2.h,
                        child: ListView.builder(
                            itemCount: provider.managers!.length ,
                            itemBuilder: ((context, index) {
                              return ExpansionTile(
                                title: Text(
                                  provider.managers![index].userName,
                                  style: TextStyle(
                                      fontSize: 14.dp,
                                      fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.email_outlined,
                                      color: Colors.red,
                                    ),
                                    title: SelectableText(
                                        provider.managers![index].email,
                                        style: TextStyle(
                                                                        fontFamily: 'Cairo',

                                            fontSize: 13.dp)),
                                  ),
                                  ListTile(
                                      leading: Icon(
                                          Icons.phone_android_outlined,
                                          color: Colors.green),
                                      title: InkWell(
                                        onTap:()async{
                                          launch('tel://${  provider.managers![index]
                                                    .phoneNumber}');
                                        },
                                        child: Text(
                                            provider.managers![index]
                                                    .phoneNumber
                                              ,
                                            style: TextStyle(
                                                                            fontFamily: 'Cairo',

                                                fontSize: 14.dp)),
                                      ))
                                ],
                              );
                            })),
                      ),
                    )
                  ]);
                }else{
                  return Center(child: Text("noData"),);
                }
            }
          }),
        ),
      ),
    ));
  }
}
