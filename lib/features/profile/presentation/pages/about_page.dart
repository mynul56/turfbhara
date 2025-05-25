import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends ConsumerStatefulWidget {
  const AboutPage({super.key});

  @override
  ConsumerState<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends ConsumerState<AboutPage> {
  PackageInfo? _packageInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _packageInfo = packageInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildAppInfo(),
                const SizedBox(height: 24),
                _buildFeatures(),
                const SizedBox(height: 24),
                _buildTeam(),
                const SizedBox(height: 24),
                _buildSocialLinks(),
                const SizedBox(height: 24),
                _buildLegal(),
              ],
            ),
    );
  }

  Widget _buildAppInfo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/app_logo.png',
          height: 100,
          width: 100,
        ),
        const SizedBox(height: 16),
        Text(
          'TurfBhara',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Version ${_packageInfo?.version ?? 'Unknown'} (${_packageInfo?.buildNumber ?? 'Unknown'})',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        const Text(
          'Your one-stop solution for finding and booking sports turfs in Bangladesh.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildFeatureItem(
          icon: Icons.search,
          title: 'Easy Search',
          description: 'Find turfs near you with advanced search filters',
        ),
        _buildFeatureItem(
          icon: Icons.calendar_today,
          title: 'Quick Booking',
          description: 'Book your preferred time slot in just a few taps',
        ),
        _buildFeatureItem(
          icon: Icons.payment,
          title: 'Secure Payments',
          description: 'Multiple payment options with secure transactions',
        ),
        _buildFeatureItem(
          icon: Icons.star,
          title: 'Reviews & Ratings',
          description: 'Make informed decisions with community feedback',
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeam() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Development Team',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildTeamMember(
          name: 'John Doe',
          role: 'Lead Developer',
          imageUrl: 'assets/images/team/john.jpg',
        ),
        _buildTeamMember(
          name: 'Jane Smith',
          role: 'UI/UX Designer',
          imageUrl: 'assets/images/team/jane.jpg',
        ),
        _buildTeamMember(
          name: 'Mike Johnson',
          role: 'Backend Developer',
          imageUrl: 'assets/images/team/mike.jpg',
        ),
      ],
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String role,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                role,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Us',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialButton(
              icon: Icons.facebook,
              onTap: () => _launchUrl('https://facebook.com/turfbhara'),
            ),
            _buildSocialButton(
              icon: Icons.messenger,
              onTap: () => _launchUrl('https://m.me/turfbhara'),
            ),
            _buildSocialButton(
              icon: Icons.language,
              onTap: () => _launchUrl('https://turfbhara.com'),
            ),
            _buildSocialButton(
              icon: Icons.email,
              onTap: () => _launchUrl('mailto:contact@turfbhara.com'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton.filled(
      onPressed: onTap,
      icon: Icon(icon),
    );
  }

  Widget _buildLegal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legal',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(context, '/privacy-policy');
          },
        ),
        ListTile(
          title: const Text('Terms & Conditions'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(context, '/terms-conditions');
          },
        ),
        ListTile(
          title: const Text('Open Source Licenses'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            showLicensePage(
              context: context,
              applicationName: 'TurfBhara',
              applicationVersion: _packageInfo?.version,
            );
          },
        ),
      ],
    );
  }
}