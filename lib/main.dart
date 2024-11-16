import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/widgets/bottom_bar.dart';
import 'features/admin/screens/admin_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>UserProvider()),
  ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices=AuthServices();
  @override
  void initState() {
    super.initState();
    authServices.getUserData(context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariable.backgroundColor,
        colorScheme: ColorScheme.light(
          primary: GlobalVariable.secondaryColor,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: GlobalVariable.secondaryColor, // Set AppBar color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalVariable.secondaryColor, // Set button color
          ),
        ),
      ),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? (Provider.of<UserProvider>(context).user.type == 'user'
            ? BottomBar()
            : AdminScreen())
            : AuthScreen(),
    );
  }
}
