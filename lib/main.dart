import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharadtech/core/api/service_locator.dart';
import 'package:tharadtech/core/helper/logger.dart';
import 'package:tharadtech/core/helper/shared_pref_service.dart';
import 'package:tharadtech/core/helper/simple_bloc_observer.dart';
import 'package:tharadtech/my_app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  final token = await SharedPrefService.getSecuredString(SharedPrefService.storedToken);
  loggerInfo('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  token : $token');
  runApp(MyApp());
}