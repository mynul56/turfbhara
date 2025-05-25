import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/validators.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final bool showCounter;
  final bool dense;
  final TextFieldType type;
  final bool showPasswordToggle;
  final String? passwordToggleTooltip;
  final bool autoValidate;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;

  const CustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.showCounter = false,
    this.dense = false,
    this.type = TextFieldType.text,
    this.showPasswordToggle = true,
    this.passwordToggleTooltip,
    this.autoValidate = false,
    this.autovalidateMode,
    this.autofillHints,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  late TextEditingController _controller;
  String? _errorText;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _errorText = widget.errorText;
    _hasError = widget.errorText != null;

    // Add listener for auto validation
    if (widget.autoValidate || widget.autovalidateMode != null) {
      _controller.addListener(_validateInput);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _validateInput() {
    if (widget.validator != null) {
      final error = widget.validator!(_controller.text);
      if (mounted) {
        setState(() {
          _errorText = error;
          _hasError = error != null;
        });
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: widget.labelStyle ??
                Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                      color: _hasError
                          ? (widget.errorBorderColor ?? AppColors.error)
                          : (isDark
                              ? AppColors.darkOnSurface
                              : AppColors.lightOnSurface),
                    ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: _getKeyboardType(),
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          inputFormatters: _getInputFormatters(),
          validator: widget.validator,
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (widget.autoValidate || widget.autovalidateMode != null) {
              _validateInput();
            }
          },
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          autovalidateMode: widget.autovalidateMode ??
              (widget.autoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled),
          autofillHints: widget.autofillHints,
          style: widget.textStyle ??
              Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
          decoration: _buildInputDecoration(context, isDark),
        ),
        if (widget.helperText != null && !_hasError) ...[
          const SizedBox(height: 4),
          Text(
            widget.helperText!,
            style: widget.helperStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: isDark
                          ? AppColors.darkOnSurface
                          : AppColors.lightOnSurface,
                    ),
          ),
        ],
        if (_hasError && _errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            _errorText!,
            style: widget.errorStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: widget.errorBorderColor ?? AppColors.error,
                    ),
          ),
        ],
      ],
    );
  }

  TextInputType? _getKeyboardType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    }

    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.decimal:
        return const TextInputType.numberWithOptions(decimal: true);
      case TextFieldType.multiline:
        return TextInputType.multiline;
      case TextFieldType.url:
        return TextInputType.url;
      case TextFieldType.name:
        return TextInputType.name;
      case TextFieldType.address:
        return TextInputType.streetAddress;
      case TextFieldType.text:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.inputFormatters != null) {
      return widget.inputFormatters;
    }

    switch (widget.type) {
      case TextFieldType.phone:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ];
      case TextFieldType.number:
        return [
          FilteringTextInputFormatter.digitsOnly,
        ];
      case TextFieldType.decimal:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ];
      case TextFieldType.name:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
        ];
      default:
        return null;
    }
  }

  InputDecoration _buildInputDecoration(BuildContext context, bool isDark) {
    final borderRadius = BorderRadius.circular(widget.borderRadius ?? 8);

    return InputDecoration(
      hintText: widget.hint,
      hintStyle: widget.hintStyle ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color:
                    isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
              ),
      prefixIcon: widget.prefixIcon,
      suffixIcon: _buildSuffixIcon(),
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      filled: true,
      fillColor: widget.fillColor ??
          (isDark ? AppColors.darkSurface : AppColors.lightSurface),
      contentPadding: widget.contentPadding ??
          (widget.dense
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: widget.borderColor ??
              (isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: widget.borderColor ??
              (isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: widget.focusedBorderColor ?? AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: widget.errorBorderColor ?? AppColors.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: widget.errorBorderColor ?? AppColors.error,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: (widget.borderColor ??
                  (isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface))
              .withOpacity(0.5),
        ),
      ),
      counterText: widget.showCounter ? null : '',
      errorText: null, // We handle error text manually
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if ((widget.type == TextFieldType.password || widget.obscureText) &&
        widget.showPasswordToggle) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkOnSurface
              : AppColors.lightOnSurface,
        ),
        onPressed: _togglePasswordVisibility,
        tooltip: widget.passwordToggleTooltip ??
            (_obscureText ? 'Show password' : 'Hide password'),
      );
    }

    return null;
  }
}

