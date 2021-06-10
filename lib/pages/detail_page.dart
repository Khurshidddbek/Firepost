import 'package:firepost/model/post_model.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/rtdb_service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static final String id = 'detail_page';

  const DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),

              SizedBox(height: 15,),

              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'Content',
                ),
              ),

              SizedBox(height: 15,),

              Container(
                height: 45,
                width: double.infinity,
                child: FlatButton(
                  onPressed: _addPost,
                  color: Colors.blue,
                  child: Text('Add', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addPost() async {
    String title = titleController.text.toString();
    String content = contentController.text.toString();

    var id = Prefs.loadUserId();
    RTDBService.addPost(Post(id.toString(), title, content)).then((_) => {
      respAddPost(),
    });
  }

  respAddPost() {
    Navigator.pop(context);
  }
}
