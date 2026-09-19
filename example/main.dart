import 'package:ez_circle_avatar/ez_circle_avatar.dart';
import 'package:ez_contact_card/ez_contact_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Contact Card Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EZ Contact Card Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionHeader(title: '1. Zero Config (Auto-Avatar)'),
          EzContactCard(
            name: 'Jane Doe',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '2. Material 3 Variants'),
          EzContactCard(
            name: 'Elevated Card (Default)',
            subtitle: 'Subtle elevation & surface container color',
            variant: EzContactCardVariant.elevated,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          EzContactCard(
            name: 'Filled Card',
            subtitle: 'Flat surface container highest fill',
            variant: EzContactCardVariant.filled,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          EzContactCard(
            name: 'Outlined Card',
            subtitle: 'Crisp outline border with no elevation',
            variant: EzContactCardVariant.outlined,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '3. Drop-in ListTile Aliases & Dense Mode'),
          EzContactCard(
            leading: const Icon(Icons.star, color: Colors.amber),
            name: 'Favorite Contact',
            subtitle: 'Compact dense padding & gap',
            trailing: const Icon(Icons.chevron_right),
            dense: true,
            variant: EzContactCardVariant.outlined,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '4. With Action & Custom Avatar'),
          EzContactCard(
            name: 'Alice Johnson',
            subtitle: 'Product Manager',
            avatar: const EzCircleAvatar(name: 'Alice Johnson'),
            tail: IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                debugPrint('Calling Alice...');
              },
            ),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '5. Disabled State'),
          EzContactCard(
            name: 'Disabled Contact',
            subtitle: 'Interaction blocked, visual opacity dimmed',
            enabled: false,
            tail: const Icon(Icons.lock_outline),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '6. Fully Styled (Custom Decoration)'),
          EzContactCard(
            name: 'Design System Card',
            subtitle: 'Custom decoration & text styles',
            avatar: const EzCircleAvatar(name: 'Design System'),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.grey.shade200),
            ),
            contentPadding: const EdgeInsets.all(20),
            nameStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            subtitleStyle: TextStyle(
              color: Colors.indigo.shade300,
              fontStyle: FontStyle.italic,
            ),
            gap: 20,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: '7. Defensive Long Text Handling'),
          EzContactCard(
            name: 'Christopher Alexander Williamson',
            subtitle:
                'Senior Vice President of Global Engineering & Technology Solutions',
            tail: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
