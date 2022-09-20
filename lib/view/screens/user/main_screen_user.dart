import 'package:bus/consts/app_colors.dart';
import 'package:bus/view/screens/user/all_trips_screen_user.dart';
import 'package:bus/view/screens/user/managers_info_screen.dart';
import 'package:bus/view/screens/user/my_trips_screen.dart';
import 'package:bus/view/screens/user/timeline_screen.dart';
import 'package:bus/view/widgets/drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unicons/unicons.dart';

class MainScreenUser extends StatefulWidget {
  const MainScreenUser({Key? key}) : super(key: key);

  @override
  State<MainScreenUser> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenUser> {
  final List<Widget> _pages = [
    AllTripsScreenUser(),
    MyTripsScreen(),
    TimeLineScreen(),
    ManagersInfoScreen(),
  ];
  int _selectedindex = 0;
   GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
      //  final zoomDrawerController=ZoomDrawerController;

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: 
      Scaffold(
        // appBar: AppBar(
        //   title: const Text("Bus"),
        //   backgroundColor: Colors.white,
        //   foregroundColor: Colors.red,
        // ),
        body: _pages[_selectedindex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor:AppColors.secondaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
currentIndex: _selectedindex,
//  behaviour: SnakeBarBehaviour.floating,
//  padding: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
//         snakeShape: SnakeShape.circle,
                onTap: (index) {
            setState(() {
              _selectedindex = index;
            });
          },
          items:  [
    BottomNavigationBarItem(icon:  Icon(Ionicons.bus_outline),label: 'Travels')       ,
        BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/stop.png')),label: 'My Travels')       ,
            BottomNavigationBarItem(icon:  Icon(Icons.article_outlined),label: 'Posts')       ,

    BottomNavigationBarItem(icon:  Icon(Icons.manage_accounts_outlined),label: 'Managers')       ,

          ],
        ),
      ),
      );
  }
}
