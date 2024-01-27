import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/form/form_auth.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/password_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input_auth.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/modules/login/controllers/login_controller.dart';

Widget formLogin(
    {required GlobalKey<FormState> formKey,
    required String title,
    required LoginController builder}) {
  return FormAuth(
    formKey: formKey,
    children: [
      const Heading(
          heading: "h1", size: 26, text: "Sign In", textAlign: TextAlign.start),
      const Gap(15),
      TextInputAuth(
        focusNode: builder.usernameNode,
        controller: builder.usernameController,
        label: "Username",
        prefixIcon: Icons.person,
        onTap: () => builder.hideLogoOnFocus(),
        onEditingComplete: () => builder.hideLogoOnFocus(),
        onTapOutside: (pointer) => builder.showLogoOnUnfocus(),
        onSubmit: (value) => builder.nextNode(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your username";
          }
          return null;
        },
      ),
      const Gap(15),
      TextInputPassword(
        focusNode: builder.passwordNode,
        controller: builder.passwordController,
        isObscure: builder.isObscure.value,
        label: "Password",
        prefixIcon: Icons.password,
        onTap: () => builder.hideLogoOnFocus(),
        onEditingComplete: () => builder.showLogoOnUnfocus(),
        onTapOutside: (pointer) => builder.showLogoOnUnfocus(),
        toggleObscure: () => builder.toggleObscure(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password";
          }
          return null;
        },
      ),
      const Gap(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Paragraph(text: "Don't have an operator account?"),
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
      GradientButton(
          colors: [builder.colorPicker.cyanDark, builder.colorPicker.cyan],
          onPressed: () => builder.handleSubmit(formKey),
          text: "Sign In")
    ],
  );
}
