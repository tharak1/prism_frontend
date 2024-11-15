import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/services/ip.dart';
import 'package:http/http.dart ' as http;

class ChangeAcedemicsScreen extends StatefulWidget {
  const ChangeAcedemicsScreen({super.key});

  @override
  State<ChangeAcedemicsScreen> createState() => _ChangeAcedemicsScreen();
}

class _ChangeAcedemicsScreen extends State<ChangeAcedemicsScreen> {
  // String _selectedRegulation = 'MR21';
  // String _selectedSemester = '1';
  final regulationController = TextEditingController();
  final semesterController = TextEditingController();
  // String _selectedMonth = 'January';
  bool dataFetched = false;
  int _numberOfHolidays = 0;
  int numberOfMonths = 0;
  List<String> regulations = ['MR21', 'MR22', 'MR23'];
  List<String> semesters = ['1', '2', '3'];
  List<String> months = [
    // 'January',
    // 'February',
    // 'March',
    // 'April',
    // 'May',
    // 'June',
    // 'July',
    // 'August',
    // 'September',
    // 'October',
    // 'November',
    // 'December'
  ];

  List<String> generateList(int number) {
    return List<String>.generate(number, (index) => (index + 1).toString());
  }

  Widget set = Center(child: Text("Hello"));

  @override
  Widget build(BuildContext context) {
    if (dataFetched == true) {
      List<String> months = generateList(numberOfMonths);
      String _selectedMonth = '1';
      set = Column(
        children: [
          SizedBox(height: 20.0),
          Text('Select Month:'),
          DropdownButton<String>(
            value: _selectedMonth,
            onChanged: (newValue) {
              setState(() {
                _selectedMonth = newValue!;
              });
            },
            items: months.map((month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(month),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          Text('Number of Holidays:'),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _numberOfHolidays = int.tryParse(value) ?? 0;
              });
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              try {
                var response = await http.post(
                  Uri.parse(
                      '${ip}/api/semesterdata/update?regulation=${regulationController.text.toUpperCase()}&semester=${semesterController.text.toUpperCase()}&month=${_selectedMonth}'),
                  body: jsonEncode({"intValue": _numberOfHolidays}),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                );
                print(response.statusCode);
                print(jsonDecode(response.body));
              } catch (err) {
                print(err);
              }
            },
            child: Text('Update Holidays'),
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Holiday Updater'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: regulationController,
              decoration: InputDecoration(labelText: 'Regulation'),
            ),
            TextFormField(
              controller: semesterController,
              decoration: InputDecoration(labelText: 'Semester'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  var response = await http.get(Uri.parse(
                      '${ip}/api/semesterdata/fetch?regulation=${regulationController.text.toUpperCase()}&semester=${semesterController.text.toUpperCase()}'));
                  if (response.statusCode == 200) {
                    setState(() {
                      dataFetched = true;
                      numberOfMonths = jsonDecode(response.body);
                    });
                  }
                  print(jsonDecode(response.body));
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Fetch Data'),
            ),
            set,
          ],
        ),
      ),
    );
  }
}
