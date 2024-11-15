import 'package:flutter/material.dart';
import 'package:frontend/models/faculty_model.dart';

class FacultyProvider extends ChangeNotifier {
  Faculty _faculty = Faculty(
      FacultyId: "--",
      FacultyName: "--",
      FacultyDesignation: "--",
      FacultyPhnNo: "--",
      FacultyDepartment: "--",
      Classes: [],
      IsAdmin: false,
      AcceptedSubstitueInfo: [],
      InQueueSubstituteInfo: []);

  Faculty get faculty => _faculty;

  void setFaculty(String faculty) {
    _faculty = Faculty.fromJson(faculty);
    notifyListeners();
  }

  void setFacultyFromModel(Faculty faculty) {
    _faculty = faculty;
  }
}
