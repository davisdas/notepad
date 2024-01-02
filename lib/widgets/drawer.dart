import 'package:flutter/material.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/controller/settingscontroller/settingscontroller.dart';
import 'package:provider/provider.dart';

class Drawerhome extends StatefulWidget {
  const Drawerhome({super.key});

  @override
  State<Drawerhome> createState() => _DrawerhomeState();
}

class _DrawerhomeState extends State<Drawerhome> {
  @override
  Widget build(BuildContext context) {
    Settingscontroller provider = Provider.of<Settingscontroller>(context);
    return Drawer(
      backgroundColor: Color.fromARGB(255, 37, 35, 35),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: ListView(
          children: [
            // grid or list
            Text(
              "Layout",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Constant.textcolor),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: InkWell(
                        onTap: () => provider.choosegrid(),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: provider.selectgrid == true
                                  ? Colors.red[400]
                                  : Colors.grey[800]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.grid_view_outlined,
                                size: 37,
                                color: Constant.textcolor,
                              ),
                              Text(
                                "Grid",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Constant.textcolor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: InkWell(
                        onTap: () => provider.chooselist(),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: provider.selectlist == true
                                  ? Colors.red[400]
                                  : Colors.grey[800]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.list,
                                size: 37,
                                color: Constant.textcolor,
                              ),
                              Text(
                                "List",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Constant.textcolor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),

            //  sorting
            Text(
              "Sort",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Constant.textcolor),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => provider.sortlatest(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: provider.latest == true
                        ? Colors.red[400]
                        : Colors.grey[800]),
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Text(
                    "Latest",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.textcolor,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 13,
            ),

            InkWell(
              onTap: () => provider.sortoldset(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: provider.latest == false
                        ? Colors.red[400]
                        : Colors.grey[800]),
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Text("Oldest",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constant.textcolor,
                          fontSize: 16)),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // font size
            Text(
              "Font size",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Constant.textcolor),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => provider.smallfont(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: provider.small == true
                              ? Colors.red[400]
                              : Colors.grey[800]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Small",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constant.textcolor,
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => provider.mediumfont(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: provider.medium == true
                              ? Colors.red[400]
                              : Colors.grey[800]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Normal",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constant.textcolor,
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => provider.largefont(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: provider.large == true
                              ? Colors.red[400]
                              : Colors.grey[800]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("Large",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constant.textcolor,
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
