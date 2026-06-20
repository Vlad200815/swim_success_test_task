# Swim Success — Test Task

A Flutter app built with Clean Architecture, featuring a swim pace selector, a user list with search, and a user details screen.

## Architecture & State Management

This project follows Clean Architecture, split into three layers per feature: **data**, **domain**, and **presentation**.

### State management choice

I used both `Cubit` and `Bloc` on purpose, picked per screen based on what that screen actually does.

**`PaceSelectorCubit`** — the pace selector has one source of truth, a single time value, and everything else on screen (slider position, level label, level color, button color) is just a function of that one value. There's only one kind of thing happening — the time changed, whether from typing, the stepper buttons, or dragging the slider — so giving it a named event type wouldn't buy anything. Cubit's plain method-call API (`updateTime`, `setFromSliderValue`, `postPaceSeconds`) matches that directly.

**`UserListBloc`** — the list has two distinct things that can happen: fetching all users, and filtering them by name. I gave the search event a debounce transformer (350ms), and that turned out to matter even though the filtering itself is local and synchronous, not a network call — without the debounce, the list re-renders on every single keystroke, which feels jittery as you type. Bloc made that one line of declarative setup instead of a hand-rolled `Timer`. I also added a small artificial delay on pull-to-refresh, since the API responds almost instantly and the refresh spinner was disappearing before it even registered as "doing something."

**`UserDetailsCubit`** — back to one responsibility: fetch a single user, show loading/success/error. Same logic as the pace selector — one action, nothing that benefits from being a named event.

The actual rule I used: **Cubit when there's one kind of thing happening; Bloc when there's more than one, especially if any of them need their own timing behavior.**

All three features now consistently translate exceptions into a `Failure` type at the repository boundary, via a shared `DioExceptionMapper` in `core/network/`.

## Project Structure

```
lib/
├── gen/                        # Generated assets
└── src/
    ├── app/                    # App config, navigation/routing setup
    ├── core/                   # Shared, feature-agnostic code (DI, network, error types, theme)
    └── features/
        ├── pace_selector/
        │   ├── data/           # DTOs, API service, repository implementation
        │   ├── domain/         # Repository interface, use cases
        │   └── presentation/   # Cubit, page, widgets
        └── user_list/
            ├── data/
            ├── di/
            ├── domain/
            └── presentation/
                ├── user_list/      # Bloc, page, widgets — the list screen itself
                ├── user_details/   # Cubit, page, widgets — reached from a list item
                └── widgets/        # Shared between the two above
```

`user_details` lives inside `user_list` rather than as its own top-level feature, since the only way to reach it is by tapping a card in the list — they share the same domain layer (`UserEntity`, the repository) and it didn't make sense to split them into separate features that would just end up depending on each other anyway.

The dependency rule only flows one direction: `presentation → domain ← data`. Domain never imports from data or presentation. That's what made it possible to translate Dio-specific exceptions into a generic `Failure` type at the repository boundary for the pace selector — cubits and blocs never need to import `dio` directly, only the `Failure` type.

## What I'd Do Differently With More Time

- **Tests.** None written for this submission. The cubits/blocs would be first — pure logic, straightforward to test in isolation with `bloc_test` — followed by widget tests for the more custom pieces (`PaceSlider`, `TimeInput`, `CustomSearchBar`) since they carry layout/gesture logic that's easy to break silently on a future change.
- **Settled on the simpler pace-selector layout sooner.** Early on I went through a few rounds of `IntrinsicHeight` + `Spacer`-based layout before landing on plain proportional spacing (`SizedBox` heights computed from `MediaQuery`). It looked cleaner on paper but turned out to be fragile combined with interactive widgets like `TextField` and `Slider`. I'd start with the simpler version from the beginning next time.
- **Localization** Localization is always present thing to had in your pocket, plus we would get rid of all String-based APIs. So we would make less typos.
- **Light Theme** Great plus because a lot of people prefer light to dark theme.
 
---

# Pace Selector — Time Range & Level Thresholds

This section explains where the numbers in `PaceSelectorCubit` came from, so they're not just unexplained constants the next person (or future you) has to reverse-engineer.

## What these numbers represent

The pace selector asks for a 100m freestyle time and classifies it into one of four levels: **Elite**, **Advanced**, **Intermediate**, **Beginner**. Two separate things derive from that one time value:

1. **The slider's continuous position** (`sliderValue`, 0.0–1.0) — driven by `_minSeconds` and `_maxSeconds`, the fastest and slowest ends of the range the slider can represent.
2. **The discrete level label** — driven by `levelBoundarySeconds`, the three cutoff points between levels.

## Current values

| Constant | Value | Meaning |
|---|---|---|
| `_minSeconds` | 30 (0:30) | Fastest time the slider represents |
| `_maxSeconds` | 180 (3:00) | Slowest time the slider represents |
| Elite cutoff | ≤ 59 (1:00) | |
| Advanced cutoff | ≤ 90 (1:30) | |
| Intermediate cutoff | ≤ 120 (2:00) | |
| Beginner | > 120 (slower than 2:00) | |

## Where these numbers came from

These are based on general estimates for **adult recreational swimmers**, not competitive or Olympic-level classification, and not specific to any age group or training background. Roughly:

- **Elite** (under 1:00): trained, technically efficient swimmer — fast but not necessarily competitive-level. Competitive swimmers can go well under 1:00, but that's a different population than this app is likely serving.
- **Advanced** (1:00–1:30): comfortable, technically solid swimmer who trains regularly.
- **Intermediate** (1:30–2:00): can swim the distance continuously with reasonable form, but isn't training specifically for speed.
- **Beginner** (slower than 2:00): still building endurance/technique; may need rest breaks to complete the distance.

**Important caveat:** I'm not a certified swim coach, and these aren't pulled from an authoritative training standard or governing-body pace chart. They're a reasonable starting point for a general adult audience. If you have access to real data — your own swim background, a coach's input, or actual user data once this ships — that should take priority over these numbers.

## If you need to change these

All of the above lives in one place: the `static const` fields at the top of `PaceSelectorCubit`. Nothing else in the codebase hardcodes these values — `PaceSlider`'s tick marks, tick labels, the level label text, and the level-based colors on the button and slider all derive from these constants via `PaceSelectorCubit.secondsToValue`, `formatSeconds`, and `PaceSelectorState.level`. Changing a threshold here is a one-place edit, not a find-and-replace across the UI.

---

## 🚀 Getting Started

**Prerequisites**

- Flutter SDK with Dart `^3.12.1` (Flutter 3.24+ recommended)
- Android Studio / Xcode for device or emulator targets
- A connected device or running emulator/simulator

**Quick setup**

```bash
# 1. Install dependencies
flutter pub get

# 2. Run
flutter run
```

**Full clean build**

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 📦 Build

### Android

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle for Play Store
flutter build appbundle --release
```

### iOS

```bash
# Build for a connected device / simulator
flutter build ios --release

# Then archive & distribute via Xcode
open ios/Runner.xcworkspace
```
