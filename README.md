## WP Launchpad

WP Launchpad guides you through setting up a self-hosted WordPress site. It generates configuration files and provides step-by-step instructions tailored to your hosting provider.

## Features

- **Provider-specific guides** for cPanel, DigitalOcean, AWS Lightsail, managed hosting, and custom servers
- **wp-config.php generator** with secure salt generation
- **Progress tracking** - save and resume your setup anytime
- **Project management** - handle multiple WordPress installations
- **Documentation** - comprehensive guides for DNS, hosting, and WordPress configuration
- **PDF reports** - downloadable project summary and technical documentation


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
