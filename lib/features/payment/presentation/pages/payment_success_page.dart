import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessPage extends ConsumerWidget {
  final String transactionId;
  final String? bookingId;
  final double amount;

  const PaymentSuccessPage({
    super.key,
    required this.transactionId,
    this.bookingId,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 96,
              ),
              const SizedBox(height: 24),
              Text(
                'Payment Successful!',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Your booking has been confirmed.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildBookingDetails(context),
              const Spacer(),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            context,
            'Booking ID',
            '#12345',
          ),
          const Divider(height: 24),
          _buildDetailRow(
            context,
            'Turf',
            'Turf Name',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            context,
            'Date & Time',
            '25 Dec 2023, 6:00 PM - 7:00 PM',
          ),
          const Divider(height: 24),
          _buildDetailRow(
            context,
            'Amount Paid',
            '৳1050',
            valueStyle: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: () => context.go('/booking/history'),
          child: const Text('View Booking'),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () => context.go('/home'),
          child: const Text('Back to Home'),
        ),
      ],
    );
  }
}