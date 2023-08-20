import 'package:get_it/get_it.dart';

import '../../data/database/database.dart';

class BaseEntity {

  AppDatabase get database => GetIt.I<AppDatabase>();
}