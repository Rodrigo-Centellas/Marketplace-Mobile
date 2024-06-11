// import 'package:flutter/material.dart';
// import '../../../components/custom_surfix_icon.dart';
// import '../../../components/form_error.dart';
// import '../../../constants.dart';
// import '../../../helper/keyboard.dart';
// import 'package:shop_app/Api/api_service.dart'; // Asegúrate de tener esta importación
// import '../../forgot_password/forgot_password_screen.dart';
// import '../../login_success/login_success_screen.dart';

// class SignForm extends StatefulWidget {
//   const SignForm({super.key});

//   @override
//   _SignFormState createState() => _SignFormState();
// }

// class _SignFormState extends State<SignForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   bool? remember = false;
//   final List<String?> errors = [];
//   bool _isLoading = false; // Para controlar la visualización del indicador de carga

//   void addError({String? error}) {
//     if (!errors.contains(error)) {
//       setState(() {
//         errors.add(error);
//       });
//     }
//   }

//   void removeError({String? error}) {
//     if (errors.contains(error)) {
//       setState(() {
//         errors.remove(error);
//       });
//     }
//   }

//   // Método para realizar el login
//   void _login() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     _formKey.currentState!.save();
//     setState(() => _isLoading = true);
//     try {
//       final authResponse = await ApiService().login(email!, password!);
//       if (authResponse.accessToken.isNotEmpty) {
//         Navigator.pushNamed(context, LoginSuccessScreen.routeName);
//       } else {
//         addError(error: "Login failed");
//       }
//     } catch (e) {
//       addError(error: e.toString());
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildEmailFormField(),
//           const SizedBox(height: 20),
//           buildPasswordFormField(),
//           const SizedBox(height: 20),
//           buildRememberMeCheckbox(),
//           FormError(errors: errors),
//           const SizedBox(height: 16),
//           _isLoading ? CircularProgressIndicator() : buildLoginButton(),
//         ],
//       ),
//     );
//   }

//   TextFormField buildEmailFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       onSaved: (newValue) => email = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kEmailNullError);
//         } else if (emailValidatorRegExp.hasMatch(value)) {
//           removeError(error: kInvalidEmailError);
//         }
//         return;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kEmailNullError);
//           return "";
//         } else if (!emailValidatorRegExp.hasMatch(value)) {
//           addError(error: kInvalidEmailError);
//           return "";
//         }
//         return null;
//       },
//       decoration: const InputDecoration(
//         labelText: "Email",
//         hintText: "Ingresa tu correo",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
//       ),
//     );
//   }

//   TextFormField buildPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) => password = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kPassNullError);
//         } else if (value.length >= 1) {
//           removeError(error: kShortPassError);
//         }
//         return;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kPassNullError);
//           return "";
//         } else if (value.length < 1) {
//           addError(error: kShortPassError);
//           return "";
//         }
//         return null;
//       },
//       decoration: const InputDecoration(
//         labelText: "Password",
//         hintText: "Ingrese su contraseña",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//       ),
//     );
//   }

//   Row buildRememberMeCheckbox() {
//     return Row(
//       children: [
//         Checkbox(
//           value: remember,
//           activeColor: kPrimaryColor,
//           onChanged: (value) {
//             setState(() {
//               remember = value;
//             });
//           },
//         ),
//         const Text("Remember me"),
//         const Spacer(),
//         GestureDetector(
//           onTap: () => Navigator.pushNamed(
//               context, ForgotPasswordScreen.routeName),
//           child: const Text(
//             "Forgot Password",
//             style: TextStyle(decoration: TextDecoration.underline),
//           ),
//         )
//       ],
//     );s
//   }

//   ElevatedButton buildLoginButton() {
//     return ElevatedButton(
//       onPressed: _login,
//       child: const Text("Continue"),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';
import 'package:shop_app/Api/api_service.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../login_success/login_success_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
  bool _isLoading = false;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    try {
      final authResponse = await ApiService().login(email!, password!);
      if (authResponse.accessToken.isNotEmpty) {
        Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      } else {
        addError(error: "Login failed");
      }
    } catch (e) {
      addError(error: e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(height: 20),
          buildPasswordFormField(),
          const SizedBox(height: 20),
          buildRememberMeCheckbox(),
          FormError(errors: errors),
          const SizedBox(height: 16),
          _isLoading ? CircularProgressIndicator() : buildLoginButton(),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Ingresa tu correo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 1) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 1) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Ingrese su contraseña",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  Row buildRememberMeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: remember,
          activeColor: kPrimaryColor,
          onChanged: (value) {
            setState(() {
              remember = value;
            });
          },
        ),
        const Text("Remember me"),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
          child: const Text(
            "Forgot Password",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      child: const Text("Continue"),
    );
  }
}
