import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:newtodo/Screens/taskes/task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Shared/network/firebase/firebase_function.dart';
import '../../styles/colors/app_colors.dart';

class TaskTap extends StatefulWidget {
  @override
  State<TaskTap> createState() => _TaskTapState();
}

class _TaskTapState extends State<TaskTap> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: primaryColor,
          dayColor: primaryColor.withOpacity(.5),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primaryColor,
          dotsColor: Colors.black,
          //دا لو عايزه اقفل يوم معين زي الاجازات السنويه مثلا
          //   selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        StreamBuilder(
            stream: FirebaseFunctions.getTaskes(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text('something went wrong ');
              }
              var taskes =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (taskes.isEmpty) {
                return Center(
                    child: Text(AppLocalizations.of(context)!.noTasks));
              }
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel: taskes[index],
                    );
                  },
                  itemCount: taskes.length,
                ),
              );
            }),
      ],
    );
  }
}
