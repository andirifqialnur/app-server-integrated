import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/pages/edit_profile_page.dart';
import 'package:shoes_app/pages/home/main_page.dart';
import 'package:shoes_app/pages/host/container_page.dart';
import 'package:shoes_app/pages/host/detail_container_page.dart';
import 'package:shoes_app/pages/host/detail_vm_page.dart';
import 'package:shoes_app/pages/host/edit_container_page.dart';
import 'package:shoes_app/pages/host/edit_vm_page.dart';
import 'package:shoes_app/pages/host/host_info_page.dart';
import 'package:shoes_app/pages/host/host_login_page.dart';
import 'package:shoes_app/pages/host/vm_page.dart';
import 'package:shoes_app/pages/sign_in_page.dart';
import 'package:shoes_app/pages/sign_up_page.dart';
import 'package:shoes_app/pages/splash_page.dart';
import 'package:shoes_app/providers/auth_provider.dart';
import 'package:shoes_app/providers/host_provider.dart';
import 'package:shoes_app/providers/page_provider.dart';
// import 'package:shoes_app/theme/theme_manager.dart';

import 'pages/home/host_page.dart';

void main() async {
  runApp(const MyApp());
}

// ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HostProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: const SplashPage(),
        // theme: lightTheme,
        // darkTheme: darkTheme,
        // themeMode: _themeManager.themeMode,
        routes: {
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/home': (context) => const MainPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/host': (context) => const HostPage(),
          '/host-login': (context) => const HostLogin(),
          '/host-info': (context) => const HostInfoPage(),
          '/vm': (context) => const VMPage(),
          '/container': (context) => const ContainerPage(),
          '/detail-vm': (context) => const DetailVMPage(),
          '/detail-container': (context) => const DetailContainerPage(),
          '/edit-vm': (context) => const EditVMPage(),
          '/edit-container': (context) => const EditContainerPage(),
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
