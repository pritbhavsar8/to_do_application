import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/EditScreen.dart';
import 'package:to_do_application/resource/DatabaseHelper.dart';
import 'AddScreen.dart';

class ViewScreen extends StatefulWidget
{

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen>
{
  Future<List>? alldata;
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata=getdata();
    });
  }
  Future<List> getdata() async
  {
     var obj = DatabaseHelper();
     var data = await obj. viewAlltask();
     return data;

  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Notes"),
        toolbarHeight: 70.0,
        foregroundColor: Colors.red.shade900,
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,

      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
         onPressed: (){
           Navigator.of(context).push(
             MaterialPageRoute(builder: (context) => AddScreen()),
           );
         },
        icon: Icon(Icons.add),
        splashColor: Colors.orange,
        label: Text("Add"),
        extendedIconLabelSpacing: 20.0,
        extendedTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),

      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
           ),
          FutureBuilder(
            future: alldata,
            builder: (context,snapshots)
            {
              if(snapshots.hasData)
              {
                if(snapshots.data!.length <=0 )
                {
                  return Center(
                    child: Text("No Data",style:TextStyle(
                      color: Colors.white,
                  ),
                  ));
                }
                else
                {
                  return ListView.builder(
                    itemCount: snapshots.data!.length,
                    itemBuilder: (context,index)
                    {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(15.0),

                        ),
                        child: Column(
                          children: [
                            Text(snapshots.data![index]["Title"].toString(),style:TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                              fontSize: 16.0,
                          )),
                            Text(snapshots.data![index]["Remark"].toString(),style:TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                              fontSize: 13.0,
                            )),
                            SizedBox(height: 15.0,),
                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               ElevatedButton(onPressed: () async{
                                 var id = snapshots.data![index]["tid"].toString();
                                 var obj = new DatabaseHelper();
                                 var status = await obj.deletetask(id);
                                 if(status==1)
                                 {
                                   setState(() {
                                     alldata=getdata();
                                   });
                                 }
                                 else
                                 {
                                   print("Not Deleted");
                                 }

                               }, child:Icon(Icons.delete),
                                 style: ElevatedButton.styleFrom(
                                   foregroundColor: Colors.redAccent,
                                   backgroundColor: Colors.grey.shade200,
                                 ),
                               ),

                               ElevatedButton(
                                 onPressed: (){
                                   var id = snapshots.data![index]["tid"].toString();
                                   Navigator.of(context).push(
                                     MaterialPageRoute(builder: (context) => EditScreen(
                                       updateid: id,
                                     ),),
                                   );
                                 },
                                 child: Icon(Icons.edit),
                                 style: ElevatedButton.styleFrom(
                                   foregroundColor: Colors.greenAccent.shade700,
                                   backgroundColor: Colors.grey.shade200
                                 ) ,
                               ),
                             ],
                           )
                          ],
                        ),
                      );

                    },
                  );
                }
              }
              else
              {
                return Center(
                    child: Text("Loading...")
                );
              }
            },
          ),

        ],
      ),
    );
  }
}
