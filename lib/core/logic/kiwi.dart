import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/features/notifications/bloc.dart';
import '../../features/authentication/bloc.dart';
import 'dio_helper.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();

  container.registerInstance((c) => DioHelper());

  container.registerFactory((c) => AuthenticationBloc());

  container.registerFactory((c) => NotificationsBloc());
}