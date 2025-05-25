import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/device_utils.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip? clipBehavior;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final bool enableFeedback;
  final bool enableSplash;
  final BorderRadius? borderRadius;
  final Border? border;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final CardType type;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final bool animated;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.enableFeedback = true,
    this.enableSplash = true,
    this.borderRadius,
    this.border,
    this.gradient,
    this.boxShadow,
    this.type = CardType.elevated,
    this.width,
    this.height,
    this.alignment,
    this.animated = false,
    this.animationDuration,
    this.animationCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    Widget cardWidget = _buildCard(context, isDark);
    
    if (animated) {
      cardWidget = AnimatedContainer(
        duration: animationDuration ?? const Duration(milliseconds: 200),
        curve: animationCurve ?? Curves.easeInOut,
        child: cardWidget,
      );
    }
    
    if (margin != null) {
      cardWidget = Padding(
        padding: margin!,
        child: cardWidget,
      );
    }
    
    return cardWidget;
  }

  Widget _buildCard(BuildContext context, bool isDark) {
    switch (type) {
      case CardType.elevated:
        return _buildElevatedCard(context, isDark);
      case CardType.filled:
        return _buildFilledCard(context, isDark);
      case CardType.outlined:
        return _buildOutlinedCard(context, isDark);
      case CardType.custom:
        return _buildCustomCard(context, isDark);
    }
  }

  Widget _buildElevatedCard(BuildContext context, bool isDark) {
    return Card(
      elevation: elevation ?? 2,
      shadowColor: shadowColor ?? Theme.of(context).colorScheme.shadow.withOpacity(0.1),
      surfaceTintColor: surfaceTintColor ?? Theme.of(context).colorScheme.primary,
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior ?? Clip.none,
      color: color ?? Theme.of(context).colorScheme.surface,
      child: _buildCardChild(context),
    );
  }

  Widget _buildFilledCard(BuildContext context, bool isDark) {
    final cardWidget = Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: border,
        gradient: gradient,
      ),
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      child: _buildCardContent(),
    );
    
    return _wrapWithGestures(cardWidget);
  }

  Widget _buildOutlinedCard(BuildContext context, bool isDark) {
    final cardWidget = Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: border ?? Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        gradient: gradient,
      ),
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      child: _buildCardContent(),
    );
    
    return _wrapWithGestures(cardWidget);
  }

  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Theme.of(context).colorScheme.primary;
      case 'pending':
        return Theme.of(context).colorScheme.secondary;
      case 'cancelled':
        return Theme.of(context).colorScheme.error;
      case 'completed':
        return Theme.of(context).colorScheme.tertiary;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Widget _buildCustomCard(BuildContext context, bool isDark) {
    final cardWidget = Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
        gradient: gradient,
        boxShadow: boxShadow,
      ),
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      child: _buildCardContent(),
    );
    
    return _wrapWithGestures(cardWidget);
  }

  Widget _buildCardContent() {
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: child,
      );
    }
    return child;
  }

  Widget _wrapWithGestures(Widget cardWidget) {
    if (onTap != null || onLongPress != null || onDoubleTap != null) {
      return GestureDetector(
        onTap: () {
          if (enableFeedback) {
            DeviceUtils.lightHapticFeedback();
          }
          onTap?.call();
        },
        onLongPress: () {
          if (enableFeedback) {
            DeviceUtils.mediumHapticFeedback();
          }
          onLongPress?.call();
        },
        onDoubleTap: () {
          if (enableFeedback) {
            DeviceUtils.lightHapticFeedback();
          }
          onDoubleTap?.call();
        },
        child: enableSplash ? Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            onDoubleTap: onDoubleTap,
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            child: cardWidget,
          ),
        ) : cardWidget,
      );
    }
    return cardWidget;
  }
}

