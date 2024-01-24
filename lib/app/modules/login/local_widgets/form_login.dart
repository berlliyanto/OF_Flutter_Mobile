import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/form/form_auth.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/password_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/modules/login/controllers/login_controller.dart';

Widget formLogin(
    {required GlobalKey formKey,
    required String title,
    required LoginController builder}) {
  return FormAuth(
    formKey: formKey,
    children: [
      const Heading(
          heading: "h1", size: 26, text: "Sign In", textAlign: TextAlign.start),
      const Gap(15),
      TextInput(
        controller: builder.usernameController,
        label: "Username",
        onTap: () => builder.hideLogoOnFocus(),
        onEditingComplete: () => builder.showLogoOnUnfocus(),
        onTapOutside: (pointer) => builder.showLogoOnUnfocus(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your username";
          }
          return null;
        },
      ),
      const Gap(15),
      TextInputPassword(
        isObscure: builder.isObscure.value,
        controller: builder.passwordController,
        label: "Password",
        onTap: () => builder.hideLogoOnFocus(),
        onEditingComplete: () => builder.showLogoOnUnfocus(),
        onTapOutside: (pointer) => builder.showLogoOnUnfocus(),
        toggleObscure: () => builder.toggleObscure(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your Password";
          }
          return null;
        },
      ),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Paragraph(text: "Don't have an account?"),
          const Gap(5),
          GestureDetector(
            onTap: () => Get.toNamed('/register'),
            child: const Paragraph(
              text: "Sign Up",
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      const Gap(15),
      GradientButton(colors: [
        Color(builder.colorPicker.colors.cyanDark),
        Color(builder.colorPicker.colors.cyan)
      ], onPressed: () => builder.handleSubmit(), text: "Sign In")
    ],
  );
}
