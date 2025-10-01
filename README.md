# FamPay Contextual Cards Project

A Flutter application that implements a dynamic card-based UI system with multiple card types and layouts. The app follows clean architecture principles and implements modern Flutter development practices.

## Demo

https://github.com/user-attachments/assets/4a3dfd42-821b-4a8c-8fbf-f634ef3df016

_App demonstration showing different card types and interactions_

## Features

- **Dynamic Card System**: Supports multiple card types (HC1, HC3, HC5, HC6, HC9)
- **Responsive Layouts**: Both scrollable and non-scrollable card layouts
- **Rich Text Formatting**: Custom text formatting with entities support
- **Image Handling**: Efficient image loading with caching
- **Deep Linking**: URL handling for card interactions
- **State Management**: BLoC pattern implementation
- **Clean Architecture**: Separation of concerns with proper folder structure

## Card Types

### HC1 Small Display Card

- Fixed height layout
- Icon support
- Formatted title and description
- Adaptive width based on scroll state

### HC3 Big Display Card

- Large format card
- Rich text formatting
- Multiple entity support with custom styling

### HC5 Image Card

- Image-based card
- Background color/gradient support

### HC6 Small Arrow Card

- Compact layout with arrow indicator
- Icon and title display

### HC9 Dynamic Width Card

- Aspect ratio based width calculation
- Background image support
- Gradient overlay options

## Project Structure

```
lib/
├── core/                           # Core functionality and utilities
│   ├── di/                        # Dependency injection
│   │   └── injection.dart         # Service locator setup
│   ├── logger/                    # Logging utilities
│   │   └── app_logger.dart        # Custom logger implementation
│   └── utils/                     # Common utilities
│       ├── color_utils.dart       # Color parsing and gradient utilities
│       ├── deeplink_handler.dart  # URL and deeplink handling
│       └── text_style_utils.dart  # Text styling utilities
│
├── features/
│   └── contextual_cards/          # Main feature module
│       ├── data/
│       │   ├── models/            # Data models
│       │   │   ├── api_model.dart # API response models
│       │   │   └── card_model.dart # Card-specific models
│       │   └── repositories/      # Data repositories
│       │       └── card_repository.dart
│       │
│       └── presentation/
│           ├── cubits/            # State management
│           │   ├── card_state.dart
│           │   └── card_cubits.dart
│           │
│           ├── pages/             # Screen layouts
│           │   └── mainpage.dart  # Main screen implementation
│           │
│           └── widgets/          # Reusable components
│               ├── card_types/   # Individual card implementations
│               │   ├── hc1_card.dart  # Small display card
│               │   ├── hc3_card.dart  # Big display card
│               │   ├── hc5_card.dart  # Image card
│               │   ├── hc6_card.dart  # Small arrow card
│               │   └── hc9_card.dart  # Dynamic width card
│               │
│               ├── card_group_widget.dart    # Card group container
│               ├── contextual_card.dart      # Main card container
│               └── formatted_text_widget.dart # Rich text formatting
│
└── main.dart                      # Application entry point

assets/
├── images/                        # Image assets
│   └── fampaylogo.svg            # App logo
│
test/                             # Test directory
├── widget_test.dart              # Widget tests
└── unit/                         # Unit tests
    └── card_test.dart            # Card-related tests

pubspec.yaml                      # Project configuration and dependencies
.env                             # Environment variables
```

### Key Components Description

#### Core Layer

- **DI**: Handles dependency injection using GetIt
- **Logger**: Custom logging implementation for debugging
- **Utils**: Shared utilities for color parsing, URL handling, and text styling

#### Feature Layer (Contextual Cards)

- **Data**:

  - Models for API responses and card configurations
  - Repository implementation for data handling

- **Presentation**:
  - **Cubits**: BLoC pattern implementation for state management
  - **Pages**: Main screen and layout implementations
  - **Widgets**:
    - Specialized card type implementations (HC1-HC9)
    - Support widgets for card grouping and formatting

#### Widget Hierarchy

1. `ContextualCardsContainer` (Root widget)
2. `CardGroupWidget` (Groups similar cards)
3. Individual card type widgets (HC1, HC3, etc.)
4. Support widgets (FormattedTextWidget, etc.)

## Technical Implementation

### State Management

- Uses Flutter BLoC for state management
- Implements cubits for card visibility control

### Styling

- Dynamic color parsing
- Gradient support
- Custom text styling with entity support

### Image Handling

- Cached network image implementation
- Placeholder and error states
- Background image support with aspect ratio preservation

## Setup and Installation

1. **Prerequisites**

   - Flutter SDK (3.8.1 or higher)
   - Dart SDK
   - Android Studio / VS Code

2. **Installation**

   ```bash
   git clone https://github.com/Sudheesh-07/FamProject.git
   cd famproject
   flutter pub get
   ```

3. **Environment Setup**

   - Create a `.env` file in the root directory
   - Add necessary environment variables

4. **Running the App**
   ```bash
   flutter run
   ```

## Dependencies

- `flutter_bloc`: State management
- `dio`: Network requests
- `hive`: Local storage
- `cached_network_image`: Image caching
- `url_launcher`: URL handling
- `get_it`: Dependency injection
- `equatable`: Value comparison
- `logger`: Logging

## Development Guidelines

### Card Implementation

- Each card type has its own widget class
- Cards must implement proper error handling
- Use cached images for better performance

### Testing

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for full features

## Building for Release

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```
