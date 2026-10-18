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

## UI tests (Maestro)

Flows live in `.maestro/`. The current flows launch the Android app `com.example.card_holder`. Run every command from the project root.

Maestro needs Java 17 or newer (`java -version`) and the CLI on your `PATH` (`maestro --version`). Install the CLI with:

```bash
curl -fsSL "https://get.maestro.mobile.dev" | bash
```

Install the app on the device before a flow. `launchApp` starts the already installed package; it does not build it.

```bash
flutter run
```

### Connect a device

Boot an Android emulator or iOS Simulator, then list what Maestro can see:

```bash
maestro list-devices
```

A booted device shows as connected. Maestro uses it automatically when you run a flow. There is no separate connect command.

When more than one device is connected, pass its id from `list-devices`:

```bash
maestro --device emulator-5554 test .maestro/open_first_card.yaml
```

Create and boot a device from the CLI when you do not already have one running:

```bash
maestro start-device --platform android
maestro start-device --platform ios
```

### Run tests

One flow:

```bash
maestro test .maestro/open_first_card.yaml
```

Every flow listed in `.maestro/config.yaml`. Helpers under `.maestro/subflows/` are called by those flows and are not run on their own. Add a new flow to that list when you create one:

```bash
maestro test .maestro
```

A few specific flows, instead of the whole folder:

```bash
maestro test .maestro/open_first_card.yaml .maestro/another_flow.yaml
```

Only flows tagged `smoke` (see the `tags` block at the top of a flow):

```bash
maestro test --include-tags=smoke .maestro
```

Re-run the same flow whenever the file changes:

```bash
maestro test --continuous .maestro/open_first_card.yaml
```

### Other useful commands

```bash
maestro check-syntax .maestro/open_first_card.yaml   # validate a flow without running it
maestro hierarchy                                     # print the current screen's view hierarchy
maestro test --verbose .maestro/open_first_card.yaml  # extra logs when a step fails
maestro record --local .maestro/open_first_card.yaml open_first_card.mp4
maestro --help
maestro test --help
```

`hierarchy` is how you find the text Maestro can tap. Selectors match the full accessibility text, so copy the string from that output.

Command reference: [Maestro CLI commands and options](https://docs.maestro.dev/maestro-cli/maestro-cli-commands-and-options).
