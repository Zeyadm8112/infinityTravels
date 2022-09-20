import 'package:bus/consts/app_colors.dart';
import 'package:bus/view/widgets/anim_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../consts/helpers/delegates/manager_search.dart';
import '../../../view_model/accounts_info_view_model.dart';
import '../../widgets/drawer.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/manager_card_info.dart';
import '../../widgets/menu_bar_widget.dart';

class ManagersInfoScreen extends StatefulWidget {
  const ManagersInfoScreen({Key? key}) : super(key: key);

  @override
  State<ManagersInfoScreen> createState() => _ManagersInfoScreenState();
}

class _ManagersInfoScreenState extends State<ManagersInfoScreen> {
  @override
  void initState() {
    final provider = Provider.of<AccountsInfoViewModel>(context, listen: false);
    provider.getManagers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<AccountsInfoViewModel>(context);

    return SafeArea(
        child: ZoomDrawer(
            menuBackgroundColor: Colors.white,
            menuScreen: MyDrawer(),
            mainScreen: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  title: Text(
                    'Managers',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'BebasNeue',
                        fontSize: 25.dp),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: ManagerSearchDelegate(
                                  mHeight: mHeight, list: provider.managers!));
                        },
                        icon: Icon(Icons.search)),
                  ],
                  leading: MenuWidget(AppColors.primaryColor),
                ),
                body: Column(children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 100.h,
                      child: FutureBuilder(
                          future: provider.getManagers(),
                          builder: (context, snapshot) {
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
                                                                    if(provider.managers!.isEmpty){
return EmptyWidget();

                                  }else{

                                  return ListView.builder(
                                      itemCount: provider.managers!.length ,
                                      itemBuilder: ((context, index) {
                                        return ExpansionTile(
                                          title: Text(
                                            provider.managers![index]
                                                    .userName ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 15.dp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'RobotoCondensed'),
                                          ),
                                          children: [
                                            ListTile(
                                              leading: Icon(
                                                Icons.email_outlined,
                                                color: AppColors.secondaryColor,
                                              ),
                                              title: SelectableText(
                                                  provider.managers![index]
                                                          .email 
                                                      ,
                                                  style: TextStyle(
                                                      fontSize: 13.dp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontFamily: 'Cairo')),
                                            ),
                                            ListTile(
                                                leading: Icon(
                                                    Icons
                                                        .phone_android_outlined,
                                                    color: AppColors
                                                        .secondaryColor),
                                                title: InkWell(
                                                  onTap: (){
                                                                                              launch('tel://${  provider.managers![index]
                                                    .phoneNumber}');

                                                  },
                                                  child: Text(
                                                      provider.managers![index].phoneNumber
                                                              
                                                      ,    
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontSize: 13.dp,
                                                          fontFamily: 'Cairo')),
                                                ))
                                          ],
                                        );
                                      }));
                              }  } else {
                                  return Center(
                                    child: Text("No data"),
                                  );
                                }
                            }
                          }),
                    ),
                  )
                ]))));
  }
}
