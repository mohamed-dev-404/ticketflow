<div align="center">

<img src="assets\icons\luncher_icon.png" alt="TicketFlow Launcher" width="30%"/>

<br/>

# TicketFlow

### Help Desk Ticketing System

_A clean, offline Flutter app for creating, tracking, and managing support tickets end-to-end._

<p align="center">

![License](https://img.shields.io/badge/License-All%20Rights%20Reserved-red?style=for-the-badge)

</p>

---

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![BLoC](https://img.shields.io/badge/State_Management-BLoC-blue?style=for-the-badge)](https://bloclibrary.dev/)
[![Feature--First](https://img.shields.io/badge/Pattern-Feature--First-ff69b4?style=for-the-badge)](https://docs.flutter.dev/app-architecture/guide)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge&logo=flutter)](https://flutter.dev/multi-platform)
<a href="https://pub.dev/packages/get_it">
<img src="https://img.shields.io/badge/DI-GetIt-4CAF50?style=for-the-badge" alt="GetIt DI"/>
</a>
<a href="https://pub.dev/packages/go_router">
<img src="https://img.shields.io/badge/Routing-go__router-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="go_router"/>
</a>

<p align="center">
  <img src="https://img.shields.io/github/stars/mohamed-dev-404/ticketflow?style=for-the-badge&logo=github&color=DAA520" alt="Stars" />
  <img src="https://img.shields.io/github/forks/mohamed-dev-404/ticketflow?style=for-the-badge&logo=github&color=E67E22" alt="Forks" />
  <img src="https://img.shields.io/github/issues/mohamed-dev-404/ticketflow?style=for-the-badge&logo=github&color=E74C3C" alt="Issues" />
  <img src="https://img.shields.io/github/issues-closed/mohamed-dev-404/ticketflow?style=for-the-badge&logo=github&color=6F42C1" alt="Closed Issues" />
  <img src="https://img.shields.io/github/issues-pr-closed/mohamed-dev-404/ticketflow?style=for-the-badge&logo=github&color=008080" alt="Closed PRs" />
</p>
<a href="https://github.com/mohamed-dev-404/ticketflow">
  <img src="https://dynamic-repo-badges.vercel.app/svg/count/2/Repository%20Views/mohamed-dev-404-ticketflow" alt="Repository Views" />
</a>

<br/>

<p align="center">
  <a href="https://drive.google.com/drive/folders/1EShLTK-rYAEghM-JHcTCE3k5reeTvv2x?usp=sharing">
    <img src="https://img.shields.io/badge/📱_Download-APK-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Download APK"/>
  </a>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://drive.google.com/drive/folders/1z9UGgeslCXRJI6q9VkoQCY14u5di2xTM?usp=sharing">
    <img src="https://img.shields.io/badge/🎬_Watch-Demo-6C5CE7?style=for-the-badge&logoColor=white" alt="Watch Demo"/>
  </a>
</p>

</div>

---

## 📋 Table of Contents

<br>

**🔷 Overview**

|     | Section                                 |               |
| :-: | :-------------------------------------- | :------------ |
| 📖  | [About the Project](#about-the-project) | `Overview`    |
| ✨  | [Core Features](#core-features)         | `Highlights`  |
| 🎬  | [Demo](#demo)                           | `Walkthrough` |

<br>

**⚙️ Technical**

|     | Section                                               |                        |
| :-: | :------------------------------------------------------ | :--------------------- |
| 🏗  | [Architecture Overview](#architecture-overview)         | `Feature-First · Cubit` |
| 📁  | [Project Structure](#project-structure)                 | `lib/ tree`             |
|  ⚒  | [Tech Stack & Dependencies](#tech-stack-dependencies)   | `Packages & Plugins`    |
| 🚀  | [Setup Instructions](#setup-instructions)               | `Getting Started`       |
| ⚠️  | [Assumptions & Limitations](#assumptions-limitations)  | `Notes`                 |

<br>

**📦 Resources**

|     | Section                     |                       |
| :-: | :--------------------------- | :-------------------- |
| 📄  | [License](#license)         | `All Rights Reserved` |

---

<h2 id="about-the-project">📖 About the Project</h2>

**TicketFlow** is a mobile Help Desk Ticketing System built as a Flutter technical assessment project. It allows a user to create, browse, search, and manage support tickets from end to end — starting from a dashboard summarizing ticket statistics, down to full detail, edit, and delete operations on individual tickets.

Every ticket carries a subject, description, priority (Low / Medium / High), category (Technical / Billing / General), and status (Open / In Progress / Closed). All data is persisted on-device, so nothing is lost when the app is closed and reopened.

The project was built to demonstrate:

- A scalable, feature-first project structure with clear separation of concerns
- Predictable state management using Cubit
- Type-safe error handling and offline-first local persistence
- A consistent, reusable design system across screens

---

<h2 id="core-features">✨ Core Features</h2>

### 📊 Dashboard

- Live summary cards: Total, Open, In Progress, and Closed tickets, computed from local storage

### 🎫 Ticket List & Discovery

- Full ticket list showing ID, subject, priority, status, and created date
- Debounced search by subject
- Filter by status
- Sort by created date

### ➕ Ticket Creation

- Required Subject & Description fields with friendly validation errors
- Priority selector: Low / Medium / High
- Category selector: Technical / Billing / General
- Auto-generated ticket number, creation date, and initial status (`Open`)

### 🛠 Ticket Details & Management

- Full ticket detail view
- Change status (Open → In Progress → Closed)
- Edit subject, description, and priority
- Delete ticket with a confirmation dialog

### 💾 Persistence & UX

- Offline-first local storage via Hive CE — data survives app restarts
- Proper loading, empty, and error states (with retry)
- Responsive, consistent Material 3 design system

---

<h2 id="architecture-overview">🏗 Architecture Overview</h2>

TicketFlow follows a **feature-first folder structure** combined with a **simplified Clean Architecture**, using **Cubit** (from `flutter_bloc`) for state management and the **Repository Pattern** for full data-source abstraction.

```
                  ┌──────────────────────────────────────────────────────────────────────┐
                  │                       TICKETFLOW (Flutter App)                       │
                  │                                                                      │
                  │  ┌─────────────────┐   ┌──────────────────┐   ┌──────────────────┐   │
                  │  │  Feature-First  │   │   Cubit State    │   │   Hive CE Local  │   │
                  │  │  Clean Arch.    │   │    Management    │   │     Storage      │   │
                  │  └─────────────────┘   └──────────────────┘   └──────────────────┘   │
                  │                                                                      │
                  │  ┌─────────────────┐   ┌───────────────────┐ ┌──────────────────┐    │
                  │  │   go_router     │   │ Dio + Interceptors│ │    GetIt DI      │    │
                  │  │ Declarative Nav │   │ (wired, not yet   │ │ Service Locator  │    │
                  │  │                 │   │  connected to API)│ │                  │    │
                  │  └─────────────────┘   └───────────────────┘ └──────────────────┘    │
                  └──────────────────────────────────┬───────────────────────────────────┘
                                                     │
                                                     ▼
                                      ┌─────────────────────────────────┐
                                      │       On-Device Hive Boxes      │
                                      │    ticketsBox · settingsBox     │
                                      └─────────────────────────────────┘
```

**Dependency direction:** `Views → Cubits → Repositories → Data Sources → Storage (Hive)` — all dependencies point inward, and concrete implementations are injected via GetIt.

### State Management Philosophy

Business logic is fully separated from the UI using **Cubit**, chosen over full **Bloc** since the app's actions are simple method calls (`getAllTickets()`, `deleteTicketById(id)`) with no need for explicit event classes. Each feature owns its own Cubit, registered as a `Factory` in GetIt so every route gets a fresh instance — preventing stale state between screens. BlocProviders are attached at the **route level** inside `app_router.dart`, not the widget tree.

### Navigation

`go_router` handles all declarative routing, including passing data (like a selected `TicketModel`) via `state.extra`.

### Dependency Injection

`get_it` manages all bindings: data sources and repositories are registered as `LazySingleton` (shared, stateless), while Cubits are registered as `Factory` (fresh per route).

### Error Handling

Repositories wrap data-source calls and return `Either<String, T>` (from `dartz`), so Cubits never need to know about exception types — they simply fold on `Left(error)` or `Right(data)`.

---

<h2 id="project-structure">📁 Project Structure</h2>

```
lib/
├── app/                        # Root MaterialApp.router widget + sequential app initializer
│
├── core/                       # App-wide shared resources
│   ├── common/                  # Reusable dialogs, snackbars, debouncer
│   ├── constants/               # API endpoints, keys, app constants
│   ├── di/                      # GetIt service locator setup
│   ├── enums/                   # Rich enums: TicketPriority, TicketCategory, TicketStatus
│   ├── errors/                  # Exceptions, handlers, unified ErrorModel
│   ├── functions/               # Small utility helpers (date formatting, token building, etc.)
│   ├── logging/                 # AppLogger + global BlocObserver
│   ├── models/                  # Core TicketModel (Hive-annotated)
│   ├── routes/                  # GoRouter configuration + navigation helpers
│   ├── services/                # Hive & secure storage services, Dio network layer
│   ├── utils/                   # Assets, colors, typography, spacing, radius, shadows, theme
│   ├── validators/              # Form validators (subject, description, email, password)
│   └── widgets/                 # Shared UI: chips, buttons, inputs, loading/empty/error states
│
└── features/                   # Independent, self-contained feature modules
    ├── splash/                  # Animated splash → navigates to Home
    ├── home/                    # Dashboard + ticket list entry screen
    ├── dashboard/               # Ticket statistics (data/presentation)
    ├── tickets/                 # Ticket list & ticket details (data/presentation)
    ├── ticket_form/             # Create/Edit ticket form (data/presentation)
    └── search/                  # Ticket search (data/presentation)
```

### Feature Module Pattern

Every feature follows the same internal structure to ensure consistency and discoverability:

```
feature_name/
├── data/
│   ├── data_sources/          # Abstract interface + implementation (Hive/API)
│   ├── models/                 # Feature-specific data models (if any)
│   └── repos/                  # Abstract repository + implementation (returns Either)
└── presentation/
    ├── view_models/            # Cubits + States (business logic)
    └── views/                  # Screens & feature-specific widgets
```

---

<h2 id="tech-stack-dependencies">⚒ Tech Stack & Dependencies</h2>

### Core

| Package        | Purpose                                      |
| --------------- | --------------------------------------------- |
| `flutter_bloc` | State management (Cubit)                      |
| `bloc`         | Core bloc library required by `flutter_bloc`  |
| `go_router`    | Declarative routing & deep linking            |
| `get_it`       | Dependency injection (Service Locator)        |
| `dartz`        | Functional programming — `Either<L, R>` types |

### Networking

| Package | Purpose                                                              |
| -------- | ---------------------------------------------------------------------- |
| `dio`   | HTTP client with interceptors & timeouts — wired for future API use    |

### Storage

| Package                  | Purpose                                              |
| ------------------------- | ------------------------------------------------------ |
| `hive_ce` / `hive_ce_flutter` | Local NoSQL database — offline-first ticket persistence |
| `flutter_secure_storage` | Encrypted storage reserved for auth tokens              |

### UI & UX

| Package          | Purpose                                  |
| ----------------- | ------------------------------------------ |
| `google_fonts`   | Inter typography                          |
| `flutter_svg`    | SVG icon rendering                        |
| `fl_chart`       | Dashboard statistics charts                |
| `lottie`         | Loading/empty state animations             |
| `device_preview` | Responsive testing across devices in dev  |

### Utilities

| Package           | Purpose                                     |
| ------------------ | ---------------------------------------------- |
| `logger`          | Color-coded console logging                 |
| `intl`            | Date formatting                             |
| `uuid`            | Unique ticket ID generation                 |
| `meta`            | Static analysis annotations (`@immutable`)  |
| `cupertino_icons` | iOS-style icon pack                         |

### Dev Dependencies

| Package             | Purpose                          |
| --------------------- | ----------------------------------- |
| `flutter_lints`      | Lint rules                        |
| `build_runner`       | Code generation orchestrator      |
| `hive_ce_generator`  | Hive type adapter generator       |

---

<h2 id="setup-instructions">🚀 Setup Instructions</h2>

### Prerequisites

- Flutter SDK with Dart ≥ 3.12.2
- Android Studio or VS Code with the Flutter & Dart plugins
- An Android/iOS emulator or a physical device

### Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/mohamed-dev-404/ticketflow.git
   cd ticketflow
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (required — the app depends on generated `*.g.dart` files)

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

No `.env` file or backend configuration is required — TicketFlow runs fully offline out of the box.

---

<h2 id="demo">🎬 Demo</h2>

<div align="center">

🎥 **[Watch the full app walkthrough (Google Drive)](https://drive.google.com/drive/folders/1z9UGgeslCXRJI6q9VkoQCY14u5di2xTM?usp=sharing)**

*Dashboard, ticket list with search/filter/sort, ticket creation, and full ticket detail/edit/delete flow.*

</div>

---

<h2 id="assumptions-limitations">⚠️ Assumptions & Limitations</h2>

- **Offline-first by design:** all ticket data is persisted locally via Hive CE. The Dio-based network layer (interceptors, auth handling, endpoints) is fully wired but intentionally not connected to a live backend yet — it's scaffolded for future API integration.
- **Light theme only:** dark mode is not implemented in the current version; the design system (colors, typography, spacing) is structured to support it later with minimal changes.
- **Ticket numbers** are generated client-side via `uuid`, not by a remote server.
- **Text scaling is locked to `1.0`** app-wide so ticket cards and chips stay consistent regardless of the device's system font-size setting.
- **Single device, no sync:** since there's no backend in use, tickets live only in the Hive box on the device the app is installed on.
- **No authentication or roles yet:** the app currently has no permission system — there's a single implicit role, and the user who opens a ticket is the same one expected to close it themselves. Multi-role permissions (e.g. agent vs. requester) will be introduced once a backend and authentication layer are added.

---

<h2 id="license">📄 License</h2>

**All Rights Reserved © 2026 — Mohamed Ibrahim**

This project — including all source code and documentation — was developed as part of a Flutter developer technical assessment and is shared **for review and evaluation purposes only**.

No part of this project may be copied, modified, redistributed, or reused for academic or commercial purposes without prior written permission from the author.

<div align="center">

---

Made with ❤️ using Flutter

</div>