import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/device_utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final bool isFullWidth;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? tooltip;
  final bool enableHapticFeedback;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.textStyle,
    this.isFullWidth = false,
    this.leadingIcon,
    this.trailingIcon,
    this.tooltip,
    this.enableHapticFeedback = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine button properties based on type
    final buttonConfig = _getButtonConfig(context, isDark);

    // Determine size properties
    final sizeConfig = _getSizeConfig(context);

    // Build button content
    Widget buttonChild = _buildButtonContent(context);

    // Wrap with tooltip if provided
    if (tooltip != null) {
      buttonChild = Tooltip(
        message: tooltip!,
        child: buttonChild,
      );
    }

    // Handle full width
    if (isFullWidth) {
      buttonChild = SizedBox(
        width: double.infinity,
        child: buttonChild,
      );
    } else if (width != null) {
      buttonChild = SizedBox(
        width: width,
        child: buttonChild,
      );
    }

    return buttonChild;
  }

  ButtonConfig _getButtonConfig(BuildContext context, bool isDark) {
    switch (type) {
      case ButtonType.primary:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? AppColors.primary,
          textColor: textColor ?? Colors.white,
          borderColor: borderColor ?? AppColors.primary,
          elevation: 2,
        );

      case ButtonType.secondary:
        return ButtonConfig(
          backgroundColor: backgroundColor ??
              (isDark ? AppColors.darkSurface : AppColors.lightSurface),
          textColor: textColor ?? AppColors.primary,
          borderColor: borderColor ?? AppColors.primary,
          elevation: 1,
        );

      case ButtonType.outline:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? Colors.transparent,
          textColor: textColor ?? AppColors.primary,
          borderColor: borderColor ?? AppColors.primary,
          elevation: 0,
        );

      case ButtonType.text:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? Colors.transparent,
          textColor: textColor ?? AppColors.primary,
          borderColor: borderColor ?? Colors.transparent,
          elevation: 0,
        );

      case ButtonType.danger:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? AppColors.error,
          textColor: textColor ?? Colors.white,
          borderColor: borderColor ?? AppColors.error,
          elevation: 2,
        );

      case ButtonType.success:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? AppColors.success,
          textColor: textColor ?? Colors.white,
          borderColor: borderColor ?? AppColors.success,
          elevation: 2,
        );

      case ButtonType.warning:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? AppColors.warning,
          textColor: textColor ?? Colors.white,
          borderColor: borderColor ?? AppColors.warning,
          elevation: 2,
        );

      case ButtonType.info:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? AppColors.info,
          textColor: textColor ?? Colors.white,
          borderColor: borderColor ?? AppColors.info,
          elevation: 2,
        );

      case ButtonType.ghost:
        return ButtonConfig(
          backgroundColor: backgroundColor ?? Colors.transparent,
          textColor: textColor ??
              (isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface),
          borderColor: borderColor ?? Colors.transparent,
          elevation: 0,
        );
    }
  }

  SizeConfig _getSizeConfig(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (size) {
      case ButtonSize.small:
        return SizeConfig(
          height: height ?? 32,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          textStyle: textStyle ??
              (textTheme.labelSmall ?? const TextStyle(fontSize: 12)),
          iconSize: 16,
        );

      case ButtonSize.medium:
        return SizeConfig(
          height: height ?? 44,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: textStyle ??
              (textTheme.labelMedium ?? const TextStyle(fontSize: 14)),
          iconSize: 20,
        );

      case ButtonSize.large:
        return SizeConfig(
          height: height ?? 52,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textStyle ??
              (textTheme.labelLarge ?? const TextStyle(fontSize: 16)),
          iconSize: 24,
        );

      case ButtonSize.extraLarge:
        return SizeConfig(
          height: height ?? 60,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          textStyle: textStyle ??
              (textTheme.headlineSmall ??
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          iconSize: 28,
        );
    }
  }

  Widget _buildButtonContent(BuildContext context) {
    final buttonConfig = _getButtonConfig(
        context, Theme.of(context).brightness == Brightness.dark);
    final sizeConfig = _getSizeConfig(context);

    final isEnabled = !isDisabled && !isLoading && onPressed != null;

    return Material(
      elevation: buttonConfig.elevation,
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      color: isEnabled
          ? buttonConfig.backgroundColor
          : buttonConfig.backgroundColor.withOpacity(0.5),
      child: InkWell(
        onTap: isEnabled
            ? () {
                if (enableHapticFeedback) {
                  DeviceUtils.lightHaptic();
                }
                onPressed?.call();
              }
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        child: Container(
          height: sizeConfig.height,
          padding: sizeConfig.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            border: buttonConfig.borderColor != Colors.transparent
                ? Border.all(
                    color: isEnabled
                        ? buttonConfig.borderColor
                        : buttonConfig.borderColor.withOpacity(0.5),
                    width: 1,
                  )
                : null,
          ),
          child: _buildContent(context, buttonConfig, sizeConfig, isEnabled),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ButtonConfig buttonConfig,
      SizeConfig sizeConfig, bool isEnabled) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: sizeConfig.iconSize,
          height: sizeConfig.iconSize,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              isEnabled
                  ? buttonConfig.textColor
                  : buttonConfig.textColor.withOpacity(0.5),
            ),
          ),
        ),
      );
    }

    final List<Widget> children = [];

    // Leading icon
    if (leadingIcon != null) {
      children.add(leadingIcon!);
      children.add(const SizedBox(width: 8));
    } else if (icon != null) {
      children.add(icon!);
      children.add(const SizedBox(width: 8));
    }

    // Text
    children.add(
      Flexible(
        child: Text(
          text,
          style: sizeConfig.textStyle.copyWith(
            color: isEnabled
                ? buttonConfig.textColor
                : buttonConfig.textColor.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );

    // Trailing icon
    if (trailingIcon != null) {
      children.add(const SizedBox(width: 8));
      children.add(trailingIcon!);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

// Button factory methods
class CustomButtonFactory {
  static Widget primary({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.primary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }

  static Widget secondary({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.secondary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }

  static Widget outline({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.outline,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }

  static Widget text({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.text,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      tooltip: tooltip,
    );
  }

  static Widget danger({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.danger,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }

  static Widget success({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.success,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }

  static Widget warning({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.warning,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }

  static Widget info({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.info,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }

  static Widget ghost({
    required String text,
    required VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    Widget? icon,
    bool isFullWidth = false,
    String? tooltip,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      type: ButtonType.ghost,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      isFullWidth: isFullWidth,
      tooltip: tooltip,
    );
  }
}

// Enums and data classes
enum ButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
  success,
  warning,
  info,
  ghost,
}

enum ButtonSize {
  small,
  medium,
  large,
  extraLarge,
}

class ButtonConfig {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double elevation;

  const ButtonConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.elevation,
  });
}

class SizeConfig {
  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final double iconSize;

  const SizeConfig({
    required this.height,
    required this.padding,
    required this.textStyle,
    required this.iconSize,
  });
}
