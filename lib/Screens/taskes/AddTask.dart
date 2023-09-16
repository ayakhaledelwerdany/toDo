import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Shared/network/firebase/firebase_function.dart';
import '../../model/task_model.dart';
import '../../provider/my_provider.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();

  var describtionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Form(
      key: formKey,
      child: Container(
        color: provider.changeColors(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: provider.changeFontColor(),
                ),
              ),
              TextFormField(
                style: TextStyle(color: provider.changeFontColor()),
                controller: titleController,
                validator: (value) {
                  if (value!.toString().length < 4) {
                    return 'please enter title at least 4 char';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: provider.changeFontColor())),
                    labelText: AppLocalizations.of(context)!.enterTask,
                    labelStyle: TextStyle(color: provider.changeFontColor())),
              ),
              TextFormField(
                style: TextStyle(color: provider.changeFontColor()),
                controller: describtionController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: provider.changeFontColor())),
                    labelText: AppLocalizations.of(context)!.describeTask,
                    labelStyle: TextStyle(color: provider.changeFontColor())),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: provider.changeFontColor()),
                ),
              ),
              InkWell(
                onTap: () {
                  chooseDateTime();
                },
                child: Text(
                  selectedDate.toString().substring(0, 10),
                  // DateFormat.Md().format(selectedDate).toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: provider.changeFontColor()),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        title: titleController.text,
                        describtion: describtionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch);
                    FirebaseFunctions.addTask(task);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: Icon(Icons.done),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void chooseDateTime() async {
    DateTime? chooseDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }
}
