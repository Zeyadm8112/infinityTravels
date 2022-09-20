import 'package:bus/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class UserSearchDelegate extends SearchDelegate {
List list;

UserSearchDelegate({required this.mHeight,required this.list});
double mHeight;
  List searchedUser = [];


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
       searchedUser=list
        .where(
            (e) => e.userName.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    if (query == "") {
      return Center(child: Text("Find User",style: TextStyle(fontFamily: "Cairo",color: AppColors.secondaryColor,fontSize: 14.dp)));
    
  
    } else {
                return    SizedBox(
                  height: 100.h ,
                  child: ListView.builder(
                      itemCount: searchedUser.length ,
                      itemBuilder: ((context, index) {
                        return ExpansionTile(
                          title: Text(
                            searchedUser[index].userName,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                                fontSize: 17.dp,
                                fontWeight: FontWeight.bold),
                          ),
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.email_outlined,
                                color: Colors.red,
                              ),
                              title: SelectableText(
                                  searchedUser[index].email,
                                  style: TextStyle(
                                                                  fontFamily: 'Cairo',

                                      fontSize: 15.dp)),
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
                                      searchedUser[index]
                                              .phoneNumber
                                        ,
                                      style: TextStyle(
                                                                      fontFamily: 'Cairo',

                                          fontSize: 15.dp)),
                                ))
                          ],
                        );
                      })),
                );
    }
  }
}
