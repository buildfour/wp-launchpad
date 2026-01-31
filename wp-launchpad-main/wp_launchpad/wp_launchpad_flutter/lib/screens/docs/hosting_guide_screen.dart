import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HostingGuideScreen extends StatelessWidget {
  const HostingGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Choosing Your Hosting',
            '''There are three main types of WordPress hosting:

Shared Hosting (cPanel)
Best for: Beginners, small sites, tight budgets
Examples: Bluehost, HostGator, SiteGround
Pros: Easy to use, affordable, managed for you
Cons: Limited resources, shared with other sites

Managed WordPress Hosting
Best for: Business sites, those wanting hands-off management
Examples: WP Engine, Kinsta, Flywheel
Pros: Optimized for WordPress, automatic updates, great support
Cons: More expensive, less flexibility

Cloud/VPS Hosting
Best for: Developers, high-traffic sites, full control
Examples: DigitalOcean, Linode, AWS Lightsail
Pros: Full control, scalable, cost-effective at scale
Cons: Requires technical knowledge, self-managed''',
            Icons.cloud_queue,
          ),
          const SizedBox(height: 8),
          const Text('cPanel Hosting Setup', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 16),
          _buildSection(
            'Accessing cPanel',
            '''Most shared hosts provide cPanel access:

1. Log into your hosting account
2. Look for "cPanel" or "Control Panel" button
3. Or visit: yourdomain.com/cpanel or yourdomain.com:2083

Your login credentials are usually:
• Sent in your welcome email
• Available in your hosting dashboard
• Same as your hosting account (sometimes)''',
            Icons.login,
          ),
          _buildSection(
            'Creating a Database (cPanel)',
            '''WordPress needs a MySQL database:

1. In cPanel, find "MySQL Databases"
2. Create a new database:
   • Enter a name (e.g., wp_mysite)
   • Click "Create Database"
3. Create a database user:
   • Enter username and strong password
   • Click "Create User"
4. Add user to database:
   • Select the user and database
   • Grant "ALL PRIVILEGES"
   • Click "Make Changes"

Save these credentials - you\'ll need them for wp-config.php!''',
            Icons.storage,
          ),
          _buildSection(
            'Uploading WordPress (cPanel)',
            '''Using File Manager:

1. Open "File Manager" in cPanel
2. Navigate to public_html (or your domain folder)
3. Upload WordPress files:
   • Download WordPress from wordpress.org
   • Extract the zip file
   • Upload all files to public_html
4. Or use "Softaculous" for one-click install''',
            Icons.upload_file,
          ),
          const SizedBox(height: 24),
          const Text('DigitalOcean Setup', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 16),
          _buildSection(
            'Creating a Droplet',
            '''DigitalOcean uses "Droplets" (virtual servers):

1. Log into DigitalOcean
2. Click "Create" → "Droplets"
3. Choose an image:
   • Select "Marketplace"
   • Search for "WordPress"
   • Choose "WordPress on Ubuntu"
4. Select a plan:
   • Basic: \$6/month is fine for small sites
   • Choose closest datacenter to your audience
5. Authentication:
   • SSH keys (recommended) or password
6. Click "Create Droplet"

Note the Droplet\'s IP address - you\'ll need it for DNS!''',
            Icons.add_box,
          ),
          _buildSection(
            'Connecting via SSH',
            '''Access your server\'s command line:

On Mac/Linux:
ssh root@your-droplet-ip

On Windows:
Use PuTTY or Windows Terminal:
ssh root@your-droplet-ip

First-time WordPress setup:
When you first connect, DigitalOcean\'s WordPress image will prompt you to:
• Set up your domain
• Configure SSL certificate
• Create admin credentials''',
            Icons.terminal,
          ),
          _buildSection(
            'Server Security Basics',
            '''Essential security steps for VPS:

1. Update your server
   apt update && apt upgrade -y

2. Create a non-root user
   adduser yourusername
   usermod -aG sudo yourusername

3. Set up firewall
   ufw allow OpenSSH
   ufw allow \'Nginx Full\'
   ufw enable

4. Disable root SSH login
   Edit /etc/ssh/sshd_config
   Set: PermitRootLogin no

5. Install fail2ban
   apt install fail2ban''',
            Icons.security,
          ),
          const SizedBox(height: 24),
          const Text('Managed Hosting', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 16),
          _buildSection(
            'WP Engine / Kinsta Setup',
            '''Managed hosts handle most technical details:

1. Create your account and site
2. Access your dashboard
3. Point your domain:
   • Find the IP address or CNAME in your dashboard
   • Update DNS at your registrar
4. Install SSL (usually automatic)
5. Access WordPress admin:
   • Usually at yourdomain.com/wp-admin
   • Credentials in your hosting dashboard

Benefits of managed hosting:
• Automatic WordPress updates
• Daily backups included
• Built-in caching
• Staging environments
• Expert WordPress support''',
            Icons.auto_awesome,
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
                const Icon(Icons.lightbulb, color: AppTheme.success, size: 28),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recommendation', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                      SizedBox(height: 4),
                      Text('New to WordPress? Start with cPanel shared hosting. It\'s the easiest to learn and most hosts offer one-click WordPress installation.', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
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
