import 'package:flutter/material.dart';
import '../widgets/hero_card.dart';
import '../widgets/workflow_screen.dart';

class SupportScreen extends StatelessWidget {
  final VoidCallback onBack;

  const SupportScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return WorkflowScreen(
      heroCard: const HeroCard(
        title: 'Support Center',
        description: 'Comprehensive guides to help you through every step of your WordPress journey.',
        icon: Icons.support_agent_outlined,
      ),
      mainContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GuideItem(
            title: '1. Server Preparation Guide',
            description: 'Learn how to choose between cPanel and DigitalOcean, and how to retrieve your SSH credentials.',
            steps: const [
              'Choose your hosting provider (DigitalOcean for speed, cPanel for ease).',
              'Generate or locate your SSH key or root password.',
              'Ensure port 80 and 443 are open on your firewall.',
            ],
          ),
          const Divider(height: 48),
          _GuideItem(
            title: '2. WordPress Configuration Guide',
            description: 'Detailed steps on setting up your database and generating a secure wp-config.php file.',
            steps: const [
              'Create a MySQL database and user via your hosting panel or terminal.',
              'Grant all privileges to the user for that specific database.',
              'Input the credentials into the WP Launchpad Config Generator.',
            ],
          ),
          const Divider(height: 48),
          _GuideItem(
            title: '3. DNS & Domain Mapping Guide',
            description: 'How to point your domain name to your new server IP address.',
            steps: const [
              'Log in to your domain registrar (e.g., GoDaddy, Namecheap).',
              'Create an "A" record pointing to your server IP.',
              'Wait for propagation (can take up to 24-48 hours).',
            ],
          ),
        ],
      ),
      navButtons: OutlinedButton(
        onPressed: onBack,
        child: const Text('Back to Dashboard'),
      ),
    );
  }
}

class _GuideItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> steps;

  const _GuideItem({
    required this.title,
    required this.description,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        ...steps.map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline, size: 18, color: Color(0xFF10B981)),
                  const SizedBox(width: 12),
                  Expanded(child: Text(step, style: Theme.of(context).textTheme.bodyLarge)),
                ],
              ),
            )),
      ],
    );
  }
}
