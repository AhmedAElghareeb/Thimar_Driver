import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar_driver/features/notifications/bloc.dart';
import 'package:thimar_driver/features/notifications/events.dart';
import 'package:thimar_driver/features/notifications/states.dart';
import 'card.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final bloc = KiwiContainer().resolve<NotificationsBloc>()
    ..add(
      GetNotificationsEvent(),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الإشعارات",
        ),
      ),
      body: SafeArea(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is NotificationsLoadingState) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is NotificationsSuccessState) {
              return ListView.builder(
                itemBuilder: (context, index) => ItemCard(
                  model: state.notifications[index],
                ),
                itemCount: state.notifications.length,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }
}