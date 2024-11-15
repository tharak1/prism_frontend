// import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/Faculty_Module/main_screen.dart';
// import 'package:frontend/providers.dart/time_table_view_provider.dart';
// import 'package:frontend/widgets/multi_purpose_card.dart';
// import 'package:provider/provider.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key, required this.title});

//   final String title;

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   DateTime date = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final FTP = Provider.of<FacultyTimeTableProvider>(context, listen: false)
//         .facultyTimeTable;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Column(
//         children: [
//           _customBackgroundExample(),
//           Expanded(
//             child: date.weekday <= 6
//                 ? FTP.TimeTable[date.weekday - 1].Periods.isNotEmpty
//                     ? ListView.builder(
//                         itemCount:
//                             FTP.TimeTable[date.weekday - 1].Periods.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final temp =
//                               FTP.TimeTable[date.weekday - 1].Periods[index];
//                           return MultiPurposeCard(
//                             category:
//                                 "${temp.Department}-${temp.Section} ${temp.StartTime} - ${temp.EndTime}\n${temp.SubjectName}",
//                             height1: 70,
//                             screen: MainScreen(
//                               department: temp.Department,
//                               section: temp.Section,
//                               regulation: temp.Regulation,
//                               startTime: temp.StartTime,
//                               endTime: temp.EndTime,
//                             ),
//                           );
//                         },
//                       )
//                     : Text("No Classes")
//                 : Text("Today is sunday"),
//           ),
//         ],
//       ),
//     );
//   }

//   EasyDateTimeLine _customBackgroundExample() {
//     return EasyDateTimeLine(
//       initialDate: DateTime.now(),
//       onDateChange: (selectedDate) {
//         //`selectedDate` the new date selected.
//         setState(() {
//           date = selectedDate;
//         });
//       },
//       headerProps: const EasyHeaderProps(
//         monthPickerType: MonthPickerType.switcher,
//         dateFormatter: DateFormatter.fullDateDMY(),
//       ),
//       dayProps: const EasyDayProps(
//         dayStructure: DayStructure.dayStrDayNum,
//         activeDayStyle: DayStyle(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xff3371FF),
//                 Color(0xff8426D6),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
