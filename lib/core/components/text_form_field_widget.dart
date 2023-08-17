// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../utils/app_colors.dart';
// import '../utils/assets.dart';
// import '../utils/responsive.dart';
//
// class TextFormFieldWidget extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String title;
//   final bool? enabled;
//   final bool? enableErrorWidget;
//   final Widget? errorWidget;
//   final String? Function(String?)? validator;
//   final Color? fillColor;
//   final Color? hintColor;
//   final Color? defaultBorderColor;
//   final Color? defaultTextColor;
//   final String? prefixImageSvg;
//   final TextInputType? keyboardType;
//   final bool isPassword;
//   final bool enableShadow;
//   final Widget? icon;
//   final Function(String?)? onChanged;
//   final Function(String?)? onSubmit;
//   final TextInputFormatter? textInputFormatter;
//
//   const TextFormFieldWidget({
//     Key? key,
//     required this.controller,
//     required this.hintText,
//     this.validator,
//     required this.title,
//     this.fillColor,
//     this.hintColor,
//     this.prefixImageSvg,
//     this.keyboardType,
//     this.isPassword = false,
//     this.enableShadow = true,
//     this.defaultBorderColor,
//     this.defaultTextColor,
//     this.onChanged,
//     this.onSubmit,
//     this.enabled = true,
//     this.textInputFormatter,
//     this.icon,
//     this.enableErrorWidget,
//     this.errorWidget,
//   }) : super(key: key);
//
//   @override
//   State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
// }
//
// class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
//   bool isObscure = true;
//
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           widget.title.toUpperCase(),
//           style: TextStyle(
//             fontFamily: 'SFProDisplay',
//             color: Colors.white,
//             fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w500,
//             fontSize: 17.sp,
//           ),
//         ),
//         SizedBox(height: 10.h),
//         Container(
//           constraints: BoxConstraints(
//             maxWidth: 335.w,
//           ),
//           // decoration:/**/
//           // BoxDecoration(border: Border.all(color: const Color(0xff545C9B))),
//           child: Center(
//             child: TextFormField(
//               autofocus: false,
//               focusNode: _focusNode,
//               cursorColor: const Color(0xff343B71),
//               enabled: widget.enabled,
//               onFieldSubmitted: (value) => widget.onSubmit?.call(value),
//               onChanged: (String? value) => widget.onChanged?.call(value),
//               validator: widget.validator,
//               controller: widget.controller,
//               keyboardType: widget.keyboardType,
//               obscureText: widget.isPassword && isObscure,
//               inputFormatters: widget.textInputFormatter != null
//                   ? [
//                       widget.textInputFormatter!,
//                     ]
//                   : null,
//               maxLines: 1,
//               minLines: 1,
//               style: TextStyle(
//                 color: AppColors.darkTextSecond,
//                 fontStyle: FontStyle.normal,
//                 fontFamily: "SFProDisplay",
//                 fontWeight: FontWeight.w500,
//                 fontSize: 17.sp,
//               ),
//               decoration: InputDecoration(
//                 errorStyle: TextStyle(height: 0.1, fontSize: 1),
//                 errorMaxLines: 1,
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//                 isCollapsed: false,
//                 fillColor: Colors.white,
//                 isDense: true,
//                 filled: true,
//                 suffixIcon: _passwordIcon(),
//                 hintText: widget.hintText,
//                 hintStyle: TextStyle(
//                   fontFamily: 'SFProDisplay',
//                   color: AppColors.darkTextSecond,
//                   fontStyle: FontStyle.normal,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 17.sp,
//                 ),
//                 prefixIcon: widget.icon ??
//                     (widget.prefixImageSvg != null
//                         ? SizedBox(
//                             width: 25.r,
//                             height: 25.r,
//                             child: Center(
//                               child: SvgPicture.asset(
//                                 widget.prefixImageSvg!,
//                                 color: const Color(0xffA7A7A7),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           )
//                         : null),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                   borderSide: widget.defaultBorderColor != null
//                       ? const BorderSide(
//                           color: Color(0xff545C9B),
//                           width: 2,
//                         )
//                       : BorderSide.none,
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                   borderSide: const BorderSide(
//                     color: AppColors.errorColor,
//                     width: 2,
//                   ),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                   borderSide: widget.defaultBorderColor != null
//                       ? const BorderSide(
//                           color: Colors.grey,
//                           width: 2,
//                         )
//                       : BorderSide.none,
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                   borderSide: const BorderSide(
//                     color: AppColors.errorColor,
//                     width: 2,
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                   borderSide: BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                   borderSide: const BorderSide(
//                     color: Color(0xff545C9B),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 10.h),
//         if (widget.enableErrorWidget != null &&
//             widget.enableErrorWidget == true)
//           widget.errorWidget ?? Container(),
//         if (widget.validator != null)
//           Text(
//             widget.validator?.call(widget.controller.text) ?? "",
//             style: TextStyle(
//               fontFamily: "SFProDiplay",
//               fontSize: 12.sp,
//               fontStyle: FontStyle.normal,
//               fontWeight: FontWeight.w300,
//               color: AppColors.errorColor,
//             ),
//           )
//       ],
//     );
//   }
//
//   Widget? _passwordIcon() {
//     if (widget.isPassword) {
//       return SizedBox(
//         height: 10.r,
//         width: 10.r,
//         child: Center(
//           child: GestureDetector(
//             onTap: () => setState(() => isObscure = !isObscure),
//             child: SvgPicture.asset(
//               isObscure ? Assets.tEyeIconClosedIcon : Assets.tEyeIcon,
//             ),
//           ),
//         ),
//       );
//       if (!isObscure) {
//         return SizedBox(
//           height: 10.r,
//           width: 10.r,
//           child: Center(
//             child: GestureDetector(
//               onTap: () => setState(() => isObscure = true),
//               child: SvgPicture.asset(
//                 Assets.tEyeIconClosedIcon,
//               ),
//             ),
//           ),
//         );
//       } else {
//         return GestureDetector(
//           onTap: () => setState(() => isObscure = false),
//           child: SvgPicture.asset(
//             Assets.tEyeIcon,
//             // color: Color(0xffA7A7A7),
//           ),
//         );
//       }
//     }
//     return null;
//   }
// }
