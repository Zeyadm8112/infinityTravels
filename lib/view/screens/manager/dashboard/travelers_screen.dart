import 'package:bus/view/widgets/empty_widget.dart';
import 'package:bus/view/widgets/error_widget.dart';
import 'package:bus/view_model/travel_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../consts/helpers/delegates/traveler_search.dart';
import '../../../../view_model/accounts_info_view_model.dart';
import '../../../../view_model/traveler_view_model.dart';

class TravelersScreen extends StatefulWidget {
  const TravelersScreen({Key? key}) : super(key: key);

  @override
  State<TravelersScreen> createState() => _TravelersScreenState();
}

class _TravelersScreenState extends State<TravelersScreen>
    with SingleTickerProviderStateMixin {
  @override
  // void initState() {
  //   final provider = Provider.of<TravelerViewModel>(context,listen: false);
  //   provider.getTravelers();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TravelerViewModel>(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    int travelId = arg['id'];

    String travelName = arg['name'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            travelName,
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 25.dp),
          ),
          actions: [
        IconButton(icon:    Icon(Icons.search),
        onPressed: (){
                                  showSearch(context: context, delegate: TravelerSearchDelegate(mHeight: 100.h,list:provider.travelers!));

        },
        )

          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.all(0.05.w),
          child: Column(children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 1.2.h,
                  child: FutureBuilder(
                    future: provider.getTravelers(travelId),
                    builder: ((context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue),
                          );

                        case ConnectionState.done:

                        default:
                          if (snapshot.hasError) {
                            return SnapErrorWidget();
                          } else if (snapshot.hasData) {
                            // return Center(child: Text("data"),);
                            return ListView.builder(
                                itemCount: provider.travelers!.length,
                                itemBuilder: ((context, index) {
                                  return ExpansionTile(
                                    trailing: IconButton(
                                      onPressed: () {
   showDialog<
                                                                    void>(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false, // user must tap button!
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Delete '),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            ListBody(
                                                                          children: const <
                                                                              Widget>[
                                                                            Text('Are you sure you want do delete this travel?'),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              const Text('No'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              const Text('Yes'),
                                                                          onPressed:
                                                                              () {
                                                                            provider.deleteTraveler(
                                                                              provider.travelers![index].id,
                                                                            );
                                                                            // provider.deleteDestBack(
                                                                            //     provider
                                                                            //         .destBackList[
                                                                            //             index]
                                                                            //         .destinationBackId);
                                                                                                                                                        Navigator.of(context).pop();

                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    title: Text(
                                      provider.travelers![index].userName,
                                      style: TextStyle(
                                          fontSize: 17.dp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          color: Colors.red,
                                        ),
                                        title: SelectableText(
                                            provider.travelers![index]
                                                .destinationName,
                                            style: TextStyle(fontSize: 15.dp)),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.keyboard_arrow_left_outlined,
                                          color: Colors.red,
                                        ),
                                        title: SelectableText(
                                            provider.travelers![index]
                                                    .destinationNameB
                                                    ?.toString() ??
                                                "",
                                            style: TextStyle(fontSize: 15.dp)),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.payment_outlined,
                                          color: Colors.blue,
                                        ),
                                        title: SelectableText(
                                            provider
                                                .travelers![index].referenceNo,
                                            style: TextStyle(fontSize: 15.dp)),
                                      ),
                                      ListTile(
                                          leading: Icon(Icons.call,
                                              color: Colors.green),
                                          title: InkWell(
                                            onTap: () async {
                                              launch(
                                                  'tel://${provider.travelers![index].phoneNumber}');
                                            },
                                            child: Text(
                                                provider.travelers![index]
                                                    .phoneNumber,
                                                style:
                                                    TextStyle(fontSize: 15.dp)),
                                          ))
                                    ],
                                  );
                                }));
                          } else {
                           return EmptyWidget();
                          }
                      }
                    }),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
