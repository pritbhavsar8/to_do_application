import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/ViewScreen.dart';
import 'package:to_do_application/resource/DatabaseHelper.dart';

class EditScreen extends StatefulWidget
{
  var updateid="";

  EditScreen({required this.updateid});


  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen>
{
  TextEditingController _text = TextEditingController();
  TextEditingController _remark = TextEditingController();
  getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getsingleNotes(widget.updateid);
    setState(() {
      _text.text = data[0]["Title"].toString();
      _remark.text = data[0]["Remark"].toString();

    });
  }
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        actions: [
          IconButton(
            color: Colors.blueGrey.shade700,
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewScreen(),)
              );
            },
            icon: Icon(Icons.attachment),
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
                    color: Colors.white,
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
                              )
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 35.0),
                  Text("Remark:",style:TextStyle(
                    color: Colors.white,
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
                      maxLines: 3,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide:  BorderSide(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.0,
                        height: 50.0,
                        child: ElevatedButton(
                            onPressed: () async
                            {
                              var title =_text.text.toString();
                              var remark = _remark.text.toString();
                              var obj = new DatabaseHelper();
                              var status = await obj.updateTask(title,remark,widget.updateid);
                              if(status==1)
                              {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>ViewScreen())
                                );
                              }
                              else
                              {
                                print("Error");
                              }
                            },
                            child: Text("Save")
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}