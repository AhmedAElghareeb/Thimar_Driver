import 'package:thimar_driver/features/orders/accept_order/bloc.dart';
import 'package:thimar_driver/features/orders/finish_deliver/bloc.dart';
import 'package:thimar_driver/features/orders/refuse_order/bloc.dart';
import 'package:thimar_driver/features/orders/start_deliver/bloc.dart';

import 'dio_helper.dart';
import 'package:kiwi/kiwi.dart';
import '../../features/account/contact_us/bloc.dart';
import '../../features/account/faqs/bloc.dart';
import '../../features/account/suggestions_complaints/bloc.dart';
import '../../features/account/about_app/bloc.dart';
import '../../features/account/policy/bloc.dart';
import '../../features/authentication/bloc.dart';
import '../../features/home/bloc.dart';
import '../../features/notifications/bloc.dart';
import '../../features/orders/bloc.dart';


void initKiwi() {
  KiwiContainer c = KiwiContainer();

  c.registerSingleton((container) => DioHelper());

  ///Blocs
  c.registerFactory((container) => AuthenticationBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => HomeBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => OrdersBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => RefuseOrderBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => AcceptOrderBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => StartDeliverBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => FinishDeliverBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => NotificationsBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => AboutAppBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => PolicyBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => FaqsBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => SuggestionsAndComplaintsBloc(container.resolve<DioHelper>()));
  c.registerFactory((container) => ContactUsBloc(container.resolve<DioHelper>()));
}