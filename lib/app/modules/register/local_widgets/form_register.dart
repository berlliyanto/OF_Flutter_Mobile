import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/button/gradient_button.dart';
import 'package:of_flutter_mobile/app/components/widgets/form/form_auth.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/password_input.dart';
import 'package:of_flutter_mobile/app/components/widgets/input/text_input_auth.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/modules/register/controllers/register_controller.dart';

Widget formRegister(
    {required GlobalKey<FormState> formKey,
    required String title,
    required RegisterController builder}) {
  return FormAuth(
    formKey: formKey,
    children: [
      Heading(heading: "h1", size: 26, text: title, textAlign: TextAlign.start),
      const Gap(15),
      TextInputAuth(
        keyboardType: TextInputType.text,
        focusNode: builder.nameNode,
        controller: builder.nameController,
        label: "Name",
        prefixIcon: Icons.abc,
        onTap: () => builder.hideLogoOnFocus(),
        onEditingComplete: () => builder.showLogoOnUnfocus(),
        onTapOutside: (pointer) => builder.showLogoOnUnfocus(),
        onSubmit: (value) => builder.nextNode("name"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your name";
          }
          return null;
        },
      ),
      const Gap(15),
      TextInputAuth(
        focusNode: builder.emailNode,
        controller: builder.emailController,
        keyboardType: TextInputType.emailAddress,
        label: "Email",
        prefixIcon: Icons.email,
        onTap: () => builder.hideLogoOnFocus(),
        onEditingComplete: () => builder.showLogoOnUnfocus(),
        onTapOutside: (pointer) => builder.showLogoOnUnfocus(),
        onSubmit: (value) => builder.nextNode("email"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your email";
          }
          return null;
        },
      ),
      const Gap(15),
      TextInputAuth(
        focusNode: builder.usernameNode,
        controller: builder.usernameController,
        label: "Username",
        prefixIcon: Icons.person,
        onTap: () => builder.hideLogoOnFocus(),
        onEditingComplete: () => builder.showLogoOnUnfocus(),
        onTapOutside: (pointer) => builder.showLogoOnUnfocus(),
        onSubmit: (value) => builder.nextNode("username"),
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
          const Paragraph(text: "Already have an operator account?"),
          const Gap(5),
          GestureDetector(
            onTap: () => Get.toNamed('/login'),
            child: const Paragraph(
              text: "Sign In",
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      const Gap(15),
      GradientButton(colors: [
        Color(builder.colorPicker.colors.cyanDark),
        Color(builder.colorPicker.colors.cyan)
      ], onPressed: () => builder.handleSubmit(formKey), text: title)
    ],
  );
}
