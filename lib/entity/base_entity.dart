import 'package:get_it/get_it.dart';

import '../database/database.dart';

class BaseEntity {

  AppDatabase get database => GetIt.I<AppDatabase>();
}