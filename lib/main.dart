import 'package:bus/consts/values.dart';
import 'package:bus/view/screens/login_screen.dart';
import 'package:bus/view/screens/manager/dashboard/admin_dashboard.dart';
import 'package:bus/view/screens/manager/dashboard/admins_Screen.dart';
import 'package:bus/view/screens/manager/dashboard/all_travels_for_edit.dart';
import 'package:bus/view/screens/manager/dashboard/all_travels_for_scan_screen.dart';
import 'package:bus/view/screens/manager/dashboard/all_travles_for_travelers.dart';
import 'package:bus/view/screens/manager/dashboard/destinations_by_travel_screen.dart';
import 'package:bus/view/screens/manager/dashboard/managers_screen.dart';
import 'package:bus/view/screens/manager/dashboard/post_screen.dart';
import 'package:bus/view/screens/manager/dashboard/register_manager.dart';
import 'package:bus/view/screens/manager/dashboard/travelers_screen.dart';
import 'package:bus/view/screens/manager/dashboard/users_screen.dart';
import 'package:bus/view/screens/manager/dashboard/edit_travel_screen.dart';
import 'package:bus/view/screens/manager/dashboard/create_destinations_screen.dart';
import 'package:bus/view/screens/manager/dashboard/create_destinations_screen.dart';
import 'package:bus/view/screens/manager/dashboard/create_times_screen.dart';
import 'package:bus/view/screens/manager/dashboard/create_travel_screen.dart';
import 'package:bus/view/screens/manager/dashboard/create_travel_steps.dart';
import 'package:bus/view/screens/manager/dashboard/dashboard.dart';
import 'package:bus/view/screens/manager/dashboard/qrcode_scanner_screen.dart';
import 'package:bus/view/screens/manager/dashboard/view_all_travels_screen.dart';
import 'package:bus/view/screens/manager/manager_travel_screen.dart';
import 'package:bus/view/screens/signup_screen.dart';
import 'package:bus/view/screens/splash_screen.dart';
import 'package:bus/view/screens/user/all_trips_screen_user.dart';
import 'package:bus/view/screens/user/edit_traveler_screen.dart';
import 'package:bus/view/screens/user/main_screen_user.dart';
import 'package:bus/view/screens/user/profile_screen_view.dart';
import 'package:bus/view/screens/user/qrcode_generate_screen.dart';
import 'package:bus/view/screens/user/trip_info_user.dart';
import 'package:bus/view/screens/user/trip_screen.dart';
import 'package:bus/view/screens/welcomePage.dart';
import 'package:bus/view_model/accounts_info_view_model.dart';
import 'package:bus/view_model/create_post_view_model.dart';
import 'package:bus/view_model/edit_travel_view_model.dart';
import 'package:bus/view_model/create_destinations_view_model.dart';
import 'package:bus/view_model/create_times_view_model.dart';
import 'package:bus/view_model/create_travel_view_model.dart';
import 'package:bus/view_model/edit_traveler_view_model.dart';
import 'package:bus/view_model/manager_travels_view_model.dart';
import 'package:bus/view_model/onboarding_view_model.dart';
import 'package:bus/view_model/post_view_model.dart';
import 'package:bus/view_model/qrcode_generate_view_model.dart';
import 'package:bus/view_model/register_manager_viewmodel.dart';
import 'package:bus/view_model/token_view_model.dart';
import 'package:bus/view_model/travel_info_view_model.dart';
import 'package:bus/view_model/traveler_view_model.dart';
import 'package:bus/view_model/view_all_travels_view_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'consts/app_colors.dart';
import 'view/screens/manager/main_screen_manager.dart';
import 'view_model/qrcode_scanner_view_model.dart';
import 'view_model/register_view_model.dart';

SharedPreferences? sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(
    // DevicePreview(
    //   enabled:true,
    //   tools: [
    //     ...DevicePreview.defaultTools
    //   ],
    //   builder: (context)=>
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (context) => TokenViewModel(),
        ),
                ChangeNotifierProvider(
          create: (context) => CreatePostViewModel(),
        ),
                ChangeNotifierProvider(
          create: (context) => PostsViewModel(),
        ),

        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateTravelViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateDestinationsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateTimesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ViewAllTravelViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditTravelViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => QrcodeGenerateViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => QrcodeScannerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountsInfoViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TravelerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TravelInfoViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ManagerTravelsViewModel(),
        ),
                ChangeNotifierProvider(
          create: (context) => RegisterManagerViewModel(),
        ),
       ChangeNotifierProvider(
          create: (context) => OnBoardingViewModel(),
        ),
               ChangeNotifierProvider(
          create: (context) => EditTravelerViewModel(),
        ),

      ],
    )
    //  )   ,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(

      builder:(context,orientation,screenType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Infinity Travels',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryColor)
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            ),
        home: SplashScreen()
        // CreateDestinations(),
        ,
        routes: {
          '/TripInfo': (context) => TripInfo(),
          '/TripScreen': (context) => TripScreen(),
    
          '/AllTrips': (context) => AllTripsScreenUser(),
          '/MainScreenUser': (context) => MainScreenUser(),
          // '/MainScreenManager': (context) => MainScreenManager(),
          '/ProfileScreen': (context) => ProfileScreen(),
          // '/CreateTripScreen': (context) => CreateTripScreen(),
          '/DashBoardScreen': (context) => DashBoardScreen(),
          // '/SetTimesScreen': (context) => SetTimesScreen(),
          '/MainScreen': (context) => DashBoardScreen(),
          '/CreateTravelScreen': (context) => CreateTravelScreen(),
          '/CreateDestinations': (context) => CreateDestinations(),
          '/LoginScreen': (context) => LoginScreen(),
          '/SignUpScreen': (context) => SignUpScreen(),
          '/CreateTimesScreen': (context) => CreateTimesScreen(),
          '/ViewAllTravelsScreen': (context) => ViewAllTravelsScreen(),
          '/EditTravelScreen': (context) => EditTravelScreen(),
          '/QrcodeGenerateScreen': (context) => QrcodeGenerateScreen(),
          '/QrcodeScannerScreen': (context) => QrcodeScannerScreen(),
          '/UsersScreen': (context) => UsersScreen(),
          '/AdminsScreen': (context) => AdminsScreen(),
          '/ManagersScreen': (context) => ManagersScreen(),
          '/TravelersScreen': (context) => TravelersScreen(),
          '/ManagerTravelsScreen': (context) => ManagerTravelsScreen(),
          '/AllTravelsForTravelers': (context) => AllTravelsForTravelers(),
          '/AdminDashBoardScreen': (context) => AdminDashBoardScreen(),
          '/RegisterManager': (context) => RegisterManager(),
          '/PostScreen': (context) => PostScreen(),
          '/AllTravelsForScan': (context) => AllTravelsForScan(),
          '/DestiantionsByTravel': (context) => DestiantionsByTravel(),
          '/AllTravelsForEdit': (context) => AllTravelsForEdit(),
          '/EditTravelerScreen': (context) => EditTravelerScreen(),
    
          // '/CreateTravelStepsScreen': (context) => CreateTravelStepsScreen(),
          // '/SplashScreen':(context) => SplashScreen(),
        },
      ),
    );
  }
}
