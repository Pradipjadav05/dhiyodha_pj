import 'package:country_code_picker/country_code_picker.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/code_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onTap;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization capitalization;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool divider;
  final bool showTitle;
  final bool isAmount;
  final bool isNumber;
  final bool isPhone;
  final bool isIconDivider;
  final bool isOTP;
  final String? countryDialCode;
  final Color? bgColor;
  final Color? hintColor;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Function(CountryCode countryCode)? onCountryChanged;

  const CommonTextFormField({
    Key? key,
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength = 1000,
    this.onSubmit,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.divider = false,
    this.showTitle = false,
    this.isAmount = false,
    this.isNumber = false,
    this.isPhone = false,
    this.isIconDivider = false,
    this.isOTP = false,
    this.countryDialCode,
    this.bgColor = lavenderMist,
    this.hintColor = bluishPurple,
    this.padding,
    this.textStyle,
    this.onCountryChanged,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CommonTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? Text(widget.hintText,
                style: fontRegular.copyWith(fontSize: fontSize10))
            : const SizedBox(),
        SizedBox(height: widget.showTitle ? paddingSize5 : 0),
        TextFormField(
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: widget.textStyle ?? fontRegular.copyWith(fontSize: fontSize16),
          textInputAction: widget.inputAction,
          textAlign: widget.isOTP ? TextAlign.center : TextAlign.start,
          keyboardType:
              widget.isAmount ? TextInputType.number : widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          autofillHints: widget.inputType == TextInputType.name
              ? [AutofillHints.name]
              : widget.inputType == TextInputType.emailAddress
                  ? [AutofillHints.email]
                  : widget.inputType == TextInputType.phone
                      ? [AutofillHints.telephoneNumber]
                      : widget.inputType == TextInputType.streetAddress
                          ? [AutofillHints.fullStreetAddress]
                          : widget.inputType == TextInputType.url
                              ? [AutofillHints.url]
                              : widget.inputType ==
                                      TextInputType.visiblePassword
                                  ? [AutofillHints.password]
                                  : null,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                ]
              : widget.isAmount
                  ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))]
                  : widget.isNumber
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                      : null,
          decoration: InputDecoration(
            isCollapsed: false,
            icon: null,
            counterText: "",
            contentPadding: widget.padding ?? EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius10),
              borderSide: BorderSide(
                  style: BorderStyle.solid, width: 0.3, color: lavenderMist),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius10),
              borderSide: BorderSide(
                  style: BorderStyle.solid, width: 0.3, color: lavenderMist),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius5),
              borderSide: BorderSide(
                  style: BorderStyle.solid, width: 0.5, color: midnightBlue),
            ),
            border: InputBorder.none,
            isDense: false,
            hintText: widget.hintText,
            fillColor: widget.bgColor ?? Theme.of(context).cardColor,
            hintStyle: widget.textStyle ??
                fontRegular.copyWith(
                    fontSize: fontSize14,
                    color: widget.hintColor ?? Theme.of(context).hintColor),
            filled: true,
            prefixIcon: widget.isPhone
                ? SizedBox(
                    width: 95,
                    child: Row(children: [
                      Container(
                          width: 85,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius5),
                              bottomLeft: Radius.circular(radius5),
                            ),
                          ),
                          margin: const EdgeInsets.only(right: 0),
                          padding: const EdgeInsets.only(left: 5),
                          child: Center(
                            child: CodePickerWidget(
                              flagWidth: 25,
                              padding: EdgeInsets.zero,
                              onChanged: widget.onCountryChanged,
                              initialSelection: widget.countryDialCode,
                              favorite: [widget.countryDialCode!],
                              textStyle: fontRegular.copyWith(
                                fontSize: fontSize12,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                            ),
                          )),
                      Container(
                        height: 20,
                        width: 2,
                        color: Theme.of(context).disabledColor,
                      )
                    ]),
                  )
                : widget.prefixIcon != null
                    ? widget.isIconDivider
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingSize10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 10),
                                widget.prefixIcon!,
                                SizedBox(width: 20),
                                Container(
                                    height: 30, width: 2, color: periwinkle)
                              ],
                            ))
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingSize5),
                            child: widget.prefixIcon)
                    : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle,
                  )
                : widget.suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingSize14),
                        child: SizedBox(
                            height: iconSize18,
                            width: iconSize18,
                            child: widget.suffixIcon),
                      )
                    : null,
          ),
          onFieldSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit!(text)
                  : null,
          onChanged: widget.onChanged as void Function(String)?,
          onTap: widget.onTap as void Function()?,
        ),
        widget.divider
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingSize5),
                child: Divider())
            : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
