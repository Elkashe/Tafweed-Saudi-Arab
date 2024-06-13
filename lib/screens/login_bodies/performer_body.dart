// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tafweed/constants.dart';
// import 'package:tafweed/cubits/login/login_cubit.dart';
// import 'package:tafweed/packages/country_code/country_code.dart';
// import 'package:tafweed/widgets/custom_button.dart';
// import 'package:tafweed/widgets/custom_texfield.dart';
// import 'package:tafweed/widgets/loading.dart';

// class PerformerBody extends StatelessWidget {
//   const PerformerBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var loginCubit = BlocProvider.of<LoginCubit>(context);
//     return Column(
//       children: [
//         const Text(
//           "تسجيل دخول كمؤدي العمرة",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             //color: mainColor,
//             //fontSize: 18,
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Form(
//           key: loginCubit.perfomerFormKey,
//           child: Column(
//             children: [
//               CustomTextFormField(
//                 prefix: const CountryCode(),
//                 text: "هاتف المحمول",
//                 keyboardType: TextInputType.phone,
//                 onSaved: (value) {
//                   loginCubit.phone = value.toString();
//                 },
//                 onValidate: (value) {
//                   if (value!.isEmpty) {
//                     return "ادخل رقم الهاتف";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextFormField(
//                 prefix: Icon(
//                   Icons.lock,
//                   color: Colors.grey[600],
//                 ),
//                 text: "كلمة المرور",
//                 obscureText: true,
//                 onSaved: (value) {
//                   loginCubit.password = value.toString();
//                 },
//                 onValidate: (value) {
//                   if (value!.isEmpty) {
//                     return "أدخل كلمة المرور";
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           ),
//         ),
//         //SizedBox(height: 10,),
//         const SizedBox(
//           height: 20,
//         ),
//         BlocBuilder<LoginCubit, LoginState>(
//           builder: (context, state) {
//             if(state is PerformerLoadingState){
//               return const Center(
//                 child: Loading(),
//               );
//             }
//             else{
//               return CustomButton(
//                 text: 'تسجيل الدخول',
//                 onPressed: () {
//                   loginCubit.onPerformerLogin(context);
//                 },
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }