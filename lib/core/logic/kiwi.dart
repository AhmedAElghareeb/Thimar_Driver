import 'package:kiwi/kiwi.dart';
import '../../features/authentication/bloc.dart';
import 'dio_helper.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();

  container.registerInstance((c) => DioHelper());

  container.registerFactory((c) => AuthenticationBloc());
}