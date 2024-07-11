import 'dart:async';
import 'package:gamerconnect/themes/theme.dart';
import 'package:gamerconnect/views/views.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SplashView extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SplashView(),
      );
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplasViewState();
}

class _SplasViewState extends State<SplashView> {
  late final StreamSubscription<firebase.User?> listener;

  @override
  void initState() {
    super.initState();
    _handleAuthenticatedState();
  }

  Future<void> _handleAuthenticatedState() async {
    final auth = firebase.FirebaseAuth.instance;
    if (!mounted) {
      return;
    }
    listener = auth.authStateChanges().listen((user) async {
      if (user != null) {
        // get Stream user token
        final callable =
            FirebaseFunctions.instance.httpsCallable('getStreamUserToken');

        final results = await Future.wait([
          callable(),
          // delay to show loading indicator
          Future.delayed(const Duration(milliseconds: 700)),
        ]);

        // connect Stream user
        final client = StreamChatCore.of(context).client;
        await client.connectUser(
          User(id: user.uid),
          results[0]!.data,
        );

        // authenticated
        Navigator.of(context).pushReplacement(HomeView.route);
      } else {
        // delay to show loading indicator
        await Future.delayed(const Duration(milliseconds: 700));
        // not authenticated
        Navigator.of(context).pushReplacement(SignInView.route);
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}