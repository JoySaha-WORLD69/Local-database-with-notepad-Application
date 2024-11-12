import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Box? nodepad;

  @override
  void initState() {
    nodepad = Hive.box('notepad');
    super.initState();
  }

  TextEditingController _controller = TextEditingController();
  TextEditingController _updatecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              'NotePad APP',
              style: TextStyle(color: Colors.white),
            )),
            backgroundColor: Colors.green,
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      label: Text('Note'), border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)))),
                  onPressed: () async {
                    try {
                      await nodepad!.add(_controller.text);
                      _controller.clear();
                      Fluttertoast.showToast(msg: 'Added successfully');
                    } catch (e) {
                      Fluttertoast.showToast(msg: "what".toString());
                    }
                  },
                  child: Text(
                    "Add on",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: Hive.box('notepad').listenable(),
                        builder: (context, box, index) {
                          return ListView.builder(
                              itemCount: nodepad!.keys.toList().length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 5,
                                  child: ListTile(
                                    title:
                                        Text(nodepad!.getAt(index).toString()),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 1,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: Container(
                                                          height: 180,
                                                          width: 180,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        14.0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      _updatecontroller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    label: Text(
                                                                      'Update',
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            25),
                                                                child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: Colors.green,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(20),
                                                                          topLeft:
                                                                              Radius.circular(20),
                                                                        ))),
                                                                    onPressed: () async {
                                                                      final Updatedata =
                                                                          _updatecontroller
                                                                              .text;
                                                                      await nodepad!.put(
                                                                          index,
                                                                          Updatedata);
                                                                      _updatecontroller
                                                                          .clear();
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'Update',
                                                                      style: TextStyle(
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255)),
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              icon: Icon(Icons.edit)),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                await nodepad!.deleteAt(index);
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Deleted successfully');
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }))
              ],
            ),
          )),
    );
  }
}
