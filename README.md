## WP Launchpad

WP Launchpad guides you through setting up a self-hosted WordPress site. It doesn't deploy WordPress for you—it generates configuration files and provides step-by-step instructions tailored to your hosting provider.

## Features

- **Provider-specific guides** for cPanel, DigitalOcean, AWS Lightsail, managed hosting, and custom servers
- **wp-config.php generator** with secure salt generation
- **Progress tracking** - save and resume your setup anytime
- **Project management** - handle multiple WordPress installations
- **Documentation** - comprehensive guides for DNS, hosting, and WordPress configuration
- **PDF reports** - downloadable project summary and technical documentation

## Live Demo

**URL:** https://wplaunchpad.serverpod.space/app/

### Access Tokens

To use the app, you need an access token. Use one of these demo tokens:

| Token | User ID | Notes |
|-------|---------|-------|
| `6034fa61-3cc6-47b9-80d6-27dc205ee4f3` | WPL-2853FED8 | Demo account |
| `29c41063-f616-410b-bbd0-85b1f18f744f` | WPL-8D716B4B | Demo account |
| `3dc6c14b-8e73-498e-86e5-f42247ff9e07` | WPL-8F981E9A | Demo account |


## Tech Stack

- **Frontend:** Flutter Web (WASM)
- **Backend:** Serverpod
- **Database:** PostgreSQL
- **State Management:** Riverpod
- **Hosting:** Serverpod Cloud

## Project Structure

```
wp_launchpad/
├── wp_launchpad_server/     # Serverpod backend
├── wp_launchpad_flutter/    # Flutter web app
└── wp_launchpad_client/     # Generated API client
```

## Local Development

### Prerequisites

- Flutter SDK 3.38+
- Dart SDK 3.10+
- Docker (for local database)
- Serverpod CLI

### Setup

```bash
# Install Serverpod CLI
dart pub global activate serverpod_cli

# Start database
cd wp_launchpad/wp_launchpad_server
docker-compose up -d

# Generate code
serverpod generate

# Run server
dart run bin/main.dart

# Run Flutter app (in another terminal)
cd ../wp_launchpad_flutter
flutter run -d chrome
```

### Deployment

```bash
cd wp_launchpad/wp_launchpad_server

# Generate code
serverpod generate

# Create migration (if models changed)
serverpod create-migration

# Build Flutter web
cd ../wp_launchpad_flutter
flutter build web --base-href /app/ --wasm -o ../wp_launchpad_server/web/app

# Deploy
cd ../wp_launchpad_server
scloud deploy
```

## AI-Assisted Development

- **Gemini CLI** - Assisted with the initial version
- **Kiro (AWS)** - Assisted with completion and debugging

## License

MIT
