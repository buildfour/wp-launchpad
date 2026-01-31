import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Welcome to WP Launchpad',
            'WP Launchpad is your personal WordPress deployment assistant. Instead of performing installations directly, we guide you through each step with customized instructions, generated configuration files, and helpful tools.',
            Icons.waving_hand,
          ),
          _buildSection(
            'What You\'ll Need',
            '''Before starting, make sure you have:

• A domain name (e.g., yourdomain.com)
• A hosting account (cPanel, DigitalOcean, or similar)
• Access to your domain registrar\'s DNS settings
• About 30-60 minutes for the complete setup''',
            Icons.checklist,
          ),
          _buildSection(
            'Step 1: Create Your Project',
            '''Start by clicking "New Deploy" in the sidebar or dashboard.

1. Enter your project name (e.g., "My Blog")
2. Describe your website\'s purpose
3. Click "Continue" to proceed

Your project settings are saved automatically so you can resume anytime.''',
            Icons.create_new_folder,
          ),
          _buildSection(
            'Step 2: Configure Infrastructure',
            '''Tell us about your hosting setup:

1. Select your hosting provider (cPanel, DigitalOcean, etc.)
2. We\'ll customize all instructions for your specific platform
3. Follow the provider-specific setup guide

Don\'t worry if you\'re unsure - our guides explain everything!''',
            Icons.cloud,
          ),
          _buildSection(
            'Step 3: Set Up DNS',
            '''Point your domain to your hosting server:

1. We\'ll show you the exact DNS records to add
2. Log into your domain registrar
3. Add the A record and any other required records
4. Use our DNS checker to verify propagation

DNS changes can take 15 minutes to 48 hours to propagate globally.''',
            Icons.dns,
          ),
          _buildSection(
            'Step 4: Generate Configuration',
            '''We\'ll create your WordPress configuration files:

• wp-config.php with secure settings
• Automatic security salt generation
• Custom database table prefix
• Platform-specific optimization

Download these files and upload them to your server.''',
            Icons.settings_applications,
          ),
          _buildSection(
            'Step 5: Verify & Launch',
            '''Final checks before going live:

1. Use our "Check Live" tool to verify installation
2. Complete the "First 5 Minutes" checklist
3. Download your credentials summary
4. Get a PDF guide for future reference

Congratulations - your WordPress site is ready!''',
            Icons.rocket_launch,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.success.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.tips_and_updates, color: AppTheme.success, size: 28),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pro Tip', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                      SizedBox(height: 4),
                      Text('Use our Templates feature to start with pre-configured setups for blogs, e-commerce, portfolios, or business sites.', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppTheme.primaryNavy.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: AppTheme.primaryNavy, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.textMain))),
            ],
          ),
          const SizedBox(height: 16),
          Text(content, style: const TextStyle(color: AppTheme.textMuted, height: 1.6, fontSize: 14)),
        ],
      ),
    );
  }
}
