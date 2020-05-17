

class Course {
  final int id;
  final String name;
  final String professor;
  final int students;

  Course({this.id, this.name, this.professor, this.students});

    Course.initial()
      : id = 0,
        name = '',
        professor = '',
        students = 0;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      professor: json['professor'],
      students: json['students'],
    );
  }
}