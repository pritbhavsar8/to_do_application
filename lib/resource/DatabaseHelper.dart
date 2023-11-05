
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper
{
  Database? db;
  Future<Database> Create_db() async
  {
     if(db== null)
     {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path,"todo_db");
      var db = await openDatabase(path,version: 1,onCreate: create_table);
      return db;
     }
     else
       {
          return db!;
       }
  }

  create_table(Database db,int version) async
  {
    db.execute("create table notes (tid integer primary key autoincrement,Title text,Remark text)");
    print("table created");
  }

  Future<int> addtask(title,remark) async
  {
    var db = await Create_db();
    var id = await db.rawInsert("insert into notes (Title,Remark) values (?,?)",[title,remark]);
    return id;
  }
  Future<List> viewAlltask() async
  {
    var db = await Create_db();
    var data = await db.rawQuery("select * from notes");
    return data.toList();
  }
  deletetask(id) async
  {
    var db = await Create_db();
    int status = await db.rawDelete("delete from notes where tid=?",[id]);
    return status;
  }
  Future<List> getsingleNotes(id) async
  {
    var db = await Create_db();
    var data = await db.rawQuery("select * from notes where tid=?",[id]);
    return data.toList();
  }

  Future<int> updateTask(title,remark,id) async
  {
    var db = await Create_db();
    var status = await db.rawUpdate("update notes set Title=?,Remark=? where tid=?",[title,remark,id]);
    return status;
  }
}