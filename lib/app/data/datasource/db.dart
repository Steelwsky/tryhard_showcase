import 'groups/basic_exercises.dart';
import 'groups/calendar.dart';
import 'groups/exercises.dart';
import 'groups/user.dart';
import 'groups/workouts.dart';

abstract class Database
    implements
        UserGroupApi,
        CalendarGroupApi,
        WorkoutsGroupApi,
        BasicExercisesGroupApi,
        ExercisesGroupApi {}
