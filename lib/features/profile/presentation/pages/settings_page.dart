import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isDarkMode = false;
  bool _isNotificationsEnabled = true;
  String _selectedLanguage = 'en';
  bool _isLoading = false;

  Future<void> _updateSettings() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Implement settings update logic
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update settings')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildAppearanceSection(),
          const Divider(),
          _buildNotificationsSection(),
          const Divider(),
          _buildLanguageSection(),
          const Divider(),
          _buildAccountSection(),
          const Divider(),
          _buildSecuritySection(),
          const Divider(),
          _buildDataSection(),
        ],
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Use dark theme throughout the app'),
          value: _isDarkMode,
          onChanged: (value) {
            setState(() => _isDarkMode = value);
            _updateSettings();
          },
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Notifications',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SwitchListTile(
          title: const Text('Push Notifications'),
          subtitle: const Text('Receive booking updates and offers'),
          value: _isNotificationsEnabled,
          onChanged: (value) {
            setState(() => _isNotificationsEnabled = value);
            _updateSettings();
          },
        ),
        ListTile(
          title: const Text('Notification Preferences'),
          subtitle: const Text('Customize notification types'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/profile/notifications'),
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Language',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        RadioListTile<String>(
          title: const Text('English'),
          value: 'en',
          groupValue: _selectedLanguage,
          onChanged: (value) {
            setState(() => _selectedLanguage = value!);
            _updateSettings();
          },
        ),
        RadioListTile<String>(
          title: const Text('বাংলা'),
          value: 'bn',
          groupValue: _selectedLanguage,
          onChanged: (value) {
            setState(() => _selectedLanguage = value!);
            _updateSettings();
          },
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Account',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/profile/edit'),
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: const Text('Change Phone Number'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/profile/change-phone'),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Change Email'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/profile/change-email'),
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Security',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Change Password'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/auth/change-password'),
        ),
        ListTile(
          leading: const Icon(Icons.fingerprint),
          title: const Text('Biometric Authentication'),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO: Implement biometric toggle
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Data & Storage',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.storage),
          title: const Text('Clear Cache'),
          subtitle: const Text('0.0 MB'),
          onTap: () {
            // TODO: Implement cache clearing
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cache cleared')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete Account'),
          textColor: Theme.of(context).colorScheme.error,
          iconColor: Theme.of(context).colorScheme.error,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Account'),
                content: const Text(
                  'Are you sure you want to delete your account? This action cannot be undone.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement account deletion
                      Navigator.pop(context);
                      context.go('/auth/login');
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}