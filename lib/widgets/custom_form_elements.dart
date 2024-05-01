import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../gen/assets.gen.dart';
import '../theme/color_resources.dart';
import '../theme/dimensions.dart';
import '../theme/t_style.dart';
import 'alert_box_widgets.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

class DecimalInput extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r"^\d*\.?\d*");
    String newString = regEx.stringMatch(newValue.text) ?? "";
    return newString == newValue.text ? newValue : oldValue;
  }
}

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.controller,
    this.prefixWidget,
    this.labelText,
    this.hintText,
    this.suffixWidget,
    this.readOnlyField,
    this.onTap,
    this.keyboardType,
    this.isEnabled = true,
    this.obscure = false,
    this.labelColor,
    this.fillColor,
    this.enableBorder = true,
    this.textAlign = TextAlign.start,
    this.height = 54,
    this.contentPadding,
    this.maxLines = 1,
    this.minLines = 1,
    this.labelStyle,
    this.validator,
    this.textInputAction,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.focusNode,
    this.hintStyle,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.style,
    this.prefixStyle,
    this.prefixText,
    this.initialValue,
    this.maxLength,
    this.showCounter = false,
  });

  final TextEditingController? controller;
  final Widget? prefixWidget;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? suffixWidget;
  final bool? readOnlyField;
  final Function? onTap;
  final bool isEnabled;
  final bool obscure;
  final TextAlign textAlign;
  final Color? labelColor;
  final Color? fillColor;
  final bool enableBorder;
  final double height;
  final EdgeInsets? contentPadding;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final Widget? prefix;
  final Widget? suffix;
  final void Function(String text)? onChanged;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final TextStyle? style;
  final TextStyle? prefixStyle;
  final String? prefixText;
  final String? initialValue;
  final bool showCounter;

  //  crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       if (labelText?.isNotEmpty ?? false) ...[
  //         Text(
  //           labelText!,
  //           style: labelStyle ?? body1Medium.black,
  //         ),
  //         gap
  // ],

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: minLines! > 1 ? null : 56,
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        initialValue: initialValue,
        maxLength: maxLength ??
            ((keyboardType == TextInputType.name ||
                    keyboardType == TextInputType.emailAddress)
                ? 30
                : keyboardType == TextInputType.phone
                    ? 10
                    : null),
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          maxLength,
        }) {
          if (!isFocused || !showCounter) {
            return null;
          }

          return Text(
            '$currentLength/$maxLength',
            style: headlineLarge.black,
          );
        },
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        maxLines: maxLines,
        minLines: minLines,
        obscureText: obscure,
        enabled: isEnabled,
        onTap: () => onTap == null ? null : onTap!(),
        readOnly: readOnlyField ?? false,
        controller: controller,
        validator: validator,
        textAlign: textAlign,
        keyboardType: keyboardType ?? TextInputType.name,
        style: style ?? labelLarge.copyWith(color: ColorResources.darkBG),
        cursorColor: ColorResources.black,
        textInputAction: textInputAction,
        inputFormatters: [
          if (keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.digitsOnly,
          if (keyboardType == TextInputType.name)
            FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z,.\-]+$'))
        ],
        decoration: defaultInputDecoration.copyWith(
          floatingLabelAlignment: FloatingLabelAlignment.start,
          alignLabelWithHint: false,
          labelStyle:
              labelStyle ?? labelLarge.copyWith(color: ColorResources.darkBG),
          filled: fillColor == null ? false : true,
          fillColor: fillColor,
          prefix: prefix,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          hintStyle: hintStyle ??
              labelLarge.copyWith(color: ColorResources.PLACEHOLDER),
          prefixIcon: prefixWidget,
          suffixIcon: suffixWidget,
          errorStyle: labelLarge.copyWith(color: ColorResources.RED),
          suffix: suffix,
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          contentPadding: const EdgeInsets.all(20.0),
          labelText: labelText,
        ),
      ),
    );
  }
}

