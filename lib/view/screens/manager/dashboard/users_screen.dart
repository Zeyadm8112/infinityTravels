import 'package:bus/consts/helpers/delegates/users_search.dart';
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

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    final provider = Provider.of<AccountsInfoViewModel>(context, listen: false);
    provider.getUsers();
    provider.getUsersNumber();

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
          "Users",
        ),
                actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: UserSearchDelegate(mHeight: mHeight,list:provider.users!));
          }, icon: Icon(Icons.search))
        ],

      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: FutureBuilder(
          future: provider.getUsers(),
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
                                  fontSize: 27.dp,
                                  fontWeight: FontWeight.bold),
                            ),

                            Text(
                              provider.usersNumber?.toString()??'0' ,
                              style: TextStyle(
                                  color: Colors.black,
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
                        height: mHeight,
                        child: FutureBuilder(
                          future: provider.getUsers(),
                          builder: (context,snapshot) {
                                                          switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.blue),
                                  );

                                case ConnectionState.done:

                                default:
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text("error"),
                                    );
                                  } else if (snapshot.hasData) {

                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: provider.users!.length ,
                                itemBuilder: ((context, index) {
                                  return ExpansionTile(
                                    title: Text(
                                      provider.users![index].userName,
                                      style: TextStyle(
                                          fontSize: 15.dp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.email_outlined,
                                          color: Colors.red,
                                        ),
                                        title: SelectableText(
                                            provider.users?[index].email,
                                            style: TextStyle(
                                                fontSize: 15.dp)),
                                      ),
                                      ListTile(
                                          leading: Icon(
                                              Icons.phone_android_outlined,
                                              color: Colors.green),
                                          title: InkWell(
                                              onTap: () async {
                                                launch(
                                                    'tel://${provider.users![index].phoneNumber}');
                                              },
                                              child: Text(
                                                  provider
                                                      .users?[index].phoneNumber,
                                                  style: TextStyle(
                                                      fontSize: 15.dp))))
                                    ],
                                  );
                                }));
                          }                                  else {
                                    return Text("noData");
                                  }

                    }}    ),
                      ),
                    )
                  ]);
                } else {
                  return Center(
                    child: Text("no data"),
                  );
                }
            }
          }),
        ),
      ),
    ));
  }
}
