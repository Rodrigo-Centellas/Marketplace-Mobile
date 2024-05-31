import 'package:flutter/material.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import 'package:shop_app/Api/api_service_logout.dart';
import 'package:shop_app/Api/token_storage_service.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenStorageService = TokenStorageService(); // Crear instancia

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () async {
                try {
                  final token = await TokenStorageService.getToken();
                  if (token == null) {
                    // Manejar el caso cuando no hay un token válido
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'No valid token found. Please log in again.')),
                    );
                    Navigator.pushReplacementNamed(
                        context, SignInScreen.routeName);
                    return;
                  }

                  final apiService = ApiService();
                  await apiService.logout(token);
                  Navigator.pushReplacementNamed(
                      context, SignInScreen.routeName);
                  await TokenStorageService.deleteToken();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error during logout: $e')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}



  //  ProfileMenu(
  //             text: "My Account",
  //             icon: "assets/icons/User Icon.svg",
  //             press: () {},
  //           ),
  //           ProfileMenu(
  //             text: "Notifications",
  //             icon: "assets/icons/Bell.svg",
  //             press: () {},
  //           ),
  //           ProfileMenu(
  //             text: "Settings",
  //             icon: "assets/icons/Settings.svg",
  //             press: () {},
  //           ),
  //           ProfileMenu(
  //             text: "Help Center",
  //             icon: "assets/icons/Question mark.svg",
  //             press: () {},
  //           ),