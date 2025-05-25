import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyPage extends ConsumerWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Privacy Policy',
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
            title: 'Introduction',
            content: 'Welcome to TurfBhara. This Privacy Policy explains how we collect, '
                'use, disclose, and safeguard your information when you use our mobile '
                'application and services. Please read this Privacy Policy carefully. '
                'If you do not agree with the terms of this Privacy Policy, please '
                'do not access the application.',
          ),
          _buildSection(
            context,
            title: 'Information We Collect',
            content: 'We collect information that you provide directly to us when you:\n\n'
                '• Create an account\n'
                '• Make a booking\n'
                '• Contact our support team\n'
                '• Submit reviews or ratings\n'
                '• Update your profile\n\n'
                'This information may include:\n\n'
                '• Name and contact information\n'
                '• Payment information\n'
                '• Location data\n'
                '• Device information\n'
                '• Usage data',
          ),
          _buildSection(
            context,
            title: 'How We Use Your Information',
            content: 'We use the information we collect to:\n\n'
                '• Process your bookings\n'
                '• Provide customer support\n'
                '• Send booking confirmations and updates\n'
                '• Improve our services\n'
                '• Detect and prevent fraud\n'
                '• Send promotional communications (with your consent)\n'
                '• Comply with legal obligations',
          ),
          _buildSection(
            context,
            title: 'Information Sharing',
            content: 'We may share your information with:\n\n'
                '• Turf owners (for booking purposes)\n'
                '• Payment processors\n'
                '• Service providers\n'
                '• Law enforcement (when required by law)\n\n'
                'We do not sell your personal information to third parties.',
          ),
          _buildSection(
            context,
            title: 'Data Security',
            content: 'We implement appropriate technical and organizational measures to '
                'protect your personal information against unauthorized access, '
                'alteration, disclosure, or destruction. However, no method of '
                'transmission over the internet or electronic storage is 100% secure.',
          ),
          _buildSection(
            context,
            title: 'Your Rights',
            content: 'You have the right to:\n\n'
                '• Access your personal information\n'
                '• Correct inaccurate information\n'
                '• Request deletion of your information\n'
                '• Object to processing of your information\n'
                '• Withdraw consent\n'
                '• Data portability\n\n'
                'Contact us to exercise these rights.',
          ),
          _buildSection(
            context,
            title: 'Cookies and Tracking',
            content: 'We use cookies and similar tracking technologies to track activity '
                'on our application and hold certain information. You can instruct '
                'your browser to refuse all cookies or to indicate when a cookie is '
                'being sent.',
          ),
          _buildSection(
            context,
            title: 'Children\'s Privacy',
            content: 'Our services are not intended for users under the age of 13. We do '
                'not knowingly collect personal information from children under 13. '
                'If you become aware that a child has provided us with personal '
                'information, please contact us.',
          ),
          _buildSection(
            context,
            title: 'Changes to This Policy',
            content: 'We may update our Privacy Policy from time to time. We will notify '
                'you of any changes by posting the new Privacy Policy on this page '
                'and updating the "Last updated" date.',
          ),
          _buildSection(
            context,
            title: 'Contact Us',
            content: 'If you have any questions about this Privacy Policy, please contact us:\n\n'
                'TurfBhara\n'
                'Email: privacy@turfbhara.com\n'
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