class CustomSearchTextFiled extends StatefulWidget {
  const CustomSearchTextFiled(
      {super.key,
      this.filterButton,
      required this.hintText,
      required this.searchController,
      required this.searchOnTap,
      this.onChanged,
      this.searchFocus});
  final VoidCallback? filterButton;
  final String hintText;
  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final void Function(bool)? searchFocus;
  final VoidCallback searchOnTap;

  @override
  State<CustomSearchTextFiled> createState() => _CustomSearchTextFiledState();
}

Padding customDivider() {
  return const Padding(
    padding: EdgeInsets.only(top: 8, bottom: 8),
    child: Divider(
      thickness: 1,
      color: ColorResources.GREY4,
    ),
  );
}

class _CustomSearchTextFiledState extends State<CustomSearchTextFiled> {
  // DebouncerFunc debouncer =
  //     DebouncerFunc(delay: const Duration(milliseconds: 500));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Focus(
        onFocusChange: widget.searchFocus,
        child: TextField(
          onTap: () {},
          cursorColor: ColorResources.GREY1,
          cursorHeight: 18,
          controller: widget.searchController,
          onChanged: widget.onChanged,
          // (value) {
          //   debouncer.run(
          //     () {

          //     },
          //   );
          // },

          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20), //
              // focusedBorder: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(69)),
                borderSide: BorderSide(width: 1, color: Colors.transparent),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(69)),
                borderSide: BorderSide(width: 1, color: Colors.transparent),
              ),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(69.0),
              // ),
              filled: true,
              // suffixIcon: widget.,
              fillColor: ColorResources.GREY5,
              hintStyle: titleLarge.grey1,
              hintText: widget.hintText),
        ),
      ),
    );
  }
}

typedef OptionBuilder<T> = Widget Function(Iterable<T> options, int index);

class CustomAutocomplete<T extends Object> extends StatelessWidget {
  const CustomAutocomplete({
    super.key,
    required this.optionsBuilder,
    required this.optionBuilder,
    this.onSelected,
    this.hintText,
    // this.formKey,
    this.validator,
    this.suffixWidget,
    this.label,
  });
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final OptionBuilder<T> optionBuilder;
  final ValueChanged<T>? onSelected;
  final String? hintText;
  // final GlobalKey<FormState>? formKey;
  final FormFieldValidator<String>? validator;
  final String? label;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      optionsBuilder: optionsBuilder,
      onSelected: onSelected,
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200,
              maxWidth: MediaQuery.of(context).size.width - 32,
              minWidth: MediaQuery.of(context).size.width - 32,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => onSelected(
                  options.elementAt(index),
                ),
                child: optionBuilder(options, index),
              ),
            ),
          ),
        ),
      ),
      fieldViewBuilder: (
        context,
        textEditingController,
        focusNode,
        onFieldSubmitted,
      ) =>
          TextFieldCustom(
              controller: textEditingController,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              hintText: hintText,
              validator: validator,
              labelText: label,
              suffixWidget: suffixWidget),
    );
  }
}

class CustomCupertinoButton extends StatelessWidget {
  const CustomCupertinoButton(
      {super.key,
      required this.title,
      required this.textStyle,
      required this.backgroundColor,
      required this.borderColor,
      required this.onTap,
      required this.width});
  final String title;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor, // Border color
          width: width, // Border width
        ),
        borderRadius: BorderRadius.circular(16.0), // Border radius
      ),
      child: CupertinoButton(

          // color: CupertinoColors.white,
          onPressed: onTap,
          borderRadius: BorderRadius.circular(16),

          // color: CupertinoColors.white,
          child: Text(title, style: textStyle)),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    required this.buttonclick,
    required this.textStyle,
  });

  final String title;
  final VoidCallback buttonclick;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        // color: Colors.green,
        padding: EdgeInsets.zero,
        onPressed: buttonclick,
        child: Text(
          title,
          style: textStyle,
        ));
  }
}

