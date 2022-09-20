// import 'package:bus/view/screens/manager/all_trips_screen_manager.dart';
// import 'package:bus/view/screens/user/all_trips_screen_user.dart';
// import 'package:bus/view/screens/user/managers_info_screen.dart';
// import 'package:bus/view/screens/user/my_trips_screen.dart';
// import 'package:bus/view/widgets/drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:ionicons/ionicons.dart';

// import 'clients_screen.dart';
// import 'dashboard_screen.dart';

// class MainScreenManager extends StatefulWidget {
//   const MainScreenManager({Key? key}) : super(key: key);

//   @override
//   State<MainScreenManager> createState() => _MainScreenManagerState();
// }

// class _MainScreenManagerState extends State<MainScreenManager> {
//   final List<Widget> _pages = [
//     AllTripsManager(),
//     DashBoardScreen(),
//     ClientsScreen(),
//   ];
//   int _selectedindex = 0;
//   @override
//   Widget build(BuildContext context) {
//     double mWidth=MediaQuery.of(context).size.width;
//         double mHeight=MediaQuery.of(context).size.height;

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Bus"),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.red,
//         ),
//         endDrawer: mDrawer(mWidth,mHeight,context),
//         body: _pages[_selectedindex],
//         bottomNavigationBar: BottomNavigationBar(
//           selectedItemColor: Colors.red,
//           unselectedItemColor: Colors.grey.withOpacity(0.6),
//           selectedIconTheme: IconThemeData(size: 32),
//           onTap: (index) {
//             setState(() {
//               _selectedindex = index;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Ionicons.bus),
//               label: "Trips",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard_outlined),

//               label: "DashBoard",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Ionicons.people_outline),
//               label: "Clients",
//             )
//           ],
//           currentIndex: _selectedindex,
//           type: BottomNavigationBarType.fixed,
//         ),
//       ),
//     );
//   }
// }
