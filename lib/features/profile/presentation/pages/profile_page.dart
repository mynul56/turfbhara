import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement profile loading logic
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      // No need to set _hasError, as we are not using it to display error
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    // TODO: Implement logout logic
    context.go('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
                  slivers: [
                    _buildAppBar(),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildQuickActions(),
                            const SizedBox(height: 24),
                            _buildMenuItems(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _QuickActionButton(
          icon: Icons.history,
          label: 'History',
          onTap: () => context.push('/booking/history'),
        ),
        _QuickActionButton(
          icon: Icons.favorite,
          label: 'Favorites',
          onTap: () => context.push('/turf/favorites'),
        ),
        _QuickActionButton(
          icon: Icons.wallet,
          label: 'Wallet',
          onTap: () => context.push('/wallet'),
        ),
        _QuickActionButton(
          icon: Icons.local_offer,
          label: 'Offers',
          onTap: () => context.push('/offers'),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Column(
      children: [
        _MenuItem(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () => context.push('/profile/settings'),
        ),
        _MenuItem(
          icon: Icons.notifications,
          title: 'Notifications',
          onTap: () => context.push('/profile/notifications'),
        ),
        _MenuItem(
          icon: Icons.help,
          title: 'Help & Support',
          onTap: () => context.push('/profile/help-support'),
        ),
        _MenuItem(
          icon: Icons.info,
          title: 'About',
          onTap: () => context.push('/profile/about'),
        ),
        _MenuItem(
          icon: Icons.privacy_tip,
          title: 'Privacy Policy',
          onTap: () => context.push('/profile/privacy-policy'),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Terms & Conditions',
          onTap: () => context.push('/profile/terms-conditions'),
        ),
        _MenuItem(
          icon: Icons.logout,
          title: 'Logout',
          onTap: _logout,
          textColor: Theme.of(context).colorScheme.error,
          iconColor: Theme.of(context).colorScheme.error,
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: textColor != null
            ? TextStyle(color: textColor)
            : null,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}