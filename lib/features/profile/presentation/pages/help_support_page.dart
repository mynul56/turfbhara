import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpSupportPage extends ConsumerStatefulWidget {
  const HelpSupportPage({super.key});

  @override
  ConsumerState<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends ConsumerState<HelpSupportPage> {
  final _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    }
  }

  Future<void> _submitTicket() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Implement ticket submission logic
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Support ticket submitted successfully'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit support ticket'),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showTicketDialog() {
    showDialog(
      context: context,
      builder: (context) => _SupportTicketDialog(
        onSubmit: _submitTicket,
        isLoading: _isLoading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        children: [
          _buildSearchBar(),
          _buildQuickHelp(),
          const Divider(),
          _buildFAQs(),
          const Divider(),
          _buildContactOptions(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showTicketDialog,
        icon: const Icon(Icons.support_agent),
        label: const Text('Submit Ticket'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        controller: _searchController,
        hintText: 'Search help articles...',
        leading: const Icon(Icons.search),
        onSubmitted: (value) {
          // TODO: Implement help article search
        },
      ),
    );
  }

  Widget _buildQuickHelp() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Help',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _QuickHelpCard(
                  icon: Icons.book,
                  title: 'User Guide',
                  onTap: () {
                    // TODO: Navigate to user guide
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _QuickHelpCard(
                  icon: Icons.video_library,
                  title: 'Video Tutorials',
                  onTap: () {
                    // TODO: Navigate to video tutorials
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQs() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          const ExpansionTile(
            title: Text('How do I book a turf?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'You can book a turf by following these steps:\n\n'
                  '1. Browse available turfs\n'
                  '2. Select your preferred date and time\n'
                  '3. Choose payment method\n'
                  '4. Confirm booking',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('What is the cancellation policy?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Our cancellation policy allows free cancellation up to 24 hours before the booking time. Cancellations made within 24 hours may be subject to charges.',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('How do I make a payment?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'We accept various payment methods including credit/debit cards, bKash, and Nagad. All payments are processed securely through our payment gateway.',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('What if the turf is unavailable?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'If your preferred turf is unavailable, we will suggest alternative turfs nearby with similar facilities. You can also set up notifications for when your preferred turf becomes available.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _ContactOptionCard(
            icon: Icons.phone,
            title: 'Call Us',
            subtitle: 'Available 24/7',
            onTap: () => _launchUrl('tel:+8801234567890'),
          ),
          const SizedBox(height: 8),
          _ContactOptionCard(
            icon: Icons.email,
            title: 'Email Support',
            subtitle: 'support@turfbhara.com',
            onTap: () => _launchUrl('mailto:support@turfbhara.com'),
          ),
          const SizedBox(height: 8),
          _ContactOptionCard(
            icon: Icons.chat,
            title: 'Live Chat',
            subtitle: 'Chat with our support team',
            onTap: () {
              // TODO: Implement live chat
            },
          ),
          const SizedBox(height: 8),
          _ContactOptionCard(
            icon: FontAwesomeIcons.whatsapp,
            title: 'WhatsApp',
            subtitle: '+880 123 456 7890',
            onTap: () => _launchUrl('https://wa.me/8801234567890'),
          ),
        ],
      ),
    );
  }
}

class _QuickHelpCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickHelpCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _SupportTicketDialog extends StatefulWidget {
  final VoidCallback onSubmit;
  final bool isLoading;

  const _SupportTicketDialog({
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  State<_SupportTicketDialog> createState() => _SupportTicketDialogState();
}

class _SupportTicketDialogState extends State<_SupportTicketDialog> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedCategory = 'general';

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Submit Support Ticket'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'general',
                  child: Text('General Inquiry'),
                ),
                DropdownMenuItem(
                  value: 'booking',
                  child: Text('Booking Issue'),
                ),
                DropdownMenuItem(
                  value: 'payment',
                  child: Text('Payment Issue'),
                ),
                DropdownMenuItem(
                  value: 'technical',
                  child: Text('Technical Support'),
                ),
              ],
              onChanged: (value) {
                setState(() => _selectedCategory = value!);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: widget.isLoading ? null : widget.onSubmit,
          child: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }
}
