import 'package:bus/consts/helpers/delegates/Admins_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/accounts_info_view_model.dart';

class AdminsScreen extends StatefulWidget {
  const AdminsScreen({Key? key}) : super(key: key);

  @override
  State<AdminsScreen> createState() => _AdminsScreenState();
}

class _AdminsScreenState extends State<AdminsScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    final provider = Provider.of<AccountsInfoViewModel>(context,listen: false);
    provider.getAdmins();
    provider.getAdminsNumber();


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AccountsInfoViewModel>(context);


    return SafeArea(
      
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Admins",),
                  actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: AdminSearchDelegate(mHeight: 0,list:provider.admins!));
          }, icon: Icon(Icons.search))
        ],

        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding:  EdgeInsets.all(2.w),
          child: Column(children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding:  EdgeInsets.only(bottom: 1.h),
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
                                  
                                  Text(provider.adminsNumber?.toString()??'0',style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.dp,
                                          fontFamily: 'Cairo',
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
                height:  1.2.h,
                child: FutureBuilder(
                  future: provider.getAdmins(),
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
                      itemCount: provider.admins!.length,
                      itemBuilder: ((context, index) {
                        return ExpansionTile(title: Text(provider.admins?[index].userName??"",style: TextStyle(fontSize: 15.dp,fontWeight: FontWeight.bold,fontFamily: 'Cairo' ),),
                        children: [
                          ListTile(
                            leading: Icon(Icons.email_outlined,color: Colors.red,),
                            title:SelectableText(provider.admins?[index].email??"",style: TextStyle(fontSize:  15.dp,fontFamily: 'Cairo') ),
                          ),
                                            ListTile(
                            leading: Icon(Icons.phone_android_outlined,color:Colors.green),
                            title:SelectableText( provider.admins?[index].phoneNumber??"",style: TextStyle(fontSize: 15.dp,fontFamily: 'Cairo') ))
                          
              
                        ],
                        
                        );
                      }
                      
                    ));
                  }                                  else {
                                    return Text("noData");
                                  }

   }} ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}