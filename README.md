# Card Holder
A Flutter app for storing and managing loyalty and membership cards digitally.

[![Download Latest Release](https://img.shields.io/github/v/release/GingerMustache/card_holder)](https://github.com/GingerMustache/card_holder/releases/latest)

<img width="180" alt="IMAGE 2026-04-25 18:52:45" src="https://github.com/user-attachments/assets/c11f2a8e-628e-4ca5-bd82-c6c793edd33d" />
<img width="180" alt="IMAGE 2026-04-25 18:53:37" src="https://github.com/user-attachments/assets/d9a71a0a-c4a3-4837-ab86-e26a7a07a607" />
<img width="180" alt="IMAGE 2026-04-25 18:54:09" src="https://github.com/user-attachments/assets/c52ba6cc-1ade-470c-af49-482b0aa40f50" />
<img width="180" alt="IMAGE 2026-04-25 18:54:42" src="https://github.com/user-attachments/assets/63b06f08-bb4c-4bb9-9317-3b13005c0853" />
<img width="180" alt="IMAGE 2026-04-25 18:55:19" src="https://github.com/user-attachments/assets/5463f682-a38b-435e-a4b1-e46e7faa7c48" />
<img width="180" alt="IMAGE 2026-04-25 18:57:24" src="https://github.com/user-attachments/assets/d6fb5f00-0923-4eb2-8131-0192cb82d315" />
<img width="180" alt="IMAGE 2026-04-25 18:55:48" src="https://github.com/user-attachments/assets/c06dae8b-01db-40c9-af0d-c30697815d5e" />
<img width="180" alt="IMAGE 2026-04-25 18:56:39" src="https://github.com/user-attachments/assets/1dd7e8bb-d4aa-42d5-867a-06b38e09c07d" />


## Features

### Card Management
- Store loyalty cards, membership cards, and discount cards locally
- Scan barcodes, qr codes or enter codes manually
- Display barcodes or qr codes for scanning at stores
- Organize cards with custom colors and logos
- Search and filter your card collection

### Sharing Options
- Share card as image (barcode screenshot)
- Share single card info as JSON file
- Share all cards collection as JSON file
- Import cards from JSON file

### Customization
- Light and dark theme support
- Brightness control for better scanning
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
