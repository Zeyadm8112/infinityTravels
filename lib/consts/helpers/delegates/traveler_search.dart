import 'dart:io';

import 'package:bus/consts/app_colors.dart';
import 'package:bus/consts/constants.dart';
import 'package:bus/view/widgets/empty_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class TravelerSearchDelegate extends SearchDelegate {
List list;

TravelerSearchDelegate({required this.mHeight,required this.list});
double mHeight;
  List searchedTraveler = [];


  // SubjectController controller = Get.put(SubjectController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    
 return [    IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear),color: AppColors.primaryColor)
  ]; 
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back),color:  AppColors.primaryColor);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // searchedSubject = controller.subjectsList
       searchedTraveler=list
        .where(
            (e) {
if(e.destinationName.toLowerCase().startsWith(query.toLowerCase())){
  return e.destinationName.toLowerCase().startsWith(query.toLowerCase());
} if(e.destinationNameB.toLowerCase().startsWith(query.toLowerCase()))
 {
  return e.destinationNameB.toLowerCase().startsWith(query.toLowerCase());

}
else{
  return e.destinationName.toLowerCase().startsWith(query.toLowerCase());
}
// else 
//  {
//   return e.phoneNumber.toLowerCase().startsWith(query.toLowerCase());

// }

            }
        ).toList();
    if (query == "") {
      return Center(child: Text("Find Traveler",style: TextStyle(fontFamily: "Cairo",color: AppColors.secondaryColor,fontSize: 14.dp)));
    
  
    } else {
                return   
                 SizedBox(
                  height: 100.h ,
                  child:Padding(
          padding: EdgeInsets.all(0.05.w),
          child: Column(children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 1.2.h,
                  child:
                             ListView.builder(
                                itemCount: searchedTraveler.length,
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
                                                                            Text('Are you sure you want do delete this traveler?'),
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
deleteTraveler()async{
  Dio dio=Dio();
final params={
'id':                                                                              searchedTraveler[index].id,

};
try{
final response = await dio.delete('$baseUrl/api/Travelers',queryParameters: params);

if(response.statusCode==200){

}

}
 on SocketException{
      //       errorMessage = "Not connected";
      // setState(TravelerScreenState.notConnected);

    }
     on FormatException {
      // errorMessage = "Error occured try agian later";
      // setState(TravelerScreenState.failed);
    } on DioError catch (e) {
      // _handleDioErrors(e);
    }

}
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
                                      searchedTraveler[index].userName,
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
                                            searchedTraveler[index]
                                                .destinationName,
                                            style: TextStyle(fontSize: 15.dp)),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.keyboard_arrow_left_outlined,
                                          color: Colors.red,
                                        ),
                                        title: SelectableText(
                                            searchedTraveler[index]
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
                                            searchedTraveler[index].referenceNo,
                                            style: TextStyle(fontSize: 15.dp)),
                                      ),
                                      ListTile(
                                          leading: Icon(Icons.call,
                                              color: Colors.green),
                                          title: InkWell(
                                            onTap: () async {
                                              launch(
                                                  'tel://${searchedTraveler[index].phoneNumber}');
                                            },
                                            child: Text(
                                                searchedTraveler[index]
                                                    .phoneNumber,
                                                style:
                                                    TextStyle(fontSize: 15.dp)),
                                          ))
                                    ],
                                  );
                      
                    
                        
                      
                    
                    }),
                  ),
                ))
          ]),
        ),
      );
            
    }
  }
}
