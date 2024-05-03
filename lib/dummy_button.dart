




class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.background = const Color(0xFF021640),
    this.foreground = const Color(0xFFFFFFFF),
  });

  const CustomTextButton.light({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.background = const Color(0xFFDEEAED),
    this.foreground = const Color(0xFF021640),
  });

  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox.square(
        dimension: 44.0,
        child: Center(
          child: CircularProgressIndicator(
            color: GeolahColors.primaryColorViolet,
          ),
        ),
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foreground.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            // return const Color(0xFFEBEBE7);
            return background.withOpacity(0.25);
          }
          return background;
        }),
      ),
      child: Text(
        text.toUpperCase(),
        style: GeolahFonts.whiteColor70012.copyWith(
          letterSpacing: 1.5,
          color: foreground,
        ),
      ),
    );
  }
}

class CustomTextButtonWithICon extends StatelessWidget {
  const CustomTextButtonWithICon({
    super.key,
    required this.text,
    required this.iconString,
    this.onPressed,
    this.loading = false,
    this.background = const Color(0xFF021640),
    this.foreground = const Color(0xFFFFFFFF),
  });

  const CustomTextButtonWithICon.light({
    super.key,
    required this.text,
    required this.iconString,
    this.onPressed,
    this.loading = false,
    this.background = const Color(0xFFDEEAED),
    this.foreground = const Color(0xFF021640),
  });

  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final Color background;
  final Color foreground;
  final String iconString;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox.square(
        dimension: 44.0,
        child: Center(
          child: CircularProgressIndicator(
            color: GeolahColors.primaryColorViolet,
          ),
        ),
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foreground.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            // return const Color(0xFFEBEBE7);
            return background.withOpacity(0.25);
          }
          return background;
        }),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconString),
          const Gap(16),
          Text(
            text.toUpperCase(),
            style: GeolahFonts.whiteColor70012.copyWith(
              letterSpacing: 1.5,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
