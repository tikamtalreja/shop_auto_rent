import 'package:auto/pages/note_detail.dart';
import 'package:flutter/material.dart';
import 'package:auto/models/note.dart';
import 'package:auto/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Note> noteList;
	int count = 0;

  @override
  Widget build(BuildContext context) {
    	if (noteList == null) {
			noteList = List<Note>();
			updateListView();
		}
     return Scaffold(

	    appBar: AppBar(
		    title: Text('Auto Rent'),
        centerTitle: true,
	    ),

	    body: getNoteListView(),

	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		      debugPrint('FAB clicked');
		      navigateToDetail(Note('', '', " "), 'Add Rent Details');
		    },

		    tooltip: 'Add Rent',

		    child: Icon(Icons.add),

	    ),
    );
  }

  ListView getNoteListView() {

		

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

					 leading: Text((this.noteList[position].rent),style: TextStyle(color: Colors.black),),
    title: Text(this.noteList[position].title,style: TextStyle(color: Colors.black),),
    	subtitle: Text(this.noteList[position].date,style: TextStyle(color: Colors.black),),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, noteList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.noteList[position],'Edit Auto Rent');
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	

	// Returns the priority icon


	void _delete(BuildContext context, Note note) async {

		int result = await databaseHelper.deleteNote(note.id);
		if (result != 0) {
			_showSnackBar(context, 'Note Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(Note note, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return NoteDetail(note, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
			noteListFuture.then((noteList) {
				setState(() {
				  this.noteList = noteList;
				  this.count = noteList.length;
				});
			});
		});
  }
}
