import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookingConfirmationPage extends ConsumerStatefulWidget {
  final String bookingId;

  const BookingConfirmationPage({super.key, required this.bookingId});

  @override
  ConsumerState<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState
    extends ConsumerState<BookingConfirmationPage> {
  bool _isLoading = false;
  bool _hasError = false;
  String _selectedPaymentMethod = 'bkash';
  bool _acceptedTerms = false;

  Future<void> _confirmBooking() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // TODO: Implement booking confirmation logic
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.go('/booking/success');
      }
    } catch (e) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to confirm booking'),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBookingDetails(),
          const SizedBox(height: 24),
          _buildPaymentMethods(),
          const SizedBox(height: 24),
          _buildTermsAndConditions(),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildTurfInfo(),
            const Divider(height: 32),
            _buildDetailRow('Date', 'January 1, 2024'),
            const SizedBox(height: 8),
            _buildDetailRow('Time', '18:00 - 19:00'),
            const SizedBox(height: 8),
            _buildDetailRow('Duration', '1 hour'),
            const Divider(height: 32),
            _buildPriceBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildTurfInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/turf_placeholder.jpg',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample Turf Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 4),
                  const Text('Sample Location'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Breakdown',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Turf Rent (1 hour)', 'BDT 1500'),
        const SizedBox(height: 8),
        _buildDetailRow('Service Fee', 'BDT 50'),
        const SizedBox(height: 8),
        _buildDetailRow('VAT (5%)', 'BDT 77.50'),
        const Divider(height: 16),
        _buildDetailRow(
          'Total Amount',
          'BDT 1627.50',
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildPaymentMethodTile(
              'bkash',
              'bKash',
              'assets/images/bkash_logo.png',
            ),
            _buildPaymentMethodTile(
              'nagad',
              'Nagad',
              'assets/images/nagad_logo.png',
            ),
            _buildPaymentMethodTile(
              'rocket',
              'Rocket',
              'assets/images/rocket_logo.png',
            ),
            _buildPaymentMethodTile(
              'card',
              'Credit/Debit Card',
              'assets/images/card_logo.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(
    String value,
    String label,
    String logoAsset,
  ) {
    return RadioListTile(
      value: value,
      groupValue: _selectedPaymentMethod,
      onChanged: (newValue) {
        setState(() => _selectedPaymentMethod = newValue!);
      },
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.payment),
            // TODO: Replace with actual logo
            // child: Image.asset(
            //   logoAsset,
            //   width: 40,
            //   height: 40,
            // ),
          ),
          const SizedBox(width: 16),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              '• Cancellation is free up to 24 hours before the booking\n'
              '• 50% of the booking amount will be charged for cancellations within 24 hours\n'
              '• No refund for no-shows\n'
              '• Please arrive 15 minutes before your slot\n'
              '• Bring your own sports equipment',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    setState(() => _acceptedTerms = value!);
                  },
                ),
                Expanded(
                  child: Text(
                    'I agree to the terms and conditions',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BDT 1627.50',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const Text('Total Amount (incl. VAT)'),
              ],
            ),
          ),
          FilledButton(
            onPressed: _isLoading ? null : _confirmBooking,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Confirm & Pay'),
          ),
        ],
      ),
    );
  }
}