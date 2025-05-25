import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainNavigationPage extends ConsumerStatefulWidget {
  final Widget child;
  final String location;

  const MainNavigationPage({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  ConsumerState<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends ConsumerState<MainNavigationPage> {
  int _calculateSelectedIndex() {
    final String location = widget.location;

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/turf')) return 1;
    if (location.startsWith('/booking')) return 2;
    if (location.startsWith('/profile')) return 3;

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        if (widget.location != '/home') {
          context.go('/home');
        }
        break;
      case 1:
        if (widget.location != '/turf/list') {
          context.go('/turf/list');
        }
        break;
      case 2:
        if (widget.location != '/booking/history') {
          context.go('/booking/history');
        }
        break;
      case 3:
        if (widget.location != '/profile') {
          context.go('/profile');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_soccer_outlined),
            selectedIcon: Icon(Icons.sports_soccer),
            label: 'Turfs',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget? _buildFloatingActionButton() {
    // Only show FAB on specific pages
    if (widget.location.startsWith('/turf/list') ||
        widget.location.startsWith('/home')) {
      return FloatingActionButton(
        onPressed: () {
          // TODO: Implement quick booking flow
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const _QuickBookBottomSheet(),
          );
        },
        child: const Icon(Icons.add),
      );
    }
    return null;
  }
}

class _QuickBookBottomSheet extends StatelessWidget {
  const _QuickBookBottomSheet();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quick Book',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // TODO: Implement quick booking form
                    const Text('Quick booking form will be implemented here'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
