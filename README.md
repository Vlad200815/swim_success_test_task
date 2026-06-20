


# Pace Selector — Time Range & Level Thresholds

This document explains where the numbers in `PaceSelectorCubit` came from,
so they're not just unexplained constants the next person (or future you)
has to reverse-engineer.

## What these numbers represent

The pace selector asks for a 100m freestyle time and classifies it into one
of four levels: **Elite**, **Advanced**, **Intermediate**, **Beginner**.
Two separate things derive from that one time value:

1. **The slider's continuous position** (`sliderValue`, 0.0–1.0) — driven
   by `_minSeconds` and `_maxSeconds`, the fastest and slowest ends of the
   range the slider can represent.
2. **The discrete level label** — driven by `levelBoundarySeconds`, the
   three cutoff points between levels.


## Current values

| Constant | Value                    | Meaning |
|---|--------------------------|---|
| `_minSeconds` | 30 (0:30)                | Fastest time the slider represents |
| `_maxSeconds` | 180 (3:00)               | Slowest time the slider represents |
| Elite cutoff | ≤ 59 (1:00)              | |
| Advanced cutoff | ≤ 90 (1:30)              | |
| Intermediate cutoff | ≤ 120 (2:00)             | |
| Beginner | > 120 (slower than 2:00) | |

## Where these numbers came from

These are based on general estimates for **adult recreational swimmers**,
not competitive or Olympic-level classification, and not specific to any
age group or training background. Roughly:

- **Elite** (under 1:15): trained, technically efficient swimmer — fast
  but not necessarily competitive-level. Competitive swimmers can go well
  under 1:00, but that's a different population than this app is likely
  serving.
- **Advanced** (1:15–1:45): comfortable, technically solid swimmer who
  trains regularly.
- **Intermediate** (1:45–2:15): can swim the distance continuously with
  reasonable form, but isn't training specifically for speed.
- **Beginner** (slower than 2:15): still building endurance/technique;
  may need rest breaks to complete the distance.

**Important caveat:** I'm not a certified swim coach, and these aren't
pulled from an authoritative training standard or governing-body pace
chart. They're a reasonable starting point for a general adult audience.
If you have access to real data — your own swim background, a coach's
input, or actual user data once this ships — that should take priority
over these numbers.

## If you need to change these

All of the above lives in one place: the `static const` fields at the top
of `PaceSelectorCubit`. Nothing else in the codebase hardcodes these
values — `PaceSlider`'s tick marks, tick labels, the level label text, and
the level-based colors on the button and slider all derive from these
constants via `PaceSelectorCubit.secondsToValue`, `formatSeconds`, and
`PaceState.level`. Changing a threshold here is a one-place edit, not a
find-and-replace across the UI.


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

---
