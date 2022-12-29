const String tableName = 'users';

const String columnId = 'user_id';
const String columnFirstName = 'user_first_name';
const String columnLastName = 'user_last_name';
const String columnBirthDate = 'user_birth_date';

// ====================================
// No comma after last column!!!
// ====================================
const String createTableQuery = '''
CREATE TABLE IF NOT EXISTS $tableName (
$columnId integer PRIMARY KEY AUTOINCREMENT,
$columnFirstName text,
$columnLastName text,
$columnBirthDate text
);
''';
