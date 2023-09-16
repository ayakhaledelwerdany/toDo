import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtodo/Home_layout/HomeLayout.dart';
import 'package:newtodo/Shared/network/firebase/firebase_function.dart';
import 'package:newtodo/model/task_model.dart';
import 'package:newtodo/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/my_provider.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "edit_screen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var arg = ModalRoute.of(context)!.settings.arguments as TaskModel;

    return Scaffold(
      body: Container(
        height: 680,
        child: Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 150,
              width: double.infinity,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeLayout.routeName, (route) => false);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Text(
                    "ToDo ${provider.userModel?.name} ",
                    style: GoogleFonts.elMessiri(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Positioned(
              left: 30,
              top: 100,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: provider.changeColors(),
                    borderRadius: BorderRadius.circular(22)),
                height: 500,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Edit Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: provider.changeFontColor()),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    TextFormField(
                      style: TextStyle(color: provider.changeFontColor()),
                      initialValue: arg.title,
                      decoration: InputDecoration(
                        label: Text("This is Title"),
                        labelStyle:
                            TextStyle(color: provider.changeFontColor()),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: provider.changeFontColor())),
                      ),
                      onChanged: (value) {
                        arg.title = value;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: provider.changeFontColor()),
                      initialValue: arg.describtion,
                      decoration: InputDecoration(
                        label: Text("Task Details"),
                        labelStyle:
                            TextStyle(color: provider.changeFontColor()),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: provider.changeFontColor())),
                      ),
                      onChanged: (value) {
                        arg.describtion = value;
                      },
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Selected Time",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: provider.changeFontColor()),
                      textAlign: TextAlign.left,
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? chooseDate = await showDatePicker(
                            context: context,
                            initialDate:
                                DateTime.fromMillisecondsSinceEpoch(arg.date),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));
                        if (chooseDate != null) {
                          selectedDate = chooseDate;
                          setState(() {});
                        }
                      },
                      child: Text(
                        selectedDate.toString().substring(0, 10),
                        style: TextStyle(color: provider.changeFontColor()),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        FirebaseFunctions.updateTask(arg);
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeLayout.routeName, (route) => false);
                      },
                      child: Text("Update Task"),
                    ),
                    Spacer(
                      flex: 3,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ), //
      /*   home: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              title: Text(
                "ToDo ${provider.userModel?.name} ",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            body: Positioned(
              // top: 10,
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(12),
                child: Card(
                  elevation: 3,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "Edit Task",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        TextFormField(),
                        TextFormField(),
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "Selected Time",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        Text("Date"),
                        Spacer(
                          flex: 3,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {},
                          child: Text("Update Task"),
                        ),
                        Spacer(
                          flex: 4,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),*/ //
    );
  }
}