// Factory methods for common text field types
class CustomTextFieldFactory {
  static Widget email({
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool autoValidate = false,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      hint: hint ?? 'Enter your email',
      helperText: helperText,
      controller: controller,
      type: TextFieldType.email,
      validator: validator ?? Validators.email,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autoValidate: autoValidate,
      enabled: enabled,
      prefixIcon: prefixIcon ?? const Icon(Icons.email_outlined),
      suffixIcon: suffixIcon,
      autofillHints: const [AutofillHints.email],
    );
  }

  static Widget password({
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool autoValidate = false,
    bool enabled = true,
    Widget? prefixIcon,
    bool showPasswordToggle = true,
  }) {
    return CustomTextField(
      label: label,
      hint: hint ?? 'Enter your password',
      helperText: helperText,
      controller: controller,
      type: TextFieldType.password,
      obscureText: true,
      validator: validator ?? Validators.password,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autoValidate: autoValidate,
      enabled: enabled,
      prefixIcon: prefixIcon ?? const Icon(Icons.lock_outlined),
      showPasswordToggle: showPasswordToggle,
      autofillHints: const [AutofillHints.password],
    );
  }

  static Widget phone({
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool autoValidate = false,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      hint: hint ?? 'Enter your phone number',
      helperText: helperText,
      controller: controller,
      type: TextFieldType.phone,
      validator: validator ?? Validators.phoneNumber,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autoValidate: autoValidate,
      enabled: enabled,
      prefixIcon: prefixIcon ?? const Icon(Icons.phone_outlined),
      suffixIcon: suffixIcon,
      autofillHints: const [AutofillHints.telephoneNumber],
    );
  }

  static Widget name({
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool autoValidate = false,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      hint: hint ?? 'Enter your name',
      helperText: helperText,
      controller: controller,
      type: TextFieldType.name,
      textCapitalization: TextCapitalization.words,
      validator: validator ?? Validators.name,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autoValidate: autoValidate,
      enabled: enabled,
      prefixIcon: prefixIcon ?? const Icon(Icons.person_outlined),
      suffixIcon: suffixIcon,
      autofillHints: const [AutofillHints.name],
    );
  }

  static Widget search({
    String? hint,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      hint: hint ?? 'Search...',
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: enabled,
      prefixIcon: prefixIcon ?? const Icon(Icons.search),
      suffixIcon: suffixIcon,
      borderRadius: 24,
    );
  }

  static Widget multiline({
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool autoValidate = false,
    bool enabled = true,
    int maxLines = 3,
    int? maxLength,
  }) {
    return CustomTextField(
      label: label,
      hint: hint,
      helperText: helperText,
      controller: controller,
      type: TextFieldType.multiline,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      autoValidate: autoValidate,
      enabled: enabled,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  static Widget number({
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool autoValidate = false,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      hint: hint,
      helperText: helperText,
      controller: controller,
      type: TextFieldType.number,
      validator: validator ?? Validators.numeric,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autoValidate: autoValidate,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  static Widget decimal({
    String? label,
    String? hint,
    String? helperText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool autoValidate = false,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return CustomTextField(
      label: label,
      hint: hint,
      helperText: helperText,
      controller: controller,
      type: TextFieldType.decimal,
      validator: validator ?? Validators.decimal,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autoValidate: autoValidate,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}

enum TextFieldType {
  text,
  email,
  password,
  phone,
  number,
  decimal,
  multiline,
  url,
  name,
  address,
}
