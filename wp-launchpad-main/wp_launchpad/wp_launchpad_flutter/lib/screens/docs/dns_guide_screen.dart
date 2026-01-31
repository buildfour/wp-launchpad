import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DnsGuideScreen extends StatelessWidget {
  const DnsGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'What is DNS?',
            '''DNS (Domain Name System) is like the internet\'s phone book. It translates human-readable domain names (like yourdomain.com) into IP addresses that computers use to identify each other.

When someone types your domain into their browser, DNS tells them which server to connect to.''',
            Icons.menu_book,
          ),
          _buildSection(
            'Common DNS Record Types',
            '''A Record
Points your domain to an IPv4 address (e.g., 192.168.1.1)
Use this to connect your domain to your hosting server.

AAAA Record
Points your domain to an IPv6 address
Similar to A record but for newer IP format.

CNAME Record
Creates an alias pointing to another domain
Often used for subdomains like www.yourdomain.com

MX Record
Directs email to your mail server
Required if you want email@yourdomain.com

TXT Record
Stores text information
Used for verification and security (SPF, DKIM)''',
            Icons.list_alt,
          ),
          _buildSection(
            'Finding Your DNS Settings',
            '''Your DNS settings are managed at your domain registrar - where you bought your domain.

Common Registrars:
• GoDaddy: Domains → DNS Management
• Namecheap: Domain List → Manage → Advanced DNS
• Google Domains: DNS → Manage custom records
• Cloudflare: DNS → Records

Look for "DNS Management", "Name Servers", or "DNS Records" in your registrar\'s dashboard.''',
            Icons.search,
          ),
          _buildSection(
            'Adding an A Record',
            '''Step-by-step instructions:

1. Log into your domain registrar
2. Navigate to DNS settings for your domain
3. Click "Add Record" or "Add New"
4. Select record type: A
5. Enter the following:
   • Host/Name: @ (or leave blank for root domain)
   • Value/Points to: Your server\'s IP address
   • TTL: 3600 (or "1 hour")
6. Save the record

For www subdomain, add another A record:
   • Host/Name: www
   • Value: Same IP address''',
            Icons.add_circle,
          ),
          _buildSection(
            'DNS Propagation',
            '''After making DNS changes, they need time to spread across the internet. This is called propagation.

Typical propagation times:
• Same ISP: 15 minutes - 2 hours
• Different regions: 2-12 hours  
• Worldwide: Up to 48 hours

During propagation:
• Some users may see the old site
• Others may see the new site
• This is normal and temporary

Tips to speed up:
• Lower TTL before making changes
• Clear your browser cache
• Try a different browser or device''',
            Icons.timer,
          ),
          _buildSection(
            'Verifying DNS Changes',
            '''Use these methods to check if DNS is working:

1. WP Launchpad DNS Checker
   Our built-in tool shows current DNS values and propagation status.

2. Online Tools
   • whatsmydns.net - Check propagation globally
   • dnschecker.org - Multiple location checks
   • mxtoolbox.com - Comprehensive DNS lookup

3. Command Line (Advanced)
   • Windows: nslookup yourdomain.com
   • Mac/Linux: dig yourdomain.com

What to look for:
• A record shows your server\'s IP
• No errors or "NXDOMAIN" messages''',
            Icons.verified,
          ),
          _buildSection(
            'Troubleshooting',
            '''DNS not working? Try these fixes:

"Site not found" error
• DNS hasn\'t propagated yet - wait longer
• Check A record points to correct IP
• Verify domain hasn\'t expired

"Wrong site showing"
• Clear browser cache (Ctrl+Shift+Delete)
• Try incognito/private browsing
• Flush local DNS cache

Still having issues?
• Contact your registrar\'s support
• Verify nameservers are correct
• Check for typos in DNS records''',
            Icons.build,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.warning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber, color: AppTheme.warning, size: 28),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Important', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                      SizedBox(height: 4),
                      Text('Never delete existing DNS records unless you\'re sure. Wrong DNS settings can make your website and email inaccessible.', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
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
