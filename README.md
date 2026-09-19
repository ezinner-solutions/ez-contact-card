# EZ Contact Card

A **customizable, composition-based** Flutter contact card widget with built-in **Material 3 design enforcement**, **automatic avatar generation**, and **drop-in ListTile compatibility**.

## 🛑 The Problem

Building list items or contact cards in Flutter often results in repetitive, messy boilerplate:
1.  **Duplicate Layouts:** You constantly rewrite the same `Card` -> `InkWell` -> `Row` -> `Avatar` -> `Column` -> `Text` hierarchy.
2.  **Inconsistent Styling:** Cards look flat or unstyled unless manually given `BoxDecoration`, `BorderRadius`, and shadows.
3.  **Avatar Boilerplate:** Having to manually configure an avatar widget with initials and colors for every contact row slows down development.
4.  **Handling Overflows:** Forgetting to wrap labels with `Expanded` and text ellipsis causes ugly yellow-and-black pixel overflows on smaller screens.
5.  **ListTile Rigidity:** Standard `ListTile` is hard to theme as a modern card and lacks automatic initials and contrast management.

## ✅ The EZ Solution

`EzContactCard` solves all of these pain points out of the box:
-   **Enforced Design Solutions:** Built-in Material 3 card styling variants (`elevated`, `filled`, `outlined`, `none`) that automatically pull surface colors, borders, and elevations from your app's `Theme`.
-   **Automatic Smart Avatar:** If you don't supply an avatar, it automatically constructs an `EzCircleAvatar` from `name` with deterministic colors and initials!
-   **Drop-in ListTile Replacement:** Supports familiar parameters (`leading`, `trailing`, `title`, `dense`, `enabled`) so you can swap existing `ListTile` or `Card` widgets with zero friction.
-   **Defensive Design:** Automatic text truncation prevents horizontal layout overflows.
-   **Accessible:** Automatic screen-reader `Semantics` label calculation for high accessibility standards.
-   **Total Styling Control:** Keep opinionated defaults or fully customize backgrounds, borders, shadows, margins, and text styles.

## ✨ Features

*   **Design Variants:** Switch between `EzContactCardVariant.elevated`, `filled`, `outlined`, or `none`.
*   **Zero-Config Avatar:** Omitting `avatar` auto-generates initials and colors based on `name`.
*   **Drop-in Compatibility:** Direct replacement for `ListTile` with `leading`, `trailing`, `title`, `dense`, and `enabled`.
*   **Material 3 Ready:** Deep integration with `ThemeData`, `ColorScheme`, and `CardTheme`.
*   **Defensive Overflow Prevention:** Gracefully truncates long names and subtitles with ellipsis.
*   **Accessibility First:** Automated `Semantics` label and gesture actions for screen readers.
*   **Interaction Ready:** Built-in `onTap`, `onLongPress`, and rounded ink ripple responses.

## 📦 Installation

```shell
flutter pub add ez_contact_card
```

## 🚀 Usage

### 1. Zero-Config (Auto-Avatar & Default Elevated Card)
Just provide the name. The avatar, initials, background color, card elevation, and rounded corners are handled automatically.
```dart
EzContactCard(
  name: 'Jane Doe',
  onTap: () => _viewContact(context),
)
```

### 2. Material 3 Card Variants
Select from opinionated design variants:
```dart
// Elevated card (Default - subtle shadow & surface container color)
EzContactCard(
  name: 'Elevated Contact',
  variant: EzContactCardVariant.elevated,
)

// Filled card (Flat surface container highest fill)
EzContactCard(
  name: 'Filled Contact',
  variant: EzContactCardVariant.filled,
)

// Outlined card (Subtle outline border with no shadow)
EzContactCard(
  name: 'Outlined Contact',
  variant: EzContactCardVariant.outlined,
)
```

### 3. Drop-in ListTile Replacement (with Dense Mode)
Use familiar `ListTile` properties like `leading`, `trailing`, and `dense`:
```dart
EzContactCard(
  leading: Icon(Icons.star, color: Colors.amber),
  name: 'Starred Contact',
  subtitle: 'Team Lead',
  trailing: Icon(Icons.chevron_right),
  dense: true,
  variant: EzContactCardVariant.outlined,
  onTap: () {},
)
```

### 4. With Action & Custom Avatar
Pass any custom avatar widget (such as `EzCircleAvatar` with a photo) and a trailing action button:
```dart
EzContactCard(
  name: 'Alice Johnson',
  subtitle: 'Product Manager',
  avatar: EzCircleAvatar(
    name: 'Alice Johnson',
    backgroundImage: NetworkImage('https://example.com/alice.jpg'),
  ),
  tail: IconButton(
    icon: const Icon(Icons.phone),
    onPressed: () => _call(context),
  ),
  onTap: () => _viewProfile(context),
)
```

### 5. Disabled State
Disable interaction and dim the visual presentation:
```dart
EzContactCard(
  name: 'Archived User',
  subtitle: 'Account deactivated',
  enabled: false,
  tail: const Icon(Icons.lock_outline),
  onTap: () {},
)
```

### 6. Fully Styled (Custom Design System)
Take complete control over borders, shadows, margins, and typography:
```dart
EzContactCard(
  name: 'Admin User',
  subtitle: 'System Administrator',
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    border: Border.all(color: Colors.grey.shade200),
  ),
  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  contentPadding: const EdgeInsets.all(20),
  nameStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  subtitleStyle: const TextStyle(color: Colors.grey),
)
```

## 🤝 Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request on [GitHub](https://github.com/Evgenii-Zinner/ez-contact-card).

## 📜 License

MIT License - see the [LICENSE](LICENSE) file for details.
