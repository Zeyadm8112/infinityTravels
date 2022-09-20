import 'package:bus/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class AdminSearchDelegate extends SearchDelegate {
List list;

AdminSearchDelegate({required this.mHeight,required this.list});
double mHeight;
  List searchedAdmin = [];


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
       searchedAdmin=list
        .where(
            (e) => e.userName.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    if (query == "") {
      return Center(child: Text("Find Admin",style: TextStyle(fontFamily: "Cairo",color: AppColors.secondaryColor,fontSize: 14.dp)));
    
  
    } else {
                return    SizedBox(
                  height: 100.h ,
                  child: ListView.builder(
                      itemCount: searchedAdmin.length ,
                      itemBuilder: ((context, index) {
                        return ExpansionTile(
                          title: Text(
                            searchedAdmin[index].userName,
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
                                  searchedAdmin[index].email,
                                  style: TextStyle(
                                      fontSize: 15.dp
                                      ,fontFamily: 'Cairo'
                                      )),
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
                                      searchedAdmin[index]
                                              .phoneNumber??'0'
                                        ,
                                      style: TextStyle(
                                          fontSize: 15.dp
                                          ,fontFamily: 'Cairo'
                                          )),
                                ))
                          ],
                        );
                      })),
                );
    }
  }
}
