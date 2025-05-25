import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsConditionsPage extends ConsumerWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Terms & Conditions',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Last updated: ${DateTime.now().toString().split(' ')[0]}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: 'Agreement to Terms',
            content: 'By accessing or using TurfBhara, you agree to be bound by these '
                'Terms and Conditions. If you disagree with any part of these terms, '
                'you may not access or use our services.',
          ),
          _buildSection(
            context,
            title: 'User Accounts',
            content: '• You must be at least 13 years old to use our services\n'
                '• You are responsible for maintaining the confidentiality of your account\n'
                '• You agree to provide accurate and complete information\n'
                '• You are responsible for all activities under your account\n'
                '• You must notify us immediately of any security breach',
          ),
          _buildSection(
            context,
            title: 'Booking Terms',
            content: '• All bookings are subject to availability\n'
                '• Prices are subject to change without notice\n'
                '• Payment must be made in full at the time of booking\n'
                '• Cancellation policies vary by turf\n'
                '• We reserve the right to cancel bookings in case of system errors\n'
                '• Users must comply with individual turf rules and regulations',
          ),
          _buildSection(
            context,
            title: 'Payment Terms',
            content: '• All payments are processed securely through our payment partners\n'
                '• Prices are in Bangladeshi Taka (BDT)\n'
                '• We accept various payment methods including cards and mobile banking\n'
                '• Refunds are processed according to our refund policy\n'
                '• Transaction fees may apply',
          ),
          _buildSection(
            context,
            title: 'Cancellation Policy',
            content: '• Free cancellation up to 24 hours before booking time\n'
                '• Cancellations within 24 hours may incur charges\n'
                '• No-shows will be charged in full\n'
                '• Refunds are processed within 5-7 business days\n'
                '• Force majeure events will be handled case by case',
          ),
          _buildSection(
            context,
            title: 'User Conduct',
            content: 'You agree not to:\n\n'
                '• Violate any laws or regulations\n'
                '• Impersonate others or provide false information\n'
                '• Interfere with the proper functioning of the service\n'
                '• Engage in unauthorized data collection\n'
                '• Use the service for unauthorized commercial purposes\n'
                '• Harass, abuse, or harm others',
          ),
          _buildSection(
            context,
            title: 'Intellectual Property',
            content: '• All content and materials are owned by TurfBhara\n'
                '• You may not use our trademarks without permission\n'
                '• User-generated content remains your property\n'
                '• You grant us license to use your content\n'
                '• We respect intellectual property rights',
          ),
          _buildSection(
            context,
            title: 'Limitation of Liability',
            content: '• We provide the service "as is" without warranties\n'
                '• We are not liable for indirect damages\n'
                '• Our liability is limited to the amount paid for the service\n'
                '• We do not guarantee availability of turfs\n'
                '• User assumes risks associated with physical activities',
          ),
          _buildSection(
            context,
            title: 'Dispute Resolution',
            content: '• Disputes will be resolved through negotiation\n'
                '• Mediation may be used if negotiation fails\n'
                '• Arbitration will be conducted in Dhaka, Bangladesh\n'
                '• Bangladesh law governs these terms\n'
                '• Small claims may be brought to local courts',
          ),
          _buildSection(
            context,
            title: 'Modifications',
            content: 'We reserve the right to modify these terms at any time. Changes '
                'will be effective immediately upon posting. Continued use of the '
                'service constitutes acceptance of modified terms.',
          ),
          _buildSection(
            context,
            title: 'Termination',
            content: 'We may terminate or suspend your account and access at any time, '
                'without prior notice, for conduct that violates these terms or '
                'for any other reason.',
          ),
          _buildSection(
            context,
            title: 'Contact Information',
            content: 'For questions about these Terms & Conditions, please contact us:\n\n'
                'TurfBhara\n'
                'Email: legal@turfbhara.com\n'
                'Phone: +880 123 456 7890\n'
                'Address: Dhaka, Bangladesh',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}