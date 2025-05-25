import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentFailedPage extends ConsumerWidget {
  final String error;
  final String? bookingId;

  const PaymentFailedPage({
    super.key,
    required this.error,
    this.bookingId,
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
                Icons.error_outline,
                color: Colors.red,
                size: 96,
              ),
              const SizedBox(height: 24),
              Text(
                'Payment Failed',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'We couldn\'t process your payment. Please try again.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildErrorDetails(context),
              const Spacer(),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            context,
            'Error Code',
            'ERR_PAYMENT_FAILED',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            context,
            'Transaction ID',
            '#TX12345',
          ),
          const Divider(height: 24),
          _buildDetailRow(
            context,
            'Amount',
            '৳1050',
          ),
          const SizedBox(height: 16),
          const Text(
            'Possible reasons for failure:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildErrorReason('Insufficient funds in your account'),
          _buildErrorReason('Network connectivity issues'),
          _buildErrorReason('Bank server timeout'),
          _buildErrorReason('Invalid card details'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildErrorReason(String reason) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 8,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(reason),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: () => context.pop(),
          child: const Text('Try Again'),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () => context.go('/home'),
          child: const Text('Back to Home'),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.push('/help-support'),
          child: const Text('Contact Support'),
        ),
      ],
    );
  }
}