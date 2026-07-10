# Flutter UI Components Library

Professional, reusable **Flutter Material 3 UI Components Library** with responsive design, shared theme system, and showcase screens.

This repository is structured for practical interview review: clean folders, reusable widgets, and clear separation between core design system and UI feature demos.

## Architecture

The project follows a modular Flutter architecture with a reusable UI-first approach:

- **Core Layer**: Theme, colors, typography, responsive helpers, routing, constants, and utility classes.
- **Shared Layer**: Reusable widgets (buttons, text fields, cards, dialogs, loaders/states, navigation).
- **Feature Layer**: Presentation-focused showcase screens and category demos.
- **No business/domain coupling in UI library components**: Components are designed for reuse across screens.

## Features

- Material 3 based design system
- Light and Dark theme support
- Responsive spacing and layout utilities
- Reusable Button, TextField, Card, Dialog, Loading/State, and Navigation components
- Categorized UI Showcase screens
- Centralized routing with `go_router`

## Folder Structure

```text
lib/
├── core/
│   ├── config/
│   ├── services/
│   ├── theme/
│   └── utils/
├── shared/
│   └── widgets/
│       ├── app_button.dart
│       ├── app_text_field.dart
│       ├── app_card.dart
│       ├── app_dialog.dart
│       ├── app_loading_states.dart
│       ├── app_navigation.dart
│       └── app_widgets.dart
└── features/
    ├── ui_components_showcase/
    │   └── presentation/
    │       ├── screens/
    │       └── widgets/
    ├── authentication/
    ├── splash/
    ├── home/
    ├── profile/
    └── settings/
```

## Project Structure

- `main.dart`: App entrypoint and initialization.
- `core/services/app_router.dart`: Central route definitions.
- `core/theme/*`: Material 3 tokens and theme setup.
- `shared/widgets/*`: Reusable UI library widgets.
- `features/ui_components_showcase/*`: Category-based demos for interview visibility.

## Packages

Key dependencies used in this project:

- `provider` - State management
- `go_router` - Declarative routing
- `dio` - Networking support (legacy/optional for UI-only evolution)
- `shared_preferences` - Local persistence
- `connectivity_plus` - Connectivity state
- `equatable` - Value equality
- `logger` - Logging utilities
- `freezed_annotation`, `json_annotation` - Data modeling support

Dev dependencies:

- `flutter_lints`
- `build_runner`
- `freezed`
- `json_serializable`

## 📱 Screenshots

| Login | Register |
|-------|----------|
| ![](assets/screens/login.png) | ![](assets/screens/register.png) |

| Forgot Password | Splash |
|-----------------|---------|
| ![](assets/screens/forgot_password.png) | ![](assets/screens/splash.png) |

| Home | Showcase Home |
|------|---------------|
| ![](assets/screens/home.png) | ![](assets/screens/showcase_home.png) |

| Buttons | TextFields |
|---------|------------|
| ![](assets/screens/buttons_demo.png) | ![](assets/screens/textfields_demo.png) |

| Cards | Dialogs |
|-------|----------|
| ![](assets/screens/cards_demo.png) | ![](assets/screens/dialogs_demo.png) |

| Loaders | Navigation |
|---------|------------|
| ![](assets/screens/loaders_demo.png) | ![](assets/screens/navigation_demo.png) |

## How to Run

1. Clone the repository
2. Install dependencies
3. Run on emulator/device

```bash
git clone <your-repo-url>
cd flutter_ui_components
flutter pub get
flutter run
```

Optional checks:

```bash
flutter analyze
flutter test
```

## Future Improvements

- Add widget-level golden tests for reusable components
- Add component documentation pages per widget variant
- Add CI workflow for lint/test/format checks
- Add design token export/import pipeline
- Add package distribution support for private/internal pub registry

## License

This project is licensed under the **MIT License**.  
You can add a `LICENSE` file at the repository root if not present.

## Author

**Divya Dholariya**  
Email: `divyadholariya1@gmail.com`
