class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.readOnly = false,
      this.decoration = const InputDecoration(),
      this.keyboardType,
      this.inputFormatters,
      this.enabled,
      this.textCapitalization = TextCapitalization.none,
      this.validator,
      this.textInputAction,
      this.onTap,
      this.maxLength,
      this.errorText,
      this.onChanged});

  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final GestureTapCallback? onTap;
  final int? maxLength;
  final String? errorText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      style: GeolahFonts.base.w500.s14.primaryColorViolet,
      cursorColor: GeolahColors.primaryColorViolet.withOpacity(0.0),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      validator: validator,
      textInputAction: textInputAction,
      maxLength: maxLength,
      decoration: decoration.copyWith(
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorText: errorText,
        isDense: false,
        hintText: hintText,
        enabled: enabled,
        hintStyle: GeolahFonts.primryColorBlueWithOpacity5050014,
        contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
        errorStyle: GeolahFonts.base.s10.w500.secondaryRed,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.secondaryGreen,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.secondaryGreen,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.primaryColorViolet.withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.redColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.primaryColorViolet.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldPayment extends StatelessWidget {
  const CustomTextFieldPayment({
    super.key,
    this.hintText,
    this.controller,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.inputFormatters,
    this.enabled,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.textInputAction,
    this.onTap,
    this.maxLength,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.maxLines,
    this.minLines,
  });

  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final GestureTapCallback? onTap;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      style: GeolahFonts.base.w500.s14.primaryColorViolet,
      cursorColor: GeolahColors.primaryColorViolet.withOpacity(0.0),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      validator: validator,
      textInputAction: textInputAction,
      maxLength: maxLength,
      obscureText: obscureText,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      decoration: decoration.copyWith(
        counterText: '',
        suffixIcon: suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: false,
        hintText: hintText,
        enabled: enabled,
        hintStyle: GeolahFonts.primryColorBlueWithOpacity5050014,
        contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
        errorStyle: GeolahFonts.base.s10.w500.secondaryRed,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.secondaryGreen,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.secondaryGreen,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.primaryColorViolet.withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.redColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: GeolahColors.primaryColorViolet.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
