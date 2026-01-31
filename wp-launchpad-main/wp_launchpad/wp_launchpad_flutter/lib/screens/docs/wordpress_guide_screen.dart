import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class WordPressGuideScreen extends StatelessWidget {
  const WordPressGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Understanding wp-config.php', 
            'The wp-config.php file is WordPress\'s main configuration file. It contains your database credentials, security keys, and site settings. Never share this file publicly!',
            Icons.settings),
          _buildSection('Database Settings',
'''Your wp-config.php needs these database values:

DB_NAME - Your database name
DB_USER - Database username  
DB_PASSWORD - Database password
DB_HOST - Usually "localhost" for shared hosting

Example:
define(\'DB_NAME\', \'mysite_wp\');
define(\'DB_USER\', \'mysite_user\');
define(\'DB_PASSWORD\', \'your_password\');
define(\'DB_HOST\', \'localhost\');''',
            Icons.storage),
          _buildSection('Security Keys (Salts)',
'''Security keys encrypt your login cookies. Get unique keys from:
api.wordpress.org/secret-key/1.1/salt/

Never use the default keys! Each site should have unique salts. WP Launchpad generates these automatically for you.''',
            Icons.key),
          _buildSection('Table Prefix',
'''Change the default "wp_" prefix for better security:

\$table_prefix = \'mysite_\';

Use letters, numbers, and underscores only. This makes your database harder to target in SQL injection attacks.''',
            Icons.table_chart),
          _buildSection('First 5 Minutes Checklist',
'''After WordPress installs, do these immediately:

1. Delete "Hello World" post and sample page
2. Set permalinks: Settings → Permalinks → Post name
3. Update site title: Settings → General
4. Delete unused themes (keep one backup)
5. Install essential plugins:
   • Security: Wordfence or Sucuri
   • SEO: Yoast or RankMath
   • Caching: WP Super Cache or W3 Total Cache
   • Backup: UpdraftPlus''',
            Icons.checklist),
          _buildSection('Essential Security Steps',
'''Protect your WordPress site:

1. Use strong passwords (12+ characters)
2. Limit login attempts
3. Keep WordPress, themes, plugins updated
4. Use SSL/HTTPS (free with Let\'s Encrypt)
5. Disable file editing in wp-config:
   define(\'DISALLOW_FILE_EDIT\', true);
6. Regular backups (weekly minimum)''',
            Icons.shield),
          _buildSection('Performance Basics',
'''Speed up your WordPress site:

1. Use a caching plugin
2. Optimize images before uploading
3. Use a CDN for static files
4. Choose a fast, lightweight theme
5. Limit plugins to essentials only
6. Enable GZIP compression''',
            Icons.speed),
          const SizedBox(height: 24),
          _buildTipBox(),
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
          Row(children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: AppTheme.primaryNavy.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: AppTheme.primaryNavy, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.textMain))),
          ]),
          const SizedBox(height: 16),
          Text(content, style: const TextStyle(color: AppTheme.textMuted, height: 1.6, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTipBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.accentOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accentOrange.withOpacity(0.3)),
      ),
      child: Row(children: [
        const Icon(Icons.auto_awesome, color: AppTheme.accentOrange, size: 28),
        const SizedBox(width: 16),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Let Us Help', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          SizedBox(height: 4),
          Text('WP Launchpad generates your wp-config.php with secure settings automatically. Just follow the deployment flow!', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
        ])),
      ]),
    );
  }
}
