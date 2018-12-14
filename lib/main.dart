import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Mode> _list;
  void _incrementCounter() {
    setState(() {
    });
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _initData();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:new DragAndDropList<Mode>(
        _list,
        itemBuilder: (BuildContext context,item){
          int index = _list.indexOf(item);
          return _getSlidableWithLists(context, index, Axis.horizontal);
        },
        onDragFinish: (before,after){
          Mode mode = _list[before];
          _list.removeAt(before);
          _list.insert(after, mode);
        },
        canBeDraggedTo: (one,two) => true,
        dragElevation: 8.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _initData(){
    _list = new List();
    for(int i = 0; i < 10; i ++){
      Mode mode = new Mode();
      mode.name = "name $i";
      mode.age = i + 20;
      _list.add(mode);
    }
  }
Widget _buildVerticalListItem(BuildContext context, int index) {
    final Mode item = _list[index];
    return new Container(
      color: Colors.white,
      child: new ListTile(
        leading: new CircleAvatar(
          // backgroundColor: item.color,
          child: new Text('${item.name}'),
          foregroundColor: Colors.white,
        ),
        title: new Text(item.name),
        subtitle: new Text(item.name),
      ),
    );
  }
 Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    final Mode item = _list[index];
    //final int t = index;
    return new Slidable(
      key: new Key(item.name),
      // controller: slidableController,
      direction: direction,
      slideToDismissDelegate: new SlideToDismissDrawerDelegate(
        onDismissed: (actionType) {
          // _showSnackBar(
          //     context,
          //     actionType == SlideActionType.primary
          //         ? 'Dismiss Archive'
          //         : 'Dimiss Delete');
          setState(() {
            _list.removeAt(index);
          });
        },
      ),
      delegate: _getDelegate(index),
      actionExtentRatio: 0.25,
      child: _buildVerticalListItem(context, index),
      actions: <Widget>[
        new IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          // onTap: () => _showSnackBar(context, 'Archive'),
        ),
        new IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          // onTap: () => _showSnackBar(context, 'Share'),
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'More',
          color: Colors.grey.shade200,
          icon: Icons.more_horiz,
          // onTap: () => _showSnackBar(context, 'More'),
          closeOnTap: false,
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          // onTap: () => _showSnackBar(context, 'Delete'),
          onTap:(){
            _deleteitem(index);
          },
        ),
      ],
    );
  }
  _deleteitem(int index){
      setState(() {
          _list.removeAt(index);
      });
  }
  static SlidableDelegate _getDelegate(int index) {
    switch (index % 4) {
      case 0:
        return new SlidableBehindDelegate();
      case 1:
        return new SlidableStrechDelegate();
      case 2:
        return new SlidableScrollDelegate();
      case 3:
        return new SlidableDrawerDelegate();
      default:
        return null;
    }
  }
}


class Mode{
  String name;
  int age;
}