void printFunction(int lineNumber, String textdata) {
  print('{line number = $lineNumber and data = $textdata}');
}

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  const CustomDropdownButtonFormField(
      {super.key,
      this.labelText,
      this.hintText,
      required this.items,
      required this.onChanged,
      this.value,
      this.validator,
      this.contentPadding,
      this.dismissBorder = false,
      this.prefixText});

  final String? labelText;
  final String? hintText;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final EdgeInsets? contentPadding;
  final FormFieldValidator? validator;
  final bool dismissBorder;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      icon: Assets.svgs.dropdown.svg(),
      isDense: false,
      itemHeight: 57,
      alignment: dismissBorder ? Alignment.centerRight : Alignment.centerLeft,
      items: items
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: Builder(builder: (context) {
                  String text = e.toString();
                  if (e is MapEntry<String, int>) {
                    text = e.key;
                  }
                  return Text(
                    text,
                    style: labelLarge.darkBG,
                  );
                }),
              ))
          .toList(),
      value: value,
      onChanged: onChanged,
      validator: validator,
      iconEnabledColor: ColorResources.primary,
      iconDisabledColor: ColorResources.grey,
      decoration: defaultInputDecoration.copyWith(
        prefixText: prefixText,
        focusedBorder: dismissBorder ? InputBorder.none : null,
        enabledBorder: dismissBorder ? InputBorder.none : null,
        hintText: hintText,
        hintStyle: labelLarge.darkBG,
        labelStyle: labelLarge.darkBG,
        labelText: labelText,
        // suffixIcon: Assets.svgs.dropdown.svg(),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 0,
            ),
      ),
    );
  }
}

InputDecoration get defaultInputDecoration => InputDecoration(
      errorStyle: labelLarge.copyWith(color: ColorResources.RED),
      hintStyle: labelLarge.copyWith(color: ColorResources.darkBG),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(width: 1, color: ColorResources.RED)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              width: 1, color: ColorResources.textFiledBorder)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              width: 1, color: ColorResources.textFiledBorder)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
              width: 1, color: ColorResources.textFiledBorder)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 1,
            color: ColorResources.textFiledBorder,
          )),
    );

class SubmitButton extends StatefulWidget {
  const SubmitButton(
    this.title, {
    super.key,
    this.onTap,
    this.padding = 14,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.overlayColor = Colors.white,
    this.textStyle,
    this.borderColor,
    this.radius,
    this.suffix,
    this.hasGradient = true,
    this.height,
    this.width,
  });

  const SubmitButton.primary(
    this.title, {
    super.key,
    this.onTap,
    this.padding = 14,
    this.backgroundColor = ColorResources.primary,
    this.textColor = Colors.white,
    this.overlayColor = Colors.white,
    this.textStyle,
    this.borderColor,
    this.radius,
    this.suffix,
    this.hasGradient = true,
    this.height,
    this.width,
  });

  const SubmitButton.delete({
    this.title = 'Delete Post',
    super.key,
    this.onTap,
    this.padding = 14,
    this.backgroundColor = ColorResources.grey,
    this.overlayColor = ColorResources.RED,
    this.textStyle,
    this.textColor = ColorResources.RED,
    this.borderColor,
    this.radius,
    this.suffix,
    this.hasGradient = true,
    this.height,
    this.width,
  });

  final LoadingChanged<void Function({bool? isLoading})>? onTap;
  final String title;
  final double padding;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? radius;
  final Widget? suffix;
  final Color? backgroundColor;
  final Color overlayColor;
  final TextStyle? textStyle;
  final bool? hasGradient;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton>
    with TickerProviderStateMixin {
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap == null
          ? null
          : () => widget.onTap!(({bool? isLoading}) {
                setState(() {
                  showLoader = isLoading ?? !showLoader;
                });
              }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        height: widget.height ?? 55,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? ColorResources.primary,
            borderRadius: BorderRadius.circular(100),
            gradient: widget.hasGradient == true
                ? const LinearGradient(
                    colors: [
                      ColorResources.gradientButtonStart,
                      ColorResources.gradientButtonEnd
                    ],
                  )
                : null,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 12,
                  color: ColorResources.dropshadowGreen,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.normal)
            ]),
        child: showLoader
            ? SpinKitCircle(
                color: Colors.white,
                size: 25.0 - widget.padding / 2.5,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.suffix != null) ...[widget.suffix!, gap],
                  Expanded(
                    child: Text(
                      widget.title,
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: (widget.textStyle ?? button).copyWith(
                        color: widget.textColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

typedef LoadingChanged<T> = void Function(T loader);

class CustomOutlineButton extends StatefulWidget {
  const CustomOutlineButton(
    this.title, {
    super.key,
    required this.onTap,
    this.padding = 14,
    this.textColor = ColorResources.secondary,
    this.borderColor,
    this.radius,
    this.textStyle,
    this.bgColor = ColorResources.WHITE,
    this.width,
    this.height,
  });

  final LoadingChanged<VoidCallback>? onTap;
  final String title;
  final double padding;
  final Color textColor;
  final Color? bgColor;
  final Color? borderColor;
  final BorderRadius? radius;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton>
    with TickerProviderStateMixin {
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap == null
          ? null
          : () => widget.onTap!(() {
                FocusScope.of(context).unfocus();
                setState(() {
                  showLoader = !showLoader;
                });
              }),
      child: Container(
        height: widget.height ?? 55,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                width: 1,
                color: widget.borderColor ?? ColorResources.secondary)),
        child: showLoader
            ? const SpinKitCircle(
                color: Colors.white,
                size: 25.0,
              )
            : Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: (widget.textStyle ?? button).copyWith(
                    color: widget.textColor,
                  ),
                ),
              ),
      ),
    );
  }
}

class PaddedColumn extends StatelessWidget {
  const PaddedColumn({
    super.key,
    required this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.children = const [],
  });

  final EdgeInsets padding;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}

class DatePickerController {
  late VoidCallback openDatePicker;
}

class TimePickerTextField extends StatefulWidget {
  const TimePickerTextField({
    super.key,
    required this.onChanged,
    required this.value,
    this.controller,
    this.helpText,
    required this.label,
    required this.validator,
  });

  final ValueChanged<TimeOfDay?> onChanged;
  final TimeOfDay? value;
  final DatePickerController? controller;
  final String? helpText;
  final String label;
  final FormFieldValidator<String?>? validator;

  @override
  State<TimePickerTextField> createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
  final _dateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.openDatePicker = openTimePicker;
    }

    if (widget.value != null) {
      setTextController(widget.value!);
    }
  }

  void openTimePicker() async {
    final newValue = await showTimePicker(
      context: context,
      initialTime: widget.value ?? TimeOfDay.now(),
      helpText: widget.helpText,
      builder: (context, child) {
        return Theme(
          data: ColorResources.datePickerTheme,
          child: child!,
        );
      },
    );

    if (newValue != null) {
      setTextController(newValue);
      widget.onChanged(newValue);
    } else {
      _dateTextController.text = '';
    }
    setState(() {});
  }

  void setTextController(TimeOfDay dateTime) {
    _dateTextController.text = dateTime.format12H;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: openTimePicker,
      child: TextFieldCustom(
        validator: widget.validator,
        labelText: widget.label,
        hintText: widget.helpText,
        controller: _dateTextController,
        suffixWidget: const Padding(
          padding: EdgeInsets.only(left: 16, right: 12),
          //    child: Assets.icon.clock.svg(),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 0,
        ),
        isEnabled: false,
      ),
    );
  }
}

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({super.key, required this.text, this.trailing, this.onTap});
  final String text;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: ColorResources.BORDER_SHADE,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: bodySmall.black,
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField(
      {super.key,
      required this.onChanged,
      required this.value,
      this.controller,
      this.hintText,
      this.pickFromFuture = true,
      this.validator,
      this.labelText,
      this.suffixIcon,
      this.dismissSuffixIcon = false,
      this.textAlign = TextAlign.start,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.isEnabled = true});

  final ValueChanged<DateTime?> onChanged;
  final DateTime? value;
  final DatePickerController? controller;
  final DateTime? initialDate;
  final bool pickFromFuture;
  final FormFieldValidator<String?>? validator;
  final String? labelText;
  final String? hintText;
  final SvgPicture? suffixIcon;
  final TextAlign textAlign;
  final bool dismissSuffixIcon;
  final DateTime? firstDate, lastDate;
  final bool? isEnabled;
  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  final _dateTextController = TextEditingController();

  bool get pickFromFuture => widget.pickFromFuture;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.openDatePicker = openDatePicker;
    }

    if (widget.value != null) {
      setTextController(widget.value!);
    }
  }

  void openDatePicker() async {
    print('init Date: ${widget.value}');
    final DateTime? newValue = await AlertBoxWidgets.openDatePicker(
        context,
        widget.value ?? widget.initialDate ?? DateTime.now(),
        pickFromFuture,
        widget.hintText ?? "",
        firstDate: widget.firstDate,
        lastDate: widget.lastDate);
    if (newValue != null) {
      setTextController(newValue);
      widget.onChanged(newValue);
    } else {
      _dateTextController.text = '';
    }
    setState(() {});
  }

  void setTextController(DateTime dateTime) {
    _dateTextController.text = DateFormat("dd-MM-yyyy").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.isEnabled! ? openDatePicker : null,
      child: TextFieldCustom(
        textAlign: widget.textAlign,
        hintText: widget.hintText,
        controller: _dateTextController,
        labelText: widget.labelText,
        validator: widget.validator,
        suffixWidget: widget.dismissSuffixIcon
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: widget.suffixIcon ?? Assets.svgs.calendar.svg(),
              ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 0,
        ),
        isEnabled: false,
      ),
    );
  }
}

