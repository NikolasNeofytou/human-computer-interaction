# Project Progress (Flutter Scaffold)

## Completed
- Scaffolded Flutter app (`taskflow`) with `MaterialApp.router`, go_router shell, and bottom navigation tabs (Requests, Notifications, Calendar, Projects, Profile).
- Added design system tokens (colors, spacing, radii, shadows, typography) and wired a light theme with Inter via `google_fonts`.
- Implemented feature screens reflecting the Figma flows with Riverpod-backed mock data and states (loading/empty/error).
- Set up core dependencies: riverpod, go_router, dio, secure storage, intl, freezed/json tooling, google_fonts.
- CI sanity: `flutter analyze` and `flutter test` pass locally.
- Added domain models and mock providers; project detail screen with task list; task form (create/edit) routes and navigation from projects.
- Added request/notification detail routes, request send modal, invite dialog (QR/link), and chat stub route.

## Next Up
- Start extracting shared UI components (cards, tags, pills) into a design-system folder and add widget/golden tests.
- Wire data layer (dio + interceptors) and analytics hooks; expand tests and accessibility labels.
