import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtodo/Screens/edit_screen/editScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Shared/network/firebase/firebase_function.dart';
import '../../model/task_model.dart';
import '../../provider/my_provider.dart';
import '../../styles/colors/app_colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;
  TaskItem({required this.taskModel});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Card(
      color: provider.changeColors(),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(taskModel.id);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: AppLocalizations.of(context)!.delete,
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditScreen.routeName,
                  arguments: taskModel);
            },
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: AppLocalizations.of(context)!.edit,
          ),
        ]),
        child: Container(
          margin: EdgeInsets.all(18),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                  height: 65,
                  width: 4,
                  color: taskModel.isDone ? Colors.green : primaryColor,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: GoogleFonts.quicksand(
                        fontSize: 18,
                        color: taskModel.isDone ? Colors.green : primaryColor),
                  ),
                  Text(
                    taskModel.describtion,
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  taskModel.isDone = !taskModel.isDone;
                  FirebaseFunctions.updateTask(taskModel);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: taskModel.isDone ? Colors.green : primaryColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
