# WP Launchpad - Development Journey

## The Story

WP Launchpad began as a solution to a common problem: self-hosting WordPress is powerful but intimidating. The vision was clear—build an installation assistant that generates configuration files and guides users through setup, not an automated deployment tool.

## AI-Assisted Development

This project was developed with AI coding assistants:

- **Gemini CLI** - Assisted with the initial version: scaffolding, authentication system, core screens, and basic functionality
- **Kiro (AWS)** - Assisted with completion and debugging: fixed authentication bugs, added user-specific projects, activity logging, modal displays, navigation flow, and deployment

## Phase 1: Foundation (Sessions 1-6)

Development started with Serverpod scaffolding. The project structure followed Serverpod conventions: `wp_launchpad_server` for backend, `wp_launchpad_flutter` for the web app, and `wp_launchpad_client` for generated API code.

The first major decision was authentication. Rather than traditional email/password, the app uses access tokens—admins generate tokens, users login with them. Simple, secure, no password management needed.

Initial screens were stubbed out following the user journey: Onboarding → Infrastructure → DNS → Provisioning → Verification. Each screen was a functional skeleton waiting for UI hydration.

## Phase 2: The Authentication Battle (Sessions 7-11)

Authentication became the biggest challenge. Serverpod's `FlutterAuthenticationKeyManager` automatically wraps tokens for Basic auth headers. But with custom token auth, this caused "Invalid basic token format" errors on every API call.

Six deployments later, the solution emerged: remove persistent storage entirely. Tokens live in memory only—`_sessionToken` variable, nothing in localStorage. All endpoints use `@unauthenticatedClientCall` with token validation in the request body, not headers.

This approach has security benefits: nothing to steal from browser storage, XSS attacks can't persist stolen tokens, sessions end when tabs close.

## Phase 3: UI Hydration (Sessions 8-10)

With auth working, focus shifted to UI. Reference designs guided the visual language—navy primary, orange accent, clean cards with subtle shadows.

The dashboard came first: welcome banner, quick actions, current project status. Then the deployment flow screens, each following a consistent pattern using the `WorkflowScreen` widget with hero cards, sidebars, and progress trackers.

Four documentation guides were written: Getting Started, DNS Setup, Hosting Guide, and WordPress Configuration. These aren't afterthoughts—they're core features helping users understand *why*, not just *how*.

## Phase 4: Core Features (Sessions 12-13)

The wp-config.php generator was the crown feature. A service generates cryptographically secure 64-character salts for all eight WordPress security keys. Users enter database credentials, toggle debug mode, set table prefix, and get a complete config file—preview it, copy it, or download it.

Provider-specific instructions required research. Five hosting types needed different commands: cPanel users need MySQL Databases panel instructions, DigitalOcean users need SSH and apt commands, AWS Lightsail users need static IP setup. Each provider got tailored step-by-step guides.

The projects system evolved from showing one project to fetching all from the server. `getAllProjects()` endpoint, `projectsListProvider` for state, proper loading/error handling, and refresh after create/delete.

## Phase 5: Polish (Session 14)

Step tracking was added—`currentStep` field in ProjectState, saved on each navigation, restored when loading projects. Users can leave mid-flow and return exactly where they stopped.

Progress tracker labels were standardized: Hosting → Server Setup → WP Config → Launch. Consistent across all screens.

Save & Exit buttons appeared on workflow screens. DNS propagation checker links to whatsmydns.net. The verification screen became an interactive checklist instead of a premature success message.

## The Migration Lesson

A critical lesson: `serverpod generate` creates Dart code, but `serverpod create-migration` creates database schema changes. Adding `serverIp` and `currentStep` fields without migration caused silent project creation failures. The fix was one command, but finding the cause took debugging.

## Technical Highlights

- **Flutter Web with WASM**: Required `web` package instead of `dart:html` for file downloads
- **Riverpod state management**: `StateNotifierProvider` for auth and projects, `FutureProvider` for async lists
- **PDF generation**: `printing` package for downloadable summary and technical reports
- **Type-safe API**: Serverpod generates client code from server endpoints automatically

## Final Architecture

```
wp_launchpad/
├── wp_launchpad_server/     # Serverpod backend
│   ├── lib/src/models/      # Data models (.spy.yaml)
│   ├── lib/src/auth/        # Token endpoints
│   ├── lib/src/projects/    # Project CRUD
│   └── migrations/          # Database migrations
├── wp_launchpad_flutter/    # Flutter web app
│   ├── lib/screens/         # UI screens
│   ├── lib/providers/       # Riverpod state
│   ├── lib/services/        # wp-config generation
│   └── lib/widgets/         # Reusable components
└── wp_launchpad_client/     # Generated API client
```

## Deployment

Serverpod Cloud handles hosting. `scloud deploy` uploads the project, builds it, runs migrations, and starts the service. Each deployment takes about 4 minutes from upload to running.

## What's Live

- Token-based authentication with auto-generated User IDs
- Multi-project management with persistence
- 5 hosting provider instruction sets
- wp-config.php generator with security salts
- Interactive verification checklist
- PDF report generation
- Comprehensive documentation guides

The app is live at https://wplaunchpad.serverpod.space/app/
