import 'package:bus/view/screens/manager/dashboard/widgets/grid_dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../view_model/accounts_info_view_model.dart';
// import 'grid_dashboard.dart';

class AdminDashBoardScreen extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<AdminDashBoardScreen> {
  @override
  void initState() {
    final provider = Provider.of<AccountsInfoViewModel>(context, listen: false);
    provider.getAccountsDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<AccountsInfoViewModel>(context);

    List<Data> data = [
      Data(
          name: 'Admins',
          percent: provider.adminsPercent?.toDouble() ?? 1.0,
          color: Colors.blue),
      Data(
          name: 'Managers',
          percent: provider.managersPercent?.toDouble() ?? 1.0,
          color: Colors.orange),
      Data(
          name: 'Users',
          percent: provider.usersPercent?.toDouble() ?? 1.0,
          color: Colors.green),
    ];

    List<PieChartSectionData> getSections() => data
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
              color: data.color,
              value: data.percent,
              title: '${data.percent}%',
              titleStyle: TextStyle(color: Colors.white));
          return MapEntry(index, value);
        })
        .values
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Dashboard",
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 27.dp),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {
                  sharedPref!.remove('name');
                  sharedPref!.remove('roleName');
                  sharedPref!.remove('userId');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LoginScreen', (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(5.w),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.5.w, right: 0.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Travels",
                          style: TextStyle(
                            fontFamily: 'Uchen',
                            color: Colors.black,
                            fontSize: 20.dp,
                          ),
                        ),
                        // SizedBox(
                        //   height: mHeight * 0.02,
                        // ),
                        // Text("DashBoardScreen",
                        //     style: TextStyle(
                        //         color: Color(0xffa29aac),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Icon(
                      Ionicons.bus_outline,
                      size: 20.dp,
                    )
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
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/CreateTravelScreen');
                    },
                    child: mContainer(
                        mWidth,
                        mHeight,
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              size: 70.dp,
                              color: Colors.white,
                            ),
                            Text(
                              "New Travel",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 18.dp),
                            )
                          ],
                        ),
                        Colors.red),
                  ),
                  SizedBox(width: 4.w,),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/AllTravelsForEdit');
                    },
                    child: mContainer(
                        mWidth,
                        mHeight,
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.pencil_outline,
                              size: 70.dp,
                              color: Colors.white,
                            ),
                            Text(
                              "Edit travel",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 18.dp),
                            )
                          ],
                        ),
                        Colors.deepOrange),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/ViewAllTravelsScreen');
                    },
                    child: mContainer(
                        mWidth,
                        mHeight,
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.view_array_outlined,
                              size:70.dp,
                              color: Colors.white,
                            ),
                            Text(
                              "Travels",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 18.dp),
                            )
                          ],
                        ),
                        Colors.blue),
                  ),
                                      SizedBox(width: 4.w,),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/PostScreen');
                    },
                    child: mContainer(
                        mWidth,
                        mHeight,
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
ImageIcon(AssetImage('assets/images/write.png'),size: 60.dp,color: Colors.white,),
                            Text(
                              "Post",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 18.dp),
                            )
                          ],
                        ),
                        Colors.deepPurple),
                  ),
                ],
              ),
              SizedBox(
                height:2.h,
              ),
                                              Padding(
                padding: EdgeInsets.only(left: 0.05.w, right: 0.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Admin Control",
                          style: TextStyle(
                            fontFamily: 'Uchin',
                            color: Colors.black,
                            fontSize: 20.dp,
                          ),
                        ),
                        // SizedBox(
                        //   height: mHeight * 0.02,
                        // ),
                        // Text("AdminDashBoardScreen",
                        //     style: TextStyle(
                        //         color: Color(0xffa29aac),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Icon(
                      Icons.manage_accounts_outlined,
                      size: 20.dp,
                    )
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
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/RegisterManager');
                    },
                    child: mContainer(
                        mWidth,
                        mHeight,
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.create,
                              size: 70.dp,
                              color: Colors.white,
                            ),
                            Text(
                              "Manager",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 18.dp),
                            )
                          ],
                        ),
                        Colors.redAccent),
                  ),
                ]),

              Padding(
                padding: EdgeInsets.only(left: 0.5.w, right: 0.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Manage travelers",
                          style: TextStyle(
                            fontFamily: 'Uchin',
                            color: Colors.black,
                            fontSize: 20.dp,
                          ),
                        ),
                        // SizedBox(
                        //   height: mHeight * 0.02,
                        // ),
                        // Text("DashBoardScreen",
                        //     style: TextStyle(
                        //         color: Color(0xffa29aac),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Icon(
                      Icons.manage_accounts_outlined,
                      size: 20.dp,
                    )
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
            
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/AllTravelsForTravelers');
                    },
                    child: mContainer(
                        mWidth,
                        mHeight,
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.people_outline,
                              size: 70.dp,
                              color: Colors.white,
                            ),
                            Text(
                              "Names",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 18.dp),
                            )
                          ],
                        ),
                        Colors.cyan),
                  ),
                                      SizedBox(width: 4.w,),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/AllTravelsForScan');
                    },
                    child: mContainer(
                        mWidth,
                        mHeight,
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_outlined,
                              size: 70.dp,
                              color: Colors.white,
                            ),
                            Text(
                              "Scan",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 18.dp),
                            )
                          ],
                        ),
                        Colors.indigo),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.5.w, right: 0.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Information",
                          style: TextStyle(
                            fontFamily: 'Uchin',
                            color: Colors.black,
                            fontSize: 20.dp,
                          ),
                        ),
                        // SizedBox(
                        //   height: mHeight * 0.02,
                        // ),
                        // Text("DashBoardScreen",
                        //     style: TextStyle(
                        //         color: Color(0xffa29aac),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Icon(
                      Ionicons.information_circle_outline,
                      size: 20.dp,
                    )
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
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/AdminsScreen');
                    },
                    child: Container(
                      width: 42.w,
                      height: 15.h,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.circular(2.h)),
                      child: Center(
                        child: Text(
                          "Admins",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 18.dp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/ManagersScreen');
                    },
                    child: Container(
                      width: 42.w,
                      height: 15.h,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              BorderRadius.circular(2.h)),
                      child: Center(
                        child: Text(
                          "Managers",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 18.dp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/UsersScreen');
                    },
                    child: Container(
                      width: 42.w,
                      height: 15.h,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              BorderRadius.circular(2.h)),
                      child: Center(
                        child: Text(
                          "Users",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 18.dp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  SizedBox(
                      width: 42.w,
                      height: 15.h,
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(
                  //   height: 1.h,
                  //   width: 2.w,
                  // ),
                  SizedBox(
                    // alignment: Alignment.centerRight,
                    width: 42.w,
                    height: 30.h,
                    child: Center(
                      child: PieChart(PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: ((p0, p1) {})),
                          sections: getSections())),
                    ),
                  ),
Spacer()                    ,SizedBox(
                      width: 32.w,
                      height: 30.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end ,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: data
                              .map((data) => buildIndicator(context, mWidth,
                                  mHeight, data.color, data.name))
                              .toList())),
                ],
              )
            ],
          ),
        ),
        ),
      ),
    );
  }
// class IndicatorWidget extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children:

//     );
//   }
// }
  Widget buildIndicator(BuildContext context, double mWidth, double mHeight,
      Color color, String name) {
    return Row(
      children: [
        Container(
          width:6.w,
          height: 3.5.h,
          color: color,
        ),
        SizedBox(
          width: 3.w,
        ),
        Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Text(
            name,
            style: TextStyle(
                fontFamily: 'RobotoCondensed', fontSize: 18.dp),
          ),
        )
      ],
    );
  }
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}
