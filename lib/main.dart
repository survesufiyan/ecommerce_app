import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/user_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/order_confirmation_screen.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
        // FIX: Register UserProvider so EditProfileScreen can read/write it
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'ShopHub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/main': (context) => const MainNavigationScreen(),
          '/order-confirmation': (context) => const OrderConfirmationScreen(),
        },
      ),
    );
  }
}
