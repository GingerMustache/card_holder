# Card Holder

A Flutter app for storing and managing loyalty and membership cards digitally.

## Features

### Card Management
- Store loyalty cards, membership cards, and discount cards locally
- Scan barcodes or enter codes manually
- Display barcodes for scanning at stores
- Organize cards with custom colors and logos
- Search and filter your card collection

### Sharing Options
- Share card as image (barcode screenshot)
- Share single card info as JSON file
- Share all cards collection as JSON file
- Import cards from JSON file

### Customization
- Light and dark theme support
- Brightness control for better barcode scanning
- Custom card colors and logos

## Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

- **Presentation**: Feature-based UI + state management with **BLoC** (`flutter_bloc`)
- **Domain**: Entities + repository contracts (`lib/domain`)
- **Data**: Models + local/remote data sources (`lib/data`)
- **Local persistence**: SQLite via **sqflite** (e.g. `LocalCardService`)
- **Networking**: HTTP via **Dio** with a shared request mixin + centralized exceptions
- **Navigation**: **go_router** routing configuration in `common/routing`
- **Dependency Injection**: Manual DI container (`common/di_container`)
- **Error handling**: Functional `Either<Exception, T>` via **dartz** (`safeCall` pattern)


## Project Structure

```
lib/
├── main.dart              # App entry point
├── common/                # Shared cross-cutting code (DI, routing, UI, services, etc.)
├── data/                  # Data layer (models + data sources)
│   ├── models/            # DTOs / API & persistence models
│   └── data_sources/      # Local/remote implementations
│       ├── local/
│       └── remote/
├── domain/                # Domain layer (entities + repository contracts)
│   ├── entities/
│   └── repositories/      # Repository interfaces (local/remote)
│       ├── local/
│       └── remote/
└── features/              # Feature modules (UI + state for each feature)
    ├── home/              # Card list and navigation
    ├── add_new_card/      # Add cards manually or from templates
    ├── open_card/         # View and edit card details
    └── settings/          # App settings and preferences
```
