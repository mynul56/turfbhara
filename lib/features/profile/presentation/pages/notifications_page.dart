import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  bool _isLoading = true;
  bool _hasError = false;

  final Map<String, bool> _preferences = {
    'booking_confirmation': true,
    'booking_reminder': true,
    'booking_updates': true,
    'payment_confirmation': true,
    'payment_failed': true,
    'special_offers': true,
    'news_updates': false,
    'maintenance_alerts': true,
  };

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // TODO: Implement notifications loading logic
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      setState(() => _hasError = true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updatePreference(String key, bool value) async {
    setState(() => _preferences[key] = value);
    try {
      // TODO: Implement preference update logic
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      // Revert on failure
      setState(() => _preferences[key] = !value);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update notification preference'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Preferences'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Failed to load notifications'),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: _loadNotifications,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : TabBarView(
                    children: [
                      _buildPreferencesTab(),
                      _buildHistoryTab(),
                    ],
                  ),
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return ListView(
      children: [
        _buildPreferenceSection(
          'Bookings',
          [
            _PreferenceItem(
              title: 'Booking Confirmation',
              subtitle: 'Get notified when your booking is confirmed',
              value: _preferences['booking_confirmation']!,
              onChanged: (value) =>
                  _updatePreference('booking_confirmation', value),
            ),
            _PreferenceItem(
              title: 'Booking Reminder',
              subtitle: 'Get reminded before your booking time',
              value: _preferences['booking_reminder']!,
              onChanged: (value) => _updatePreference('booking_reminder', value),
            ),
            _PreferenceItem(
              title: 'Booking Updates',
              subtitle: 'Get notified about changes to your booking',
              value: _preferences['booking_updates']!,
              onChanged: (value) => _updatePreference('booking_updates', value),
            ),
          ],
        ),
        const Divider(),
        _buildPreferenceSection(
          'Payments',
          [
            _PreferenceItem(
              title: 'Payment Confirmation',
              subtitle: 'Get notified when your payment is successful',
              value: _preferences['payment_confirmation']!,
              onChanged: (value) =>
                  _updatePreference('payment_confirmation', value),
            ),
            _PreferenceItem(
              title: 'Payment Failed',
              subtitle: 'Get notified when your payment fails',
              value: _preferences['payment_failed']!,
              onChanged: (value) => _updatePreference('payment_failed', value),
            ),
          ],
        ),
        const Divider(),
        _buildPreferenceSection(
          'Others',
          [
            _PreferenceItem(
              title: 'Special Offers',
              subtitle: 'Get notified about promotions and discounts',
              value: _preferences['special_offers']!,
              onChanged: (value) => _updatePreference('special_offers', value),
            ),
            _PreferenceItem(
              title: 'News & Updates',
              subtitle: 'Get notified about app updates and news',
              value: _preferences['news_updates']!,
              onChanged: (value) => _updatePreference('news_updates', value),
            ),
            _PreferenceItem(
              title: 'Maintenance Alerts',
              subtitle: 'Get notified about turf maintenance schedules',
              value: _preferences['maintenance_alerts']!,
              onChanged: (value) =>
                  _updatePreference('maintenance_alerts', value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreferenceSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildHistoryTab() {
    // TODO: Replace with actual notification data
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        final isToday = index < 3;
        final isYesterday = index >= 3 && index < 6;

        if (index == 0) {
          return _buildDateHeader('Today');
        } else if (index == 3) {
          return _buildDateHeader('Yesterday');
        } else if (index == 6) {
          return _buildDateHeader('Older');
        }

        return _NotificationItem(
          title: 'Notification Title $index',
          message: 'This is a sample notification message that describes what happened.',
          time: DateTime.now().subtract(
            Duration(hours: isToday ? index : (isYesterday ? 24 + index : 48 + index)),
          ),
          type: index % 4 == 0
              ? NotificationType.booking
              : index % 4 == 1
                  ? NotificationType.payment
                  : index % 4 == 2
                      ? NotificationType.offer
                      : NotificationType.system,
        );
      },
    );
  }

  Widget _buildDateHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class _PreferenceItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PreferenceItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}

enum NotificationType { booking, payment, offer, system }

class _NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
  });

  IconData get _icon {
    switch (type) {
      case NotificationType.booking:
        return Icons.calendar_today;
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.offer:
        return Icons.local_offer;
      case NotificationType.system:
        return Icons.info;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (type) {
      case NotificationType.booking:
        return Colors.blue;
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.offer:
        return Colors.orange;
      case NotificationType.system:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String _formatTime() {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _getIconColor(context).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          _icon,
          color: _getIconColor(context),
        ),
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(message),
          const SizedBox(height: 4),
          Text(
            _formatTime(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}