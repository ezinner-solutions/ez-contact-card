# EzContactCard

A defensive, accessible Flutter contact card with Material 3 styling variants, automated avatar generation, overflow prevention, and drop-in `ListTile` compatibility.

[![pub package](https://img.shields.io/pub/v/ez_contact_card.svg)](https://pub.dev/packages/ez_contact_card)
[![likes](https://img.shields.io/pub/likes/ez_contact_card.svg)](https://pub.dev/packages/ez_contact_card)
[![pub points](https://img.shields.io/pub/points/ez_contact_card.svg)](https://pub.dev/packages/ez_contact_card)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Problem Statement

Building user contact cards or list rows in Flutter involves repetitive layout boilerplate:

1. **Repetitive Layout Nesting:** Assembling `Card` -> `InkWell` -> `Padding` -> `Row` -> `Avatar` -> `Column` -> `Text` manually for every contact row.
2. **Text Overflow Exceptions:** Forgetting to wrap text columns in `Expanded` or configure text ellipsis causes pixel overflows on narrow screens (`"A RenderFlex overflowed by ... pixels on the right"`).
3. **Manual Avatar Wiring:** Manually configuring avatar initials, deterministic background hashing, and image fallbacks for every row.
4. **ListTile Styling Limitations:** Standard `ListTile` lacks opinionated Material 3 card container variants (`elevated`, `filled`, `outlined`).

### Targeted Error Signatures & Defects
* `"A RenderFlex overflowed by ... pixels on the right"`
* Inconsistent card elevations, margins, and border radii across list views
* Missing accessibility semantics for interactive contact items

## Technical Solution

`EzContactCard` encapsulates contact row layout and design system enforcement into a single composable widget:

1. **Material 3 Design Variants:** Built-in support for `EzContactCardVariant.elevated`, `filled`, `outlined`, and `none` pulling colors and shapes from `ThemeData`.
2. **Automated Smart Avatar:** When omitting `avatar`, `EzContactCard` automatically constructs an `EzCircleAvatar` from `name` with deterministic color hashing and initials.
3. **Defensive Layout:** Automatically constrains name, subtitle, and badges with `Expanded` and text ellipsis to prevent horizontal overflows.
4. **Drop-in ListTile Parity:** Supports familiar properties (`leading`, `trailing`, `dense`, `enabled`, `onTap`, `onLongPress`).
5. **Accessibility First:** Automatically computes screen-reader semantic labels and actions.

## Installation

```shell
flutter pub add ez_contact_card
```

## Quick Migration

Replace standard `ListTile` with `EzContactCard`:

```diff
- ListTile(
-   leading: CircleAvatar(child: Text('JD')),
-   title: Text('Jane Doe'),
-   subtitle: Text('Developer'),
- )
+ EzContactCard(
+   name: 'Jane Doe',
+   subtitle: 'Developer',
+ )
```

## Usage Examples

### 1. Zero-Config (Auto-Avatar & Default Elevated Card)

Just provide the name. The avatar, initials, background color, card elevation, and rounded corners are handled automatically:

```dart
EzContactCard(
  name: 'Jane Doe',
  subtitle: 'Software Engineer',
  onTap: () => _openContact(context),
)
```

### 2. Material 3 Design Variants

```dart
// Elevated card (default)
EzContactCard(
  name: 'Elevated Contact',
  variant: EzContactCardVariant.elevated,
)

// Filled card
EzContactCard(
  name: 'Filled Contact',
  variant: EzContactCardVariant.filled,
)

// Outlined card
EzContactCard(
  name: 'Outlined Contact',
  variant: EzContactCardVariant.outlined,
)
```

### 3. Drop-in ListTile Compatibility (Dense Mode)

```dart
EzContactCard(
  leading: const Icon(Icons.star, color: Colors.amber),
  name: 'Starred Contact',
  subtitle: 'Team Lead',
  trailing: const Icon(Icons.chevron_right),
  dense: true,
  onTap: () {},
)
```

### 4. Custom Avatar & Action Button

```dart
EzContactCard(
  name: 'Alice Johnson',
  subtitle: 'Product Manager',
  avatar: const EzCircleAvatar(
    name: 'Alice Johnson',
    radius: 20,
  ),
  tail: IconButton(
    icon: const Icon(Icons.phone),
    onPressed: () => _callContact(),
  ),
)
```

## API Reference

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `name` | `String` | *Required* | Contact name displayed as title and used for auto-avatar. |
| `subtitle` | `String?` | `null` | Subtitle text displayed below name. |
| `avatar` | `Widget?` | `null` | Custom avatar widget (auto-generates `EzCircleAvatar` if null). |
| `leading` | `Widget?` | `null` | Widget placed before title/avatar (ListTile parity). |
| `trailing` | `Widget?` | `null` | Widget placed at the end of the card (ListTile parity). |
| `tail` | `Widget?` | `null` | Alias for `trailing`. |
| `variant` | `EzContactCardVariant` | `elevated` | Material 3 visual variant (`elevated`, `filled`, `outlined`, `none`). |
| `dense` | `bool` | `false` | Whether to compact padding and font sizing. |
| `enabled` | `bool` | `true` | Whether the card is interactive. |
| `onTap` | `VoidCallback?` | `null` | Tap callback with ink ripple. |
| `onLongPress` | `VoidCallback?` | `null` | Long-press callback. |

## Sponsoring & Support

If this package saved you debugging time, consider supporting ongoing maintenance:
* [GitHub Sponsors](https://github.com/sponsors/Evgenii-Zinner/)
* [Thanks.dev](https://thanks.dev/u/gh/evgenii-zinner)
* [Buy Me a Coffee](https://buymeacoffee.com/evgeniizinner)

## License

MIT License. See [LICENSE](LICENSE) for details.
