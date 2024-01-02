import 'package:flutter/material.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/controller/notecontroller/notecontroller.dart';
import 'package:mynotepad/controller/settingscontroller/settingscontroller.dart';
import 'package:mynotepad/view/descriptionscreen/description.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Note extends StatefulWidget {
  const Note({super.key, required this.index});
  final index;
  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    Settingscontroller settingprovider =
        Provider.of<Settingscontroller>(context);
    Notecontroller provider =
        Provider.of<Notecontroller>(context, listen: false);
    return Consumer<Notecontroller>(
      builder: (context, values, child) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (conext) => Description(index: widget.index))),
        child: Container(
          // margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  Colors.black.value == values.notelist[widget.index].colorvalue
                      ? const Color.fromARGB(255, 38, 37, 37)
                      : Color(values.notelist[widget.index].colorvalue)),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title of note
                      SizedBox(
                        width: settingprovider.rowcount==2?
                        MediaQuery.of(context).size.width*0.35 :      MediaQuery.of(context).size.width*0.7,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          values.notelist[widget.index].title.isEmpty
                              ? "No title"
                              : values.notelist[widget.index].title.toString(),
                          style: TextStyle(
                              fontSize: settingprovider.titlefont,
                              fontWeight: FontWeight.bold,
                              color: values.notelist[widget.index].title.isEmpty
                                  ? const Color.fromARGB(255, 77, 70, 70)
                                  : Colors.white),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //  description of note
                      SizedBox(
                        width: settingprovider.rowcount==2?
                        MediaQuery.of(context).size.width*0.35 :      MediaQuery.of(context).size.width*0.7,
                        child: Text(
                          values.notelist[widget.index].description.isEmpty
                              ? "No body"
                              : values.notelist[widget.index].description
                                  .toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: values.notelist[widget.index].description
                                      .isEmpty
                                  ? const Color.fromARGB(255, 77, 70, 70)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: settingprovider.descriptionfont),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        values.notelist[widget.index].timeday.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Provider.of<Settingscontroller>(context).rowcount == 1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (!sharingInProgress) {
                                  sharingInProgress = true;

                                  await Future.delayed(const Duration(seconds: 1),
                                      () async {
                                    await Share.share(
                                        '${values.notelist[widget.index].title}\n${values.notelist[widget.index].description}');

                                    sharingInProgress = false;
                                  });
                                }
                              },
                              icon: const Icon(Icons.share),
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor:
                                              Constant.primarycolor,
                                          title: Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Constant.textcolor),
                                          ),
                                          content: Text(
                                            "Delete this note ?",
                                            style: TextStyle(
                                                color: Constant.textcolor),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  provider
                                                      .deletedb(widget.index);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ));
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.white,
                            )
                          ],
                        )
                      : const SizedBox()
                ]),
          ),
        ),
      ),
    );
  }
}
