import 'package:kiwi/kiwi.dart';
import '../../features/account/about_app/bloc.dart';
import '../../features/authentication/bloc.dart';
import '../../features/home/bloc.dart';
import '../../features/notifications/bloc.dart';
import '../../features/orders/bloc.dart';
import 'dio_helper.dart';

void initKiwi() {
  KiwiContainer c = KiwiContainer();

  c.registerSingleton((container) => DioHelper());

  c.registerFactory((container) => AuthenticationBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => HomeBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => OrdersBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => NotificationsBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => AboutAppBloc(container.resolve<DioHelper>()));
}