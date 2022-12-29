import 'package:test_db/database/users_table.dart' as users;
import 'package:intl/intl.dart';


class User {
  int id;
  String firstName;
  String lastName;
  DateTime? birthDate;

  User({
    this.id = -1,
     this.firstName = '',
     this.lastName = '', 
     this.birthDate
  });

  User.fromMap(Map<String, dynamic> map) : 
    id = map[users.columnId],
    firstName = map[users.columnFirstName] as String,
    lastName  = map[users.columnLastName] as String,
    birthDate = (map[users.columnBirthDate] is DateTime)
      ? map[users.columnBirthDate]
      : DateTime.parse(map[users.columnBirthDate]);


  String get formattedBirthDate => 
    (birthDate != null) ? DateFormat('dd.MM.y').format(birthDate!) : '';

  int get age {
    if (birthDate == null) return 0;

    final now = DateTime.now();
    int age = now.year - birthDate!.year;
  
    if (now.difference(DateTime(now.year, birthDate!.month, birthDate!.day)).inHours < 0) {
      age--;
    }
  
    return age;
  }

  String get formattedAge {
    final int ageFraction = age % 10;

    if (ageFraction == 1) return '$age рік';
    if (ageFraction > 1 && ageFraction < 5) return '$age роки';
    return '$age років';
  }


  Map<String, Object?> toMap() => {
    if (id != null) users.columnId: id,
    users.columnFirstName: firstName,
    users.columnLastName: lastName,
    users.columnBirthDate: birthDate.toString()
  };

  bool operator ==(Object other) {
    return identical(this, other) || other is User && this.toString() == other.toString();
  }

  @override
  String toString() {
    return 'User{id: $id, name: $firstName, lastName: $lastName, birthDate: $formattedBirthDate}';
  }
}
