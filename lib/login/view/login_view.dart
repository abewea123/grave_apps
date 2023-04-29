import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grave_apps/config/toast_view.dart';
import 'package:grave_apps/login/controller/login_controller.dart';

class ViewLogin extends StatelessWidget {
  ViewLogin({super.key});
  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GetBuilder<LoginController>(builder: (_) {
          return Center(
            child: SizedBox(
              width: 800,
              child: Form(
                key: _loginController.formKey,
                child: SingleChildScrollView(
                  // padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.adaptive.arrow_back),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Log Masuk',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Selamat kembali!',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        const Spacer(flex: 1),
                        TextFormField(
                          autofocus: true,
                          controller: _loginController.emailText,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            errorText: _loginController.errorEmail,
                          ),
                          validator: (value) {
                            bool validate = _loginController.checkEmail(value!);
                            if (!validate) {
                              return 'Sila masukkan email dengan betul!';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            _loginController.passwordFocus.requestFocus();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          focusNode: _loginController.passwordFocus,
                          controller: _loginController.passwordText,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            label: const Text('Kata laluan'),
                            errorText: _loginController.errorPassword,
                          ),
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Kata laluan anda mesti melebihi 6 aksara!';
                            }
                            return null;
                          },
                          onEditingComplete: () async {
                            final user = await _loginController.login();
                            await Future.delayed(const Duration(seconds: 1));
                            if (user != null && context.mounted) {
                              ToastView.success(context,
                                  title: 'Log Masuk Berjaya',
                                  subtitle:
                                      'Selamat kembali ${user.displayName}!',
                                  icon: Icons.person);
                              Get.back();
                              Get.back();
                            }
                          },
                        ),
                        const Spacer(flex: 2),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text:
                                  'Tidak mempunyai akaun pengurusan? Hubungi ',
                              children: [
                                TextSpan(
                                  text: 'Wan Luqman',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final user = await _loginController.login();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                if (user != null && context.mounted) {
                                  ToastView.success(context,
                                      title: 'Log Masuk Berjaya',
                                      subtitle:
                                          'Selamat kembali ${user.displayName}',
                                      icon: Icons.person);
                                  Get.back();
                                  Get.back();
                                }
                              },
                              child: const Text('Log Masuk'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
