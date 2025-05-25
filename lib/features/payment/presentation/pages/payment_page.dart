import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final String bookingId;
  final double amount;
  final String? paymentMethod;

  const PaymentPage({
    super.key,
    required this.bookingId,
    required this.amount,
    this.paymentMethod,
  });

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  bool _isLoading = true;
  bool _hasError = false;
  String _selectedMethod = 'card';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _loadBookingDetails();
  }

  Future<void> _loadBookingDetails() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // TODO: Implement booking details loading logic
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      setState(() => _hasError = true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);

    try {
      // TODO: Implement payment processing logic
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.push('/payment/success');
      }
    } catch (e) {
      if (mounted) {
        context.push('/payment/failed');
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Failed to load booking details'),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: _loadBookingDetails,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBookingDetails(),
                      const SizedBox(height: 24),
                      _buildPaymentMethods(),
                      const SizedBox(height: 24),
                      _buildPriceBreakdown(),
                    ],
                  ),
                ),
      bottomNavigationBar: _buildBottomBar(),
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
            const Row(
              children: [
                Icon(Icons.sports_soccer),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Turf Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Location'),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            const Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('Date: 25 Dec 2023'),
                SizedBox(width: 16),
                Icon(Icons.access_time),
                SizedBox(width: 8),
                Text('Time: 6:00 PM - 7:00 PM'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _PaymentMethodCard(
          title: 'Credit/Debit Card',
          subtitle: 'Pay securely with your card',
          icon: Icons.credit_card,
          value: 'card',
          groupValue: _selectedMethod,
          onChanged: (value) {
            setState(() => _selectedMethod = value!);
          },
        ),
        const SizedBox(height: 8),
        _PaymentMethodCard(
          title: 'bKash',
          subtitle: 'Pay with your bKash account',
          icon: Icons.account_balance_wallet,
          value: 'bkash',
          groupValue: _selectedMethod,
          onChanged: (value) {
            setState(() => _selectedMethod = value!);
          },
        ),
        const SizedBox(height: 8),
        _PaymentMethodCard(
          title: 'Nagad',
          subtitle: 'Pay with your Nagad account',
          icon: Icons.account_balance_wallet,
          value: 'nagad',
          groupValue: _selectedMethod,
          onChanged: (value) {
            setState(() => _selectedMethod = value!);
          },
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Turf Rent (1 hour)'),
            Text('৳1000'),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Service Fee'),
            Text('৳50'),
          ],
        ),
        const Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '৳1050',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
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
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total: ৳1050',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Inclusive of all taxes',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: FilledButton(
              onPressed: _isProcessing ? null : _processPayment,
              child: _isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Pay Now'),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _PaymentMethodCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: RadioListTile<String>(
        title: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        subtitle: Text(subtitle),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}