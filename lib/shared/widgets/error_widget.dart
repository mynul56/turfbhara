import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/error/failures.dart';
import 'custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? details;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final String? actionText;
  final VoidCallback? onAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;
  final bool showDetails;
  final bool compact;
  final EdgeInsetsGeometry? padding;
  final ErrorType type;
  final Failure? failure;

  const CustomErrorWidget({
    Key? key,
    this.title,
    this.message,
    this.details,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.actionText,
    this.onAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.showDetails = false,
    this.compact = false,
    this.padding,
    this.type = ErrorType.general,
    this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final errorInfo = _getErrorInfo();
    
    if (compact) {
      return _buildCompactError(context, isDark, errorInfo);
    }
    
    return _buildFullError(context, isDark, errorInfo);
  }

  Widget _buildFullError(BuildContext context, bool isDark, _ErrorInfo errorInfo) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Error Icon
          Icon(
            errorInfo.icon,
            size: iconSize ?? 64,
            color: errorInfo.iconColor,
          ),
          const SizedBox(height: 24),
          
          // Error Title
          Text(
            errorInfo.title,
            style: AppTextStyles.headlineSmall(context).copyWith(
              color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          
          // Error Message
          Text(
            errorInfo.message,
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.lightOnSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          
          // Error Details (expandable)
          if (showDetails && errorInfo.details.isNotEmpty) ..[
            const SizedBox(height: 16),
            _buildDetailsSection(context, isDark, errorInfo.details),
          ],
          
          const SizedBox(height: 32),
          
          // Action Buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildCompactError(BuildContext context, bool isDark, _ErrorInfo errorInfo) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: errorInfo.iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: errorInfo.iconColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            errorInfo.icon,
            size: iconSize ?? 24,
            color: errorInfo.iconColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  errorInfo.title,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  errorInfo.message,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.lightOnSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (onAction != null) ..[
            const SizedBox(width: 12),
            TextButton(
              onPressed: onAction,
              child: Text(
                actionText ?? 'Retry',
                style: TextStyle(color: errorInfo.iconColor),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context, bool isDark, String details) {
    return ExpansionTile(
      title: Text(
        'Error Details',
        style: AppTextStyles.bodyMedium(context).copyWith(
          fontWeight: FontWeight.w600,
          color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
        ),
      ),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            details,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontFamily: 'monospace',
              color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.lightOnSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final buttons = <Widget>[];
    
    if (onAction != null) {
      buttons.add(
        CustomButton(
          text: actionText ?? 'Try Again',
          onPressed: onAction!,
          type: ButtonType.primary,
        ),
      );
    }
    
    if (onSecondaryAction != null) {
      buttons.add(
        CustomButton(
          text: secondaryActionText ?? 'Go Back',
          onPressed: onSecondaryAction!,
          type: ButtonType.outline,
        ),
      );
    }
    
    if (buttons.isEmpty) {
      return const SizedBox.shrink();
    }
    
    if (buttons.length == 1) {
      return buttons.first;
    }
    
    return Column(
      children: [
        buttons.first,
        const SizedBox(height: 12),
        buttons.last,
      ],
    );
  }

  _ErrorInfo _getErrorInfo() {
    // If failure is provided, extract info from it
    if (failure != null) {
      return _getErrorInfoFromFailure(failure!);
    }
    
    // Otherwise use provided values or defaults based on type
    switch (type) {
      case ErrorType.network:
        return _ErrorInfo(
          title: title ?? 'Network Error',
          message: message ?? 'Please check your internet connection and try again.',
          details: details ?? '',
          icon: icon ?? Icons.wifi_off,
          iconColor: iconColor ?? AppColors.error,
        );
      case ErrorType.server:
        return _ErrorInfo(
          title: title ?? 'Server Error',
          message: message ?? 'Something went wrong on our end. Please try again later.',
          details: details ?? '',
          icon: icon ?? Icons.cloud_off,
          iconColor: iconColor ?? AppColors.error,
        );
      case ErrorType.auth:
        return _ErrorInfo(
          title: title ?? 'Authentication Error',
          message: message ?? 'Please log in again to continue.',
          details: details ?? '',
          icon: icon ?? Icons.lock_outline,
          iconColor: iconColor ?? AppColors.warning,
        );
      case ErrorType.validation:
        return _ErrorInfo(
          title: title ?? 'Validation Error',
          message: message ?? 'Please check your input and try again.',
          details: details ?? '',
          icon: icon ?? Icons.error_outline,
          iconColor: iconColor ?? AppColors.warning,
        );
      case ErrorType.notFound:
        return _ErrorInfo(
          title: title ?? 'Not Found',
          message: message ?? 'The requested resource could not be found.',
          details: details ?? '',
          icon: icon ?? Icons.search_off,
          iconColor: iconColor ?? AppColors.info,
        );
      case ErrorType.permission:
        return _ErrorInfo(
          title: title ?? 'Permission Denied',
          message: message ?? 'You do not have permission to access this resource.',
          details: details ?? '',
          icon: icon ?? Icons.block,
          iconColor: iconColor ?? AppColors.error,
        );
      case ErrorType.timeout:
        return _ErrorInfo(
          title: title ?? 'Request Timeout',
          message: message ?? 'The request took too long to complete. Please try again.',
          details: details ?? '',
          icon: icon ?? Icons.timer_off,
          iconColor: iconColor ?? AppColors.warning,
        );
      case ErrorType.unknown:
        return _ErrorInfo(
          title: title ?? 'Unknown Error',
          message: message ?? 'An unexpected error occurred. Please try again.',
          details: details ?? '',
          icon: icon ?? Icons.help_outline,
          iconColor: iconColor ?? AppColors.error,
        );
      case ErrorType.general:
      default:
        return _ErrorInfo(
          title: title ?? 'Error',
          message: message ?? 'Something went wrong. Please try again.',
          details: details ?? '',
          icon: icon ?? Icons.error_outline,
          iconColor: iconColor ?? AppColors.error,
        );
    }
  }

  _ErrorInfo _getErrorInfoFromFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return _ErrorInfo(
          title: 'Server Error',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.cloud_off,
          iconColor: AppColors.error,
        );
      case NetworkFailure:
        return _ErrorInfo(
          title: 'Network Error',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.wifi_off,
          iconColor: AppColors.error,
        );
      case AuthFailure:
        return _ErrorInfo(
          title: 'Authentication Error',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.lock_outline,
          iconColor: AppColors.warning,
        );
      case ValidationFailure:
        return _ErrorInfo(
          title: 'Validation Error',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.error_outline,
          iconColor: AppColors.warning,
        );
      case NotFoundFailure:
        return _ErrorInfo(
          title: 'Not Found',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.search_off,
          iconColor: AppColors.info,
        );
      case PermissionFailure:
        return _ErrorInfo(
          title: 'Permission Denied',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.block,
          iconColor: AppColors.error,
        );
      case TimeoutFailure:
        return _ErrorInfo(
          title: 'Request Timeout',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.timer_off,
          iconColor: AppColors.warning,
        );
      default:
        return _ErrorInfo(
          title: 'Error',
          message: failure.message,
          details: failure.details ?? '',
          icon: Icons.error_outline,
          iconColor: AppColors.error,
        );
    }
  }
}

// Error page widget
class ErrorPage extends StatelessWidget {
  final String? title;
  final String? message;
  final String? details;
  final IconData? icon;
  final Color? iconColor;
  final String? actionText;
  final VoidCallback? onAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;
  final bool showDetails;
  final ErrorType type;
  final Failure? failure;

  const ErrorPage({
    Key? key,
    this.title,
    this.message,
    this.details,
    this.icon,
    this.iconColor,
    this.actionText,
    this.onAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.showDetails = false,
    this.type = ErrorType.general,
    this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: CustomErrorWidget(
              title: title,
              message: message,
              details: details,
              icon: icon,
              iconColor: iconColor,
              actionText: actionText,
              onAction: onAction,
              secondaryActionText: secondaryActionText,
              onSecondaryAction: onSecondaryAction,
              showDetails: showDetails,
              type: type,
              failure: failure,
            ),
          ),
        ),
      ),
    );
  }
}

// Error dialog widget
class ErrorDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? details;
  final IconData? icon;
  final Color? iconColor;
  final String? actionText;
  final VoidCallback? onAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;
  final bool showDetails;
  final ErrorType type;
  final Failure? failure;
  final bool barrierDismissible;

  const ErrorDialog({
    Key? key,
    this.title,
    this.message,
    this.details,
    this.icon,
    this.iconColor,
    this.actionText,
    this.onAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.showDetails = false,
    this.type = ErrorType.general,
    this.failure,
    this.barrierDismissible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: CustomErrorWidget(
        title: title,
        message: message,
        details: details,
        icon: icon,
        iconColor: iconColor,
        iconSize: 48,
        showDetails: showDetails,
        type: type,
        failure: failure,
        padding: EdgeInsets.zero,
      ),
      actions: [
        if (onSecondaryAction != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onSecondaryAction?.call();
            },
            child: Text(secondaryActionText ?? 'Cancel'),
          ),
        if (onAction != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onAction?.call();
            },
            child: Text(actionText ?? 'OK'),
          ),
        if (onAction == null && onSecondaryAction == null)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
      ],
    );
  }

  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    String? details,
    IconData? icon,
    Color? iconColor,
    String? actionText,
    VoidCallback? onAction,
    String? secondaryActionText,
    VoidCallback? onSecondaryAction,
    bool showDetails = false,
    ErrorType type = ErrorType.general,
    Failure? failure,
    bool barrierDismissible = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => ErrorDialog(
        title: title,
        message: message,
        details: details,
        icon: icon,
        iconColor: iconColor,
        actionText: actionText,
        onAction: onAction,
        secondaryActionText: secondaryActionText,
        onSecondaryAction: onSecondaryAction,
        showDetails: showDetails,
        type: type,
        failure: failure,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}