class DateRangePickerTextField extends StatefulWidget {
  const DateRangePickerTextField({
    super.key,
    required this.onChanged,
    required this.value,
    this.controller,
    this.hintText,
    this.pickFromFuture = true,
    this.validator,
    this.labelText,
    this.suffixIcon,
    this.dismissSuffixIcon = false,
    this.textAlign = TextAlign.start,
    this.initialDate,
  });

  final ValueChanged<DateTimeRange?> onChanged;
  final DateTimeRange? value;
  final DatePickerController? controller;
  final DateTime? initialDate;
  final bool pickFromFuture;
  final FormFieldValidator<String?>? validator;
  final String? labelText;
  final String? hintText;
  final SvgPicture? suffixIcon;
  final TextAlign textAlign;
  final bool dismissSuffixIcon;
  @override
  State<DateRangePickerTextField> createState() =>
      _DateRangePickerTextFieldState();
}

class _DateRangePickerTextFieldState extends State<DateRangePickerTextField> {
  final _dateTextController = TextEditingController();

  bool get pickFromFuture => widget.pickFromFuture;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.openDatePicker = openDatePicker;
    }

    if (widget.value != null) {
      setTextController(widget.value!);
    }
  }

  void openDatePicker() async {
    final DateTimeRange? newValue = await AlertBoxWidgets.openDateRangePicker(
      context,
      widget.value?.start ?? widget.initialDate ?? DateTime.now(),
      pickFromFuture,
      widget.hintText ?? "",
    );
    if (newValue != null) {
      setTextController(newValue);
      widget.onChanged(newValue);
    } else {
      _dateTextController.text = '';
    }
    setState(() {});
  }

  void setTextController(DateTimeRange dateTime) {
    _dateTextController.text = dateTime.start == dateTime.end
        ? DateFormat("dd-MM-yyyy").format(dateTime.start)
        : '${DateFormat("dd-MM-yyyy").format(dateTime.start)} to ${DateFormat("dd-MM-yyyy").format(dateTime.end)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: openDatePicker,
      child: TextFieldCustom(
        textAlign: widget.textAlign,
        hintText: widget.hintText,
        controller: _dateTextController,
        labelText: widget.labelText,
        validator: widget.validator,
        suffixWidget: widget.dismissSuffixIcon
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: widget.suffixIcon ?? Assets.svgs.calendar.svg(),
              ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 0,
        ),
        isEnabled: false,
      ),
    );
  }
}

Widget stoppedAnimationProgress({color}) => CircularProgressIndicator(
      strokeWidth: 2.5,
      valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
    );