// Specialized card widgets
class TurfCard extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final String price;
  final String? imageUrl;
  final List<String>? amenities;
  final bool isAvailable;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onBookNow;
  final EdgeInsetsGeometry? margin;

  const TurfCard({
    Key? key,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    this.imageUrl,
    this.amenities,
    this.isAvailable = true,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.onBookNow,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return CustomCard(
      margin: margin,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: imageUrl != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(isDark),
                        ),
                      )
                    : _buildImagePlaceholder(isDark),
              ),
              
              // Availability badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isAvailable ? AppColors.success : AppColors.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isAvailable ? 'Available' : 'Booked',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              // Favorite button
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? AppColors.error : Colors.grey[600],
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.warning,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                
                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Amenities
                if (amenities != null && amenities!.isNotEmpty) ..[
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: amenities!.take(3).map((amenity) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          amenity,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
                
                // Price and book button
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            price,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'per hour',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isDark ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isAvailable ? onBookNow : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(bool isDark) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Center(
        child: Icon(
          Icons.sports_soccer,
          size: 48,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String turfName;
  final String date;
  final String time;
  final String status;
  final String amount;
  final String? bookingId;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final EdgeInsetsGeometry? margin;

  const BookingCard({
    Key? key,
    required this.turfName,
    required this.date,
    required this.time,
    required this.status,
    required this.amount,
    this.bookingId,
    this.onTap,
    this.onCancel,
    this.onReschedule,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    Color statusColor;
    final colorScheme = Theme.of(context).colorScheme;
    switch (status.toLowerCase()) {
      case 'confirmed':
        statusColor = colorScheme.tertiary;
        break;
      case 'pending':
        statusColor = colorScheme.secondary;
        break;
      case 'cancelled':
        statusColor = colorScheme.error;
        break;
      case 'completed':
        statusColor = colorScheme.primary;
        break;
      default:
        statusColor = colorScheme.primary;
    }
    
    return CustomCard(
      margin: margin,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Row(
              children: [
                Expanded(
                  child: Text(
                    turfName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Booking details
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        context,
                        Icons.calendar_today_outlined,
                        'Date',
                        date,
                        isDark,
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.access_time_outlined,
                        'Time',
                        time,
                        isDark,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amount,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (bookingId != null)
                      Text(
                        'ID: $bookingId',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            
            // Action buttons
            if (status.toLowerCase() == 'confirmed' && (onCancel != null || onReschedule != null)) ..[
              const SizedBox(height: 16),
              Row(
                children: [
                  if (onReschedule != null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReschedule,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Reschedule',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ),
                  if (onReschedule != null && onCancel != null)
                    const SizedBox(width: 12),
                  if (onCancel != null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onCancel,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.error),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    bool isDark,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Factory methods for common card types
class CustomCardFactory {
  static Widget elevated({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    VoidCallback? onTap,
    BorderRadius? borderRadius,
  }) {
    return CustomCard(
      type: CardType.elevated,
      padding: padding,
      margin: margin,
      elevation: elevation,
      onTap: onTap,
      borderRadius: borderRadius,
      child: child,
    );
  }

  static Widget filled({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    VoidCallback? onTap,
    BorderRadius? borderRadius,
  }) {
    return CustomCard(
      type: CardType.filled,
      padding: padding,
      margin: margin,
      color: color,
      onTap: onTap,
      borderRadius: borderRadius,
      child: child,
    );
  }

  static Widget outlined({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Border? border,
    VoidCallback? onTap,
    BorderRadius? borderRadius,
  }) {
    return CustomCard(
      type: CardType.outlined,
      padding: padding,
      margin: margin,
      border: border,
      onTap: onTap,
      borderRadius: borderRadius,
      child: child,
    );
  }

  static Widget gradient({
    required Widget child,
    required Gradient gradient,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    BorderRadius? borderRadius,
  }) {
    return CustomCard(
      type: CardType.custom,
      padding: padding,
      margin: margin,
      gradient: gradient,
      onTap: onTap,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

enum CardType {
  elevated,
  filled,
  outlined,
  custom,
}

  // Update image placeholder background color
  Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
    ),
    child: imageUrl != null
      ? ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(isDark),
          ),
        )
      : _buildImagePlaceholder(isDark),
  ),

  // Update availability badge colors
  Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: isAvailable 
        ? Theme.of(context).colorScheme.primary 
        : Theme.of(context).colorScheme.error,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      isAvailable ? 'Available' : 'Booked',
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Update favorite icon colors
  Icon(
    isFavorite ? Icons.favorite : Icons.favorite_border,
    color: isFavorite 
      ? Theme.of(context).colorScheme.error 
      : Theme.of(context).colorScheme.onSurfaceVariant,
    size: 20,
  ),

  // Update star icon color
  Icon(
    Icons.star,
    color: Theme.of(context).colorScheme.secondary,
    size: 16,
  ),

  // Update status colors in switch statement
  Color getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Theme.of(context).colorScheme.primary;
      case 'pending':
        return Theme.of(context).colorScheme.secondary;
      case 'cancelled':
        return Theme.of(context).colorScheme.error;
      case 'completed':
        return Theme.of(context).colorScheme.tertiary;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}