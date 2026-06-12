import 'package:drift/drift.dart';

import 'database_connection.dart';

part 'app_database.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  IntColumn get savingsPower =>
      integer().check(CustomExpression<bool>('savings_power >= 1'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get goalName => text().withLength(min: 1, max: 200)();
  IntColumn get targetAmount =>
      integer().check(CustomExpression<bool>('target_amount > 0'))();
  DateTimeColumn get targetMonth => dateTime()();
  IntColumn get initialSavings =>
      integer().check(CustomExpression<bool>('initial_savings >= 0'))();
  IntColumn get currentSavings =>
      integer().check(CustomExpression<bool>('current_savings >= 0'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
    'CHECK (initial_savings <= target_amount)',
    'CHECK (current_savings <= target_amount)',
  ];
}

class GoalTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId =>
      integer().references(Goals, #id, onDelete: KeyAction.cascade)();
  TextColumn get type =>
      text().check(CustomExpression<bool>("type IN ('add', 'withdraw')"))();
  IntColumn get amount =>
      integer().check(CustomExpression<bool>('amount > 0'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [Profiles, Goals, GoalTransactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? openDatabaseConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
