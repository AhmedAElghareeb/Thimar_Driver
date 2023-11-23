import 'package:kiwi/kiwi.dart';
import '../../features/authentication/bloc.dart';
import '../../features/home/bloc.dart';
import '../../features/notifications/bloc.dart';
import '../../features/orders/bloc.dart';
import 'dio_helper.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();

  container.registerInstance((c) => DioHelper());

  container.registerFactory((c) => AuthenticationBloc());

  container.registerFactory((c) => HomeBloc());

  container.registerFactory((c) => OrdersBloc());

  container.registerFactory((c) => NotificationsBloc());
}