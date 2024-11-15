// import 'package:flutter/material.dart';
// import 'package:frontend/providers/attendance_provider.dart';
// import 'package:frontend/screens/AttendanceScreens/monthly_attendance_screen.dart';

// import 'package:frontend/services/auth.dart';
// import 'package:frontend/widgets/attendance_guage.dart';
// import 'package:frontend/widgets/linear_progress_bar.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});

//   @override
//   State<AttendanceScreen> createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   final Authservice authService = Authservice();

//   @override
//   void initState() {
//     super.initState();
//     // authService.getAttendance(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userAttendance = Provider.of<AttendanceProvider>(context).attendance;
//     final formatter = DateFormat.yMMMEd();
//     String formattedDate() {
//       return formatter.format(DateTime.now());
//     }

//     Widget dayStatus = Center(
//       child: Text(
//         "Absent",
//         style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 0, 0)),
//       ),
//     );
//     if (userAttendance.DayPresent == 1) {
//       dayStatus = Center(
//         child: Text(
//           "Half Day Present",
//           style:
//               TextStyle(fontSize: 25, color: Color.fromARGB(255, 182, 100, 0)),
//         ),
//       );
//     } else if (userAttendance.DayPresent == 2) {
//       dayStatus = Center(
//         child: Text(
//           "Full Day Present",
//           style:
//               TextStyle(fontSize: 25, color: Color.fromARGB(255, 18, 182, 0)),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Attendance"),
//             Image.asset(
//               'assets/MREC_logo.png',
//               height: MediaQuery.of(context).size.height / 8,
//               width: MediaQuery.of(context).size.width / 8,
//             ),
//           ],
//         ),
//         elevation: 1,
//         backgroundColor: Colors.white,
//         shadowColor: Colors.grey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text("This is your attendace summary"),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height / 4,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.28),
//                     offset: Offset(0, 2),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 color: Colors.white,
//                 surfaceTintColor: Colors.blue,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       "Total percentage ",
//                       style: TextStyle(
//                           fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
//                     ),
//                     Stack(
//                       children: [
//                         SizedBox(
//                           child: Center(
//                             child: AttendanceGuage(
//                               totalAttendance:
//                                   double.parse(userAttendance.SemPercentage) /
//                                       100,
//                             ),
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height / 14,
//                             ),
//                             SizedBox(
//                               child: Center(
//                                 child: Text(
//                                   "${userAttendance.SemPercentage}%",
//                                   style: TextStyle(
//                                       fontSize: 35,
//                                       color: Color.fromARGB(255, 0, 0, 0)),
//                                 ),
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MonthlyAttendance(),
//                   ),
//                 );
//               },
//               child: Container(
//                 height: MediaQuery.of(context).size.height / 5,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(25.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.28),
//                       offset: Offset(0, 2),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   color: Colors.white,
//                   surfaceTintColor: Colors.blue,
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Monthly Percentage',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                             Text(
//                               '${userAttendance.MonthlyPercentage}%',
//                               style: TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF114F5A)),
//                             ),
//                           ],
//                         ),
//                         LinearProgressBar(
//                           progressPer:
//                               double.parse(userAttendance.MonthlyPercentage) /
//                                   100,
//                           barcolor: const Color.fromARGB(255, 243, 180, 33),
//                         ),
//                         Text(
//                           'tap to show more',
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w100,
//                               fontStyle: FontStyle.italic),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height / 4,
//                   width: MediaQuery.of(context).size.width / 2.2,
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     color: Colors.white,
//                     surfaceTintColor: Colors.blue,
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             "Date  ",
//                             style: TextStyle(
//                                 fontSize: 35,
//                                 color: Color.fromARGB(255, 0, 0, 0)),
//                           ),
//                           Text(
//                             formattedDate(),
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 color: Color.fromARGB(255, 0, 0, 0)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height / 4,
//                   width: MediaQuery.of(context).size.width / 2.2,
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     color: Colors.white,
//                     surfaceTintColor: Colors.blue,
//                     child: Padding(
//                       padding: EdgeInsets.all(30.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             "Day ",
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 color: Color.fromARGB(255, 0, 0, 0)),
//                           ),
//                           dayStatus,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/providers/attendance_provider.dart';
import 'package:frontend/screens/AttendanceScreens/monthly_attendance_screen.dart';

import 'package:frontend/services/auth.dart';
import 'package:frontend/widgets/attendance_guage.dart';
import 'package:frontend/widgets/linear_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final Authservice authService = Authservice();

  @override
  void initState() {
    super.initState();
    // authService.getAttendance(context);
  }

  @override
  Widget build(BuildContext context) {
    final userAttendance = Provider.of<AttendanceProvider>(context).attendance;
    final formatter = DateFormat.yMMMEd();
    String formattedDate() {
      return formatter.format(DateTime.now());
    }

    Widget dayStatus = Center(
      child: Text(
        "Absent",
        style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 0, 0)),
      ),
    );
    if (userAttendance.DayPresent == 1) {
      dayStatus = Center(
        child: Text(
          "Half Day Present",
          style:
              TextStyle(fontSize: 25, color: Color.fromARGB(255, 182, 100, 0)),
        ),
      );
    } else if (userAttendance.DayPresent == 2) {
      dayStatus = Center(
        child: Text(
          "Full Day Present",
          style:
              TextStyle(fontSize: 25, color: Color.fromARGB(255, 18, 182, 0)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Attendance"),
            Image.asset(
              'assets/MREC_logo.png',
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("This is your attendace summary"),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.28),
                    offset: Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Colors.white,
                surfaceTintColor: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total percentage ",
                      style: TextStyle(
                          fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          child: Center(
                            child: AttendanceGuage(
                              totalAttendance:
                                  double.parse(userAttendance.SemPercentage) /
                                      100,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 14,
                            ),
                            SizedBox(
                              child: Center(
                                child: Text(
                                  "${userAttendance.SemPercentage}%",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonthlyAttendance(),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.28),
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Colors.white,
                  surfaceTintColor: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Monthly Percentage',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '${userAttendance.MonthlyPercentage}%',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF114F5A)),
                            ),
                          ],
                        ),
                        LinearProgressBar(
                          progressPer:
                              double.parse(userAttendance.MonthlyPercentage) /
                                  100,
                          barcolor: const Color.fromARGB(255, 243, 180, 33),
                        ),
                        Text(
                          'tap to show more',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.white,
                    surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Date  ",
                            style: TextStyle(
                                fontSize: 28,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          Text(
                            formattedDate(),
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.white,
                    surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Day ",
                            style: TextStyle(
                                fontSize: 28,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          dayStatus,
                        ],
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
