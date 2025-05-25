import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final LoadingType type;
  final Color? color;
  final double? size;
  final double? strokeWidth;
  final bool showMessage;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const LoadingWidget({
    Key? key,
    this.message,
    this.type = LoadingType.circular,
    this.color,
    this.size,
    this.strokeWidth,
    this.showMessage = true,
    this.messageStyle,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loadingColor = color ?? AppColors.primary;

    Widget loadingIndicator;

    switch (type) {
      case LoadingType.circular:
        loadingIndicator = SizedBox(
          width: size ?? 24,
          height: size ?? 24,
          child: CircularProgressIndicator(
            color: loadingColor,
            strokeWidth: strokeWidth ?? 2.5,
          ),
        );
        break;
      case LoadingType.linear:
        loadingIndicator = SizedBox(
          width: size ?? 200,
          child: LinearProgressIndicator(
            color: loadingColor,
            backgroundColor: loadingColor.withOpacity(0.2),
          ),
        );
        break;
      case LoadingType.dots:
        loadingIndicator = DotsLoadingIndicator(
          color: loadingColor,
          size: size ?? 8,
        );
        break;
      case LoadingType.pulse:
        loadingIndicator = PulseLoadingIndicator(
          color: loadingColor,
          size: size ?? 40,
        );
        break;
      case LoadingType.wave:
        loadingIndicator = WaveLoadingIndicator(
          color: loadingColor,
          size: size ?? 40,
        );
        break;
      case LoadingType.spinner:
        loadingIndicator = SpinnerLoadingIndicator(
          color: loadingColor,
          size: size ?? 24,
        );
        break;
      case LoadingType.custom:
        loadingIndicator = child ?? const SizedBox.shrink();
        break;
    }

    if (!showMessage || message == null) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: loadingIndicator,
      );
    }

    return Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loadingIndicator,
          const SizedBox(height: 16),
          Text(
            message!,
            style: messageStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Overlay loading widget
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final LoadingType type;
  final Color? backgroundColor;
  final Color? loadingColor;
  final double? size;
  final bool dismissible;

  const LoadingOverlay({
    Key? key,
    required this.child,
    required this.isLoading,
    this.message,
    this.type = LoadingType.circular,
    this.backgroundColor,
    this.loadingColor,
    this.size,
    this.dismissible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: GestureDetector(
              onTap: dismissible
                  ? null
                  : () {}, // Prevent taps when not dismissible
              child: Container(
                color: backgroundColor ?? Colors.black.withOpacity(0.5),
                child: Center(
                  child: LoadingWidget(
                    message: message,
                    type: type,
                    color: loadingColor,
                    size: size,
                    padding: const EdgeInsets.all(24),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Full screen loading widget
class FullScreenLoading extends StatelessWidget {
  final String? message;
  final LoadingType type;
  final Color? backgroundColor;
  final Color? loadingColor;
  final double? size;
  final bool canPop;

  const FullScreenLoading({
    Key? key,
    this.message,
    this.type = LoadingType.circular,
    this.backgroundColor,
    this.loadingColor,
    this.size,
    this.canPop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        backgroundColor:
            backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: LoadingWidget(
            message: message,
            type: type,
            color: loadingColor,
            size: size,
            padding: const EdgeInsets.all(32),
          ),
        ),
      ),
    );
  }
}

// Dots loading indicator
class DotsLoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const DotsLoadingIndicator({
    Key? key,
    required this.color,
    this.size = 8,
    this.duration = const Duration(milliseconds: 1200),
  }) : super(key: key);

  @override
  State<DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<DotsLoadingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.size * 0.2),
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color
                    .withOpacity(0.3 + (_animations[index].value * 0.7)),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}

// Pulse loading indicator
class PulseLoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const PulseLoadingIndicator({
    Key? key,
    required this.color,
    this.size = 40,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<PulseLoadingIndicator> createState() => _PulseLoadingIndicatorState();
}

class _PulseLoadingIndicatorState extends State<PulseLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.3 + (_animation.value * 0.7)),
            shape: BoxShape.circle,
          ),
          transform: Matrix4.identity()..scale(0.5 + (_animation.value * 0.5)),
        );
      },
    );
  }
}

// Wave loading indicator
class WaveLoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const WaveLoadingIndicator({
    Key? key,
    required this.color,
    this.size = 40,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  State<WaveLoadingIndicator> createState() => _WaveLoadingIndicatorState();
}

class _WaveLoadingIndicatorState extends State<WaveLoadingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
      (index) => AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          _controllers[i].repeat();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(4, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Container(
                width: widget.size * (0.2 + (_animations[index].value * 0.8)),
                height: widget.size * (0.2 + (_animations[index].value * 0.8)),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.color
                        .withOpacity(1.0 - _animations[index].value),
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

// Spinner loading indicator
class SpinnerLoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const SpinnerLoadingIndicator({
    Key? key,
    required this.color,
    this.size = 24,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<SpinnerLoadingIndicator> createState() =>
      _SpinnerLoadingIndicatorState();
}

class _SpinnerLoadingIndicatorState extends State<SpinnerLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: SpinnerPainter(color: widget.color),
      ),
    );
  }
}

class SpinnerPainter extends CustomPainter {
  final Color color;

  SpinnerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - paint.strokeWidth / 2;

    // Draw arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      3.14159 * 1.5, // 270 degrees
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Factory methods for common loading scenarios
class LoadingWidgetFactory {
  static Widget button({
    String? message,
    Color? color,
    double size = 16,
  }) {
    return LoadingWidget(
      type: LoadingType.circular,
      color: color ?? Colors.white,
      size: size,
      showMessage: false,
    );
  }

  static Widget page({
    String? message,
    LoadingType type = LoadingType.circular,
    Color? color,
  }) {
    return LoadingWidget(
      message: message ?? 'Loading...',
      type: type,
      color: color,
      padding: const EdgeInsets.all(32),
    );
  }

  static Widget overlay({
    required Widget child,
    required bool isLoading,
    String? message,
    LoadingType type = LoadingType.circular,
    Color? backgroundColor,
    Color? loadingColor,
  }) {
    return LoadingOverlay(
      isLoading: isLoading,
      message: message,
      type: type,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      child: child,
    );
  }

  static Widget fullScreen({
    String? message,
    LoadingType type = LoadingType.circular,
    Color? backgroundColor,
    Color? loadingColor,
    bool canPop = false,
  }) {
    return FullScreenLoading(
      message: message ?? 'Loading...',
      type: type,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      canPop: canPop,
    );
  }

  static Widget list({
    String? message,
    Color? color,
  }) {
    return LoadingWidget(
      message: message ?? 'Loading data...',
      type: LoadingType.dots,
      color: color,
      padding: const EdgeInsets.all(24),
    );
  }

  static Widget refresh({
    Color? color,
    double size = 20,
  }) {
    return LoadingWidget(
      type: LoadingType.circular,
      color: color,
      size: size,
      showMessage: false,
    );
  }
}

enum LoadingType {
  circular,
  linear,
  dots,
  pulse,
  wave,
  spinner,
  custom,
}