// Factory methods for common error scenarios
class ErrorWidgetFactory {
  static Widget network({
    String? message,
    VoidCallback? onRetry,
    bool compact = false,
  }) {
    return CustomErrorWidget(
      type: ErrorType.network,
      message: message,
      onAction: onRetry,
      actionText: 'Retry',
      compact: compact,
    );
  }

  static Widget server({
    String? message,
    VoidCallback? onRetry,
    bool compact = false,
  }) {
    return CustomErrorWidget(
      type: ErrorType.server,
      message: message,
      onAction: onRetry,
      actionText: 'Retry',
      compact: compact,
    );
  }

  static Widget notFound({
    String? message,
    VoidCallback? onGoBack,
    bool compact = false,
  }) {
    return CustomErrorWidget(
      type: ErrorType.notFound,
      message: message,
      onAction: onGoBack,
      actionText: 'Go Back',
      compact: compact,
    );
  }

  static Widget auth({
    String? message,
    VoidCallback? onLogin,
    bool compact = false,
  }) {
    return CustomErrorWidget(
      type: ErrorType.auth,
      message: message,
      onAction: onLogin,
      actionText: 'Login',
      compact: compact,
    );
  }

  static Widget permission({
    String? message,
    VoidCallback? onRequestPermission,
    bool compact = false,
  }) {
    return CustomErrorWidget(
      type: ErrorType.permission,
      message: message,
      onAction: onRequestPermission,
      actionText: 'Grant Permission',
      compact: compact,
    );
  }

  static Widget fromFailure(
    Failure failure, {
    VoidCallback? onRetry,
    VoidCallback? onGoBack,
    bool compact = false,
    bool showDetails = false,
  }) {
    return CustomErrorWidget(
      failure: failure,
      onAction: onRetry,
      onSecondaryAction: onGoBack,
      compact: compact,
      showDetails: showDetails,
    );
  }

  static Future<void> showDialog(
    BuildContext context,
    Failure failure, {
    VoidCallback? onRetry,
    VoidCallback? onGoBack,
    bool showDetails = false,
    bool barrierDismissible = true,
  }) {
    return ErrorDialog.show(
      context,
      failure: failure,
      onAction: onRetry,
      onSecondaryAction: onGoBack,
      showDetails: showDetails,
      barrierDismissible: barrierDismissible,
    );
  }
}

class _ErrorInfo {
  final String title;
  final String message;
  final String details;
  final IconData icon;
  final Color iconColor;

  _ErrorInfo({
    required this.title,
    required this.message,
    required this.details,
    required this.icon,
    required this.iconColor,
  });
}

enum ErrorType {
  general,
  network,
  server,
  auth,
  validation,
  notFound,
  permission,
  timeout,
  unknown,
}