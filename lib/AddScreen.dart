import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/ViewScreen.dart';
import 'package:to_do_application/resource/DatabaseHelper.dart';

class AddScreen extends StatefulWidget
{
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen>
{
  TextEditingController _text = TextEditingController();
  TextEditingController _remark = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
        toolbarHeight: 70.0,
        foregroundColor: Colors.red.shade900,
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
        actionsIconTheme: IconThemeData(
          color: Colors.orange.shade900,
          size: 30.0,
          weight: 50.0,
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewScreen(),)
                );
              },
              icon: Icon(Icons.attachment,),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title:",style:TextStyle(
                    color: Colors.red.shade100,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  )),
                  SizedBox(height: 10.0,),
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.yellowAccent
                      ),
                      controller: _text,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(11.0),
                         borderSide:  BorderSide(
                           color: Colors.white,
                         ),
                       ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide:  BorderSide(
                            color: Colors.green.shade100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 35.0),
                  Text("Remark:",style:TextStyle(
                    color: Colors.red.shade100,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  )),
                  SizedBox(height: 10.0,),
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.yellowAccent,
                      ),
                      controller: _remark,
                      keyboardType: TextInputType.text,
                      maxLines: 8,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11.0),
                              borderSide:  BorderSide(
                                  color: Colors.white
                              ),
                          ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide:  BorderSide(
                            color: Colors.green.shade100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300.0,
                        height: 50.0,
                        child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                           elevation: 15.0,
                           foregroundColor:  Colors.white,
                           backgroundColor:  Colors.red.shade900,
                           shape: ContinuousRectangleBorder(
                               borderRadius: BorderRadius.circular(15.0),
                           ),
                          ),
                            onPressed: () async
                            {
                              var title =_text.text.toString();
                              var remark = _remark.text.toString();
                              var obj = new DatabaseHelper();
                              var id = await obj.addtask(title, remark);
                              print("Record Inserted at : "+id.toString());
                            },
                            child: Text("Add",style: TextStyle(
                              fontWeight: FontWeight.bold,
                               fontSize: 16.0,

                            )),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
