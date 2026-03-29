# Fluxify - Social Discovery & Advertising Marketplace

A Flutter application built with GetX state management, featuring a social discovery platform with advertising marketplace capabilities.

## Tech Stack

- **Frontend**: Flutter with GetX for State Management and Navigation
- **Backend**: Django Rest Framework (DRF) with PostgreSQL
- **Payments**: Razorpay (Indian market optimized) with Split-Payment mechanism

## Project Structure

The project follows a **feature-first modular architecture**:

```
lib/
├── app/
│   ├── modules/           # Feature-based modules
│   │   ├── auth/         # Authentication module
│   │   ├── home/         # Home feed module
│   │   ├── booking/      # Booking module
│   │   └── chat/         # Chat module
│   ├── data/             # Data layer
│   │   ├── models/       # Data models
│   │   ├── providers/    # API providers
│   │   └── services/     # Business logic services
│   └── routes/           # App routing
├── core/                 # Core application components
│   ├── theme/           # App theme and colors
│   ├── values/          # Global constants and values
│   └── widgets/         # Shared widgets
│       ├── assets/      # Asset-related widgets
│       └── social/      # Social-related widgets
└── main.dart            # App entry point
```

## UI/UX Design Strategy

### Brilliant Method Implementation

1. **Fixed Aspect Ratios**: 
   - Asset listings use `16:9` aspect ratio
   - Social posts use `1:1` aspect ratio
   - Prevents layout jumping during image loading

2. **Relative Scaling**: 
   - No hardcoded pixel widths for main components
   - Uses `Get.width * ratio` (e.g., `0.9` for inputs)
   - Ensures consistency across all phone sizes

3. **Shared Widgets**:
   - `FluxifyInput` widget with Email/Phone and OTP modes
   - `12.0` border radius with custom border styling
   - Consistent design system across the app

4. **Discovery-First UX**:
   - Home feed handles mixed content (Asset listings + Social posts)
   - Smooth infinite scrolling implementation

## Key Components

### FluxifyInput Widget
A versatile input component that supports:
- Email/Phone input mode with validation
- OTP input mode with 6-digit formatting
- Responsive design with relative scaling
- Custom styling with 12.0 border radius
- Focus states and validation feedback

### Authentication Module
Complete authentication flow with:
- Email/Phone number validation
- OTP verification with timer
- Social login integration (Google)
- Form validation and error handling
- Responsive UI design

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- GetX package
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd fluxify
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Development Setup

1. Set up your development environment
2. Configure environment variables for API endpoints
3. Set up Razorpay credentials (for payments)
4. Run the app on emulator or device

## Dependencies

Key dependencies include:
- `get`: State management and navigation
- `flutter_screenutil`: Responsive design utilities
- `dio`: HTTP client for API calls
- `razorpay_flutter`: Payment integration
- `cached_network_image`: Image caching
- `shared_preferences`: Local storage

## Architecture Principles

1. **Feature-First Structure**: Each feature is a self-contained module
2. **Dependency Injection**: Using GetX bindings for DI
3. **Reactive Programming**: GetX observables for state management
4. **Responsive Design**: Relative scaling for all screen sizes
5. **Clean Architecture**: Separation of concerns with layers

## Contributing

1. Follow the established project structure
2. Use the FluxifyInput widget for all form inputs
3. Maintain the aspect ratio guidelines for media
4. Use relative scaling for responsive design
5. Follow GetX patterns for state management

## License

This project is proprietary and confidential.

---

**Note**: The lint errors shown in the IDE are expected until `flutter pub get` is run to install all dependencies.
