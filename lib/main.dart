import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/enums.dart';
import 'package:amazon_clone/feature/admin/screens/admin_screen.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screens.dart';
import 'package:amazon_clone/feature/auth/services/auth_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AuthService().getUserData(context: context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      title: 'Amazon clone',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == UserType.user.name
              ? const Bottombar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
