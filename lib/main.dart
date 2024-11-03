// main.dart
import 'package:flutter/material.dart';
import 'package:mobiledev/api/const.dart';
import 'package:mobiledev/api/const_api.dart';
import 'package:mobiledev/helper/cach.dart';
import 'package:mobiledev/helper/observer.dart';
import 'package:mobiledev/Orders/order_page.dart';
import 'package:mobiledev/landing_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobiledev/screens/auth/cubit/auth_cubit.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();

  TOKEN = await CachHelper.getData(key: tokenCache) ?? '';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        home: TOKEN == ''
            ? LandingPage()
            : HomePage(),
      ),
    );
  }
}
