import 'package:firepost/model/post_model.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static final String id = 'home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items.add(Post('123', 'title', 'content'));
    items.add(Post('123', 'title', 'content'));
    items.add(Post('123', 'title', 'content'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All posts'),
        centerTitle: true,
        actions: [
          IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () {
          AuthService.signOutUser(context);
        }),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return itemOfList(items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemOfList(Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title, style: TextStyle(fontSize: 20),),

          SizedBox(height: 10,),

          Text(post.content, style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }

  _openDetail() {
    Navigator.pushNamed(context, DetailPage.id);
  }
}
