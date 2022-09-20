import 'package:bus/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class ManagerSearchDelegate extends SearchDelegate {
List list;

ManagerSearchDelegate({required this.mHeight,required this.list});
double mHeight;
  List searchedManager = [];


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
       searchedManager=list
        .where(
            (e) => e.userName.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    if (query == "") {
      return Center(child: Text("Find Manager",style: TextStyle(fontFamily: "Cairo",color: AppColors.secondaryColor,fontSize: 14.dp)));
    
  
    } else {
                return    SizedBox(
                  height: 100.h ,
                  child: ListView.builder(
                      itemCount: searchedManager.length ,
                      itemBuilder: ((context, index) {
                        return ExpansionTile(
                          title: Text(
                            searchedManager[index].userName,
                            style: TextStyle(
                                fontSize: 18.dp,
                                fontWeight: FontWeight.bold),
                          ),
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.email_outlined,
                                color: Colors.red,
                              ),
                              title: SelectableText(
                                  searchedManager[index].email,
                                  style: TextStyle(
                                      fontSize: 17.dp)),
                            ),
                            ListTile(
                                leading: Icon(
                                    Icons.phone_android_outlined,
                                    color: Colors.green),
                                title: InkWell(
                                  onTap:()async{
                                    launch('tel://${  list[index]
                                              .phoneNumber}');
                                  },
                                  child: Text(
                                      searchedManager[index]
                                              .phoneNumber
                                        ,
                                      style: TextStyle(
                                          fontSize: mHeight * 0.02)),
                                ))
                          ],
                        );
                      })),
                );
    }
  }
}
