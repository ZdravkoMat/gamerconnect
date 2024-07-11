import 'package:flutter/material.dart';
import 'package:gamerconnect/app.dart';
import 'package:gamerconnect/themes/theme.dart';
import 'package:gamerconnect/views/views.dart';
import 'package:gamerconnect/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';


class ProfileView extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const ProfileView(),
      );

  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? _selectedPlaystyle;

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: 'hero-profile-picture',
              child: Avatar.large(url: user?.image),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user?.name ?? 'No name'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: AppColors.primaryDark, // Changes the arrow icon color
                  canvasColor: AppColors.primaryDark, // Changes the dropdown background color
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedPlaystyle,
                  decoration: const InputDecoration(
                    labelText: 'Playstyle',
                    labelStyle: TextStyle(color: AppColors.primaryDark), // Changes the label text color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryDark), // Changes the border color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryDark), // Changes the border color when focused
                    ),
                  ),
                  items: <String>['Casual', 'Advanced', 'Competitive', 'Professional']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: AppColors.onPrimaryDark), // Changes the dropdown item text color
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPlaystyle = newValue;
                    });
                  },
                ),
              ),
            ),
            const Divider(),
            const _SignOutButton(),
          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  __SignOutButtonState createState() => __SignOutButtonState();
}

class __SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async {
    setState(() {
      _loading = true;
    });

    try {
      await StreamChatCore.of(context).client.disconnectUser();
      await firebase.FirebaseAuth.instance.signOut();

      Navigator.of(context).pushReplacement(SplashView.route);
    } on Exception catch (e, st) {
      logger.e('Could not sign out', e, st);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: _signOut,
            child: const Text('Sign out'),
          );
  }
}