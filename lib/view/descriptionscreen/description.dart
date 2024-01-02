import 'package:flutter/material.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/controller/audioplaycontroller/audioplaycontroller.dart';
import 'package:mynotepad/controller/notecontroller/notecontroller.dart';
import 'package:mynotepad/controller/settingscontroller/settingscontroller.dart';
import 'package:mynotepad/widgets/colorchooseedit.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Description extends StatefulWidget {
  const Description({super.key, this.index});
  final index;
  @override
  State<Description> createState() => _DescriptionState();
}

bool sharingInProgress = false;

class _DescriptionState extends State<Description> {
  @override
  // ignore: override_on_non_overriding_member
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  void initState() {
    Notecontroller provider =
        Provider.of<Notecontroller>(context, listen: false);
    provider.getcolor(widget.index);
    super.initState();
    titlecontroller.text = provider.notelist[widget.index].title;
    descriptioncontroller.text = provider.notelist[widget.index].description;
  }

  @override
  Widget build(BuildContext context) {
    Audioplaycontroller audioprovider =
        Provider.of<Audioplaycontroller>(context, listen: false);
    Settingscontroller settingprovider =
        Provider.of<Settingscontroller>(context);
    Notecontroller provider =
        Provider.of<Notecontroller>(context, listen: false);
    return Consumer<Notecontroller>(
      builder: <Notecontroller>(context, values, child) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Color(provider.descriptioncolor),

            appBar: values.appbarchange == false
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                         audioprovider.reset();
                         audioprovider.stop();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Constant.textcolor,
                          size: 30,
                        )),
                    actions: [
                      // Choose color theme
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    const Wrap(children: [ColorChooseedit()]));
                          },
                          icon: const Icon(
                            Icons.palette_outlined,
                            color: Colors.white,
                            size: 30,
                          )),

                      //  share button
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
                        icon: Icon(Icons.ios_share,
                            color: Constant.textcolor, size: 30),
                      ),

                      // Delete from list
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Constant.primarycolor,
                                      title: Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Constant.textcolor),
                                      ),
                                      content: Text(
                                        "Delete thios note ?",
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
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              provider.deletedb(widget.index);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ));
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Constant.textcolor,
                            size: 30,
                          ))
                    ],
                  )

                // changed app bar while changing
                : AppBar(
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          if ((values.notelist[widget.index].title ==
                                  titlecontroller.text) &&
                              (values.notelist[widget.index].description ==
                                  descriptioncontroller.text) &&
                              (values.notelist[widget.index].colorvalue ==
                                  provider.descriptioncolor)) {
                            audioprovider.stop();
                            Navigator.pop(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Constant.primarycolor,
                                      title: const Text(
                                        "Save changes ?",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      content: const Text(
                                        "Save and exit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              provider.changeappbarnormal();
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              audioprovider.stop();
                                            },
                                            child: const Text("Exit")),
                                        TextButton(
                                            onPressed: () {
                                              provider.editnote(
                                                  widget.index,
                                                  titlecontroller.text,
                                                  descriptioncontroller.text,
                                                  values.descriptioncolor,
                                                  values.notelist[widget.index]
                                                      .timeday);
                                               Navigator.pop(context);
                                              provider.changeappbarnormal();
                                              audioprovider.stop();
                                            },
                                            child: const Text("Save"))
                                      ],
                                    ));
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Constant.textcolor,
                          size: 30,
                        )),
                    actions: [
                      // Choose color theme
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    const Wrap(children: [ColorChooseedit()]));
                          },
                          icon: const Icon(
                            Icons.palette_outlined,
                            color: Colors.white,
                            size: 30,
                          )),

                      // Delete from list
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Constant.primarycolor,
                                      title: Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Constant.textcolor),
                                      ),
                                      content: Text(
                                        "Delete thios note ?",
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
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              provider.deletedb(widget.index);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ));
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Constant.textcolor,
                            size: 30,
                          )),

                      IconButton(
                          onPressed: () {
                            if (titlecontroller.text.isNotEmpty ||
                                descriptioncontroller.text.isNotEmpty) {
                              provider.editnote(
                                  widget.index,
                                  titlecontroller.text,
                                  descriptioncontroller.text,
                                  values.descriptioncolor,
                                  values.notelist[widget.index].timeday);

                              provider.changeappbarnormal();
                              
                            }
                          },
                          icon: Icon(
                            Icons.done,
                            color: Constant.textcolor,
                            size: 30,
                          )),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),

            //  body
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                  child: ListView(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      provider.changeappbar();
                    },
                    controller: titlecontroller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        color: Constant.textcolor,
                        fontSize: settingprovider.titlefont,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.grey[800])),
                  ),

                  Text(
                    values.notelist[widget.index].timeday,
                    style: TextStyle(color: Constant.textcolor),
                  ),

                  //  body display
                  TextFormField(
                    controller: descriptioncontroller,
                    onChanged: (value) {
                      provider.changeappbar();
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        color: Constant.textcolor,
                        fontWeight: FontWeight.bold,
                        height: 2.5,
                        fontSize: settingprovider.descriptionfont),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description",
                        hintStyle: TextStyle(color: Colors.grey[800])),
                  )
                ],
              )),
            ),

            floatingActionButton:
                Provider.of<Audioplaycontroller>(context).startplaying ==
                            false &&
                        values.appbarchange == false
                    ? FloatingActionButton(
                        onPressed: () =>
                            audioprovider.speak(titlecontroller.text ,
                             descriptioncontroller.text
                            ),
                        child: const Icon(Icons.volume_up),
                      )
                    : const SizedBox(),
            bottomNavigationBar: Provider.of<Audioplaycontroller>(context)
                        .startplaying ==
                    false
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<Audioplaycontroller>(
                          builder: (context, value, child) => Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: value.isPaused == false
                                  ? Row(
                                      children: [
                                        InkWell(
                                            onTap: () => audioprovider.pause(),
                                            child: const Icon(Icons.pause)),
                                        const VerticalDivider(
                                          width: 25,
                                          color: Colors.green,
                                          thickness: 1,
                                        ),
                                        InkWell(
                                            onTap: () => audioprovider.stop(),
                                            child: const Icon(Icons.stop),),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        InkWell(
                                            onTap: () => audioprovider.resume(),
                                            child: const Icon(Icons.play_arrow)),
                                        const VerticalDivider(
                                          width: 25,
                                          color: Colors.green,
                                          thickness: 1,
                                        ),
                                        InkWell(
                                            onTap: () => audioprovider.stop(),
                                            child: const Icon(Icons.stop)),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
