import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web/web.dart' as web;
import '../widgets/workflow_screen.dart';
import '../widgets/hero_card.dart';
import '../widgets/sidebar_card.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/nav_buttons.dart';
import '../widgets/step_detail.dart';
import '../widgets/command_block.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../providers/project_provider.dart';
import 'app_shell.dart';

class DnsScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const DnsScreen({super.key, required this.onNext, required this.onBack});

  @override
  ConsumerState<DnsScreen> createState() => _DnsScreenState();
}

class _DnsScreenState extends ConsumerState<DnsScreen> {
  final _domainController = TextEditingController();
  final _serverIpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final p = ref.read(projectProvider);
    _domainController.text = p?.domain ?? '';
    _serverIpController.text = p?.serverIp ?? '';
  }

  @override
  void dispose() {
    _domainController.dispose();
    _serverIpController.dispose();
    super.dispose();
  }

  String get _provider => ref.read(projectProvider)?.hostingProvider ?? 'custom';
  String get _providerName => _getProviderName(_provider);
  String get _domain => _domainController.text.isNotEmpty ? _domainController.text : 'yourdomain.com';
  String get _ip => _serverIpController.text.isNotEmpty ? _serverIpController.text : 'YOUR_SERVER_IP';

  String _getProviderName(String p) {
    switch (p) {
      case 'cpanel': return 'cPanel';
      case 'digitalocean': return 'DigitalOcean';
      case 'aws': return 'AWS Lightsail';
      case 'managed': return 'Managed Hosting';
      default: return 'Your Server';
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = ref.watch(projectProvider);
    final provider = p?.hostingProvider ?? 'custom';

    return WorkflowScreen(
      heroCard: HeroCard(
        title: 'Server Setup for $_providerName',
        description: 'Follow these steps to prepare your server and configure DNS for ${p?.domain ?? "your domain"}.',
        icon: Icons.dns,
      ),
      sidebarCard: SidebarCard(
        title: 'Need Help?',
        description: 'View our $_providerName setup guide for detailed instructions.',
        buttonText: '$_providerName Guide',
        onButtonPressed: () => ref.read(navigationProvider.notifier).setStep(WorkflowStep.support),
      ),
      mainContent: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Domain & IP inputs
        Row(children: [
          Expanded(child: _inputField('Domain Name', _domainController, 'example.com', (v) {
            ref.read(projectProvider.notifier).updateField(domain: v);
            setState(() {});
          })),
          const SizedBox(width: 16),
          Expanded(child: _inputField('Server IP Address', _serverIpController, '192.168.1.1', (v) {
            ref.read(projectProvider.notifier).updateField(serverIp: v);
            setState(() {});
          })),
        ]),
        const SizedBox(height: 16),
        // DNS Check hint
        if (_domainController.text.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppTheme.primaryNavy.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              const FaIcon(FontAwesomeIcons.globe, size: 14, color: AppTheme.primaryNavy),
              const SizedBox(width: 10),
              Expanded(child: Text('Check DNS propagation at: whatsmydns.net/#A/${_domainController.text}', style: const TextStyle(fontSize: 12, color: AppTheme.textMuted))),
              TextButton(
                onPressed: () {
                  final url = 'https://whatsmydns.net/#A/${_domainController.text}';
                  // Open in new tab
                  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
                  anchor.href = url;
                  anchor.target = '_blank';
                  anchor.click();
                },
                child: const Text('Check Now', style: TextStyle(fontSize: 12)),
              ),
            ]),
          ),
        const SizedBox(height: 32),

        // Provider-specific instructions
        if (provider == 'cpanel') ..._cpanelInstructions(),
        if (provider == 'digitalocean') ..._digitalOceanInstructions(),
        if (provider == 'aws') ..._awsInstructions(),
        if (provider == 'managed') ..._managedInstructions(),
        if (provider == 'custom') ..._customInstructions(),
      ]),
      progressTracker: ProgressTracker(steps: buildProgressSteps(1)),
      navButtons: NavButtons(
        onBack: widget.onBack,
        onNext: _domainController.text.isNotEmpty ? widget.onNext : null,
        onSave: () {
          ref.read(appTabProvider.notifier).state = AppTab.dashboard;
        },
      ),
    );
  }

  Widget _inputField(String label, TextEditingController ctrl, String hint, ValueChanged<String> onChange) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain)),
      const SizedBox(height: 8),
      TextFormField(
        controller: ctrl,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.borderGray)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.borderGray)),
        ),
      ),
    ]);
  }

  Widget _step(String num, String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: StepDetail(number: num, title: title, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children)),
    );
  }

  Widget _cmd(String command, [String? label]) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CommandBlock(command: command, label: label),
    );
  }

  Widget _tip(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppTheme.accentOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        const FaIcon(FontAwesomeIcons.lightbulb, size: 14, color: AppTheme.accentOrange),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted))),
      ]),
    );
  }

  // ===== cPanel Instructions =====
  List<Widget> _cpanelInstructions() => [
    _step('1', 'Access cPanel', [
      const Text('Log into your hosting account and open cPanel. Usually at:'),
      _cmd('https://$_domain:2083'),
      _tip('Your login credentials were sent in your hosting welcome email.'),
    ]),
    _step('2', 'Point Your Domain (DNS)', [
      const Text('In your domain registrar, add an A record:'),
      _cmd('Type: A\nHost: @\nValue: $_ip\nTTL: 3600'),
      const SizedBox(height: 8),
      const Text('For www subdomain, add another A record:'),
      _cmd('Type: A\nHost: www\nValue: $_ip'),
    ]),
    _step('3', 'Create MySQL Database', [
      const Text('In cPanel, go to "MySQL Databases" and create:'),
      const Text('• A new database\n• A new user with strong password\n• Add user to database with ALL PRIVILEGES', style: TextStyle(height: 1.6)),
      _tip('Save these credentials - you\'ll need them for wp-config.php'),
    ]),
    _step('4', 'Upload WordPress', [
      const Text('Download WordPress from wordpress.org and upload via File Manager to public_html, or use Softaculous for one-click install.'),
    ]),
  ];

  // ===== DigitalOcean Instructions =====
  List<Widget> _digitalOceanInstructions() => [
    _step('1', 'SSH into Your Droplet', [
      const Text('Connect to your server via SSH:'),
      _cmd('ssh root@$_ip'),
      _tip('Find your Droplet IP in the DigitalOcean dashboard.'),
    ]),
    _step('2', 'Update System Packages', [
      const Text('Update your server packages:'),
      _cmd('apt update && apt upgrade -y'),
    ]),
    _step('3', 'Install LAMP Stack', [
      const Text('Install Apache, MySQL, and PHP:'),
      _cmd('apt install apache2 mysql-server php php-mysql libapache2-mod-php php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc -y'),
    ]),
    _step('4', 'Secure MySQL', [
      const Text('Run the security script:'),
      _cmd('mysql_secure_installation'),
    ]),
    _step('5', 'Create Database', [
      const Text('Create WordPress database and user:'),
      _cmd("mysql -u root -p\nCREATE DATABASE wordpress;\nCREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'your_password';\nGRANT ALL ON wordpress.* TO 'wpuser'@'localhost';\nFLUSH PRIVILEGES;\nEXIT;"),
    ]),
    _step('6', 'Download WordPress', [
      const Text('Download and extract WordPress:'),
      _cmd('cd /var/www/html\nwget https://wordpress.org/latest.tar.gz\ntar -xzf latest.tar.gz\nmv wordpress/* .\nrm -rf wordpress latest.tar.gz\nchown -R www-data:www-data /var/www/html'),
    ]),
    _step('7', 'Configure DNS', [
      const Text('In your domain registrar, add A record:'),
      _cmd('Type: A\nHost: @\nValue: $_ip'),
    ]),
  ];

  // ===== AWS Lightsail Instructions =====
  List<Widget> _awsInstructions() => [
    _step('1', 'Connect via SSH', [
      const Text('Use the browser-based SSH or your terminal:'),
      _cmd('ssh -i your-key.pem ubuntu@$_ip'),
      _tip('Download your SSH key from Lightsail console.'),
    ]),
    _step('2', 'Update System', [
      _cmd('sudo apt update && sudo apt upgrade -y'),
    ]),
    _step('3', 'Install LAMP Stack', [
      _cmd('sudo apt install apache2 mysql-server php php-mysql libapache2-mod-php php-cli php-curl php-gd php-mbstring php-xml -y'),
    ]),
    _step('4', 'Create Database', [
      _cmd("sudo mysql\nCREATE DATABASE wordpress;\nCREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'your_password';\nGRANT ALL ON wordpress.* TO 'wpuser'@'localhost';\nEXIT;"),
    ]),
    _step('5', 'Download WordPress', [
      _cmd('cd /var/www/html\nsudo wget https://wordpress.org/latest.tar.gz\nsudo tar -xzf latest.tar.gz\nsudo mv wordpress/* .\nsudo chown -R www-data:www-data /var/www/html'),
    ]),
    _step('6', 'Attach Static IP', [
      const Text('In Lightsail console:\n1. Go to Networking tab\n2. Create static IP\n3. Attach to your instance'),
    ]),
    _step('7', 'Configure DNS', [
      const Text('Add A record pointing to your static IP:'),
      _cmd('Type: A\nHost: @\nValue: $_ip'),
    ]),
  ];

  // ===== Managed Hosting Instructions =====
  List<Widget> _managedInstructions() => [
    _step('1', 'Access Your Dashboard', [
      const Text('Log into your managed hosting dashboard (WP Engine, Kinsta, Flywheel, etc.)'),
      _tip('WordPress is usually pre-installed on managed hosts.'),
    ]),
    _step('2', 'Get Your Site IP/CNAME', [
      const Text('Find the IP address or CNAME record in your hosting dashboard under DNS or Domain settings.'),
    ]),
    _step('3', 'Configure DNS', [
      const Text('In your domain registrar, add the record provided by your host:'),
      _cmd('Type: A or CNAME\nHost: @\nValue: [from your host dashboard]'),
    ]),
    _step('4', 'Verify Domain', [
      const Text('Most managed hosts have a "Verify Domain" button. Click it after DNS propagates (15 min - 48 hours).'),
    ]),
    _step('5', 'Enable SSL', [
      const Text('Enable free SSL/HTTPS in your hosting dashboard. Most managed hosts do this automatically.'),
    ]),
  ];

  // ===== Custom Server Instructions =====
  List<Widget> _customInstructions() => [
    _step('1', 'Connect to Your Server', [
      _cmd('ssh root@$_ip'),
    ]),
    _step('2', 'Install Web Server', [
      const Text('Install Apache or Nginx:'),
      _cmd('# Apache\napt install apache2 -y\n\n# Or Nginx\napt install nginx -y'),
    ]),
    _step('3', 'Install PHP', [
      _cmd('apt install php php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc -y'),
    ]),
    _step('4', 'Install MySQL', [
      _cmd('apt install mysql-server -y\nmysql_secure_installation'),
    ]),
    _step('5', 'Create Database', [
      _cmd("mysql -u root -p\nCREATE DATABASE wordpress;\nCREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';\nGRANT ALL ON wordpress.* TO 'wpuser'@'localhost';\nEXIT;"),
    ]),
    _step('6', 'Download WordPress', [
      _cmd('cd /var/www/html\nwget https://wordpress.org/latest.tar.gz\ntar -xzf latest.tar.gz\nmv wordpress/* .\nchown -R www-data:www-data .'),
    ]),
    _step('7', 'Configure DNS', [
      _cmd('Type: A\nHost: @\nValue: $_ip'),
    ]),
  ];
}
