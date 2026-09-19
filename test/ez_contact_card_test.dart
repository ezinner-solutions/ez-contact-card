import 'package:ez_circle_avatar/ez_circle_avatar.dart';
import 'package:ez_contact_card/ez_contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EzContactCard', () {
    const String testName = 'John Doe';
    const String testSubtitle = 'Software Engineer';
    const Widget testAvatar = CircleAvatar(child: Text('JD'));
    const Widget testTail = Icon(Icons.arrow_forward_ios);

    testWidgets('renders basic contact card', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
            ),
          ),
        ),
      );

      expect(find.text(testName), findsOneWidget);
      expect(find.byWidget(testAvatar), findsOneWidget);
      expect(find.text(testSubtitle), findsNothing);
    });

    testWidgets('renders subtitle and tail when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              subtitle: testSubtitle,
              avatar: testAvatar,
              tail: testTail,
            ),
          ),
        ),
      );

      expect(find.text(testName), findsOneWidget);
      expect(find.text(testSubtitle), findsOneWidget);
      expect(find.byWidget(testTail), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(EzContactCard));
      expect(tapped, isTrue);
    });

    testWidgets('calls onLongPress when long-pressed',
        (WidgetTester tester) async {
      bool longPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(EzContactCard));
      expect(longPressed, isTrue);
    });

    testWidgets(
        'applies visual properties (border, borderRadius, color, elevation)',
        (WidgetTester tester) async {
      const Color bgColor = Colors.blue;
      final Border border = Border.all(color: Colors.red, width: 2.0);
      final BorderRadius borderRadius = BorderRadius.circular(10.0);
      const double elevation = 5.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              backgroundColor: bgColor,
              border: border,
              borderRadius: borderRadius,
              elevation: elevation,
            ),
          ),
        ),
      );

      final containerFinder = find
          .descendant(
            of: find.byType(EzContactCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, bgColor);
      expect(decoration.border, border);
      expect(decoration.borderRadius, borderRadius);
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.first.blurRadius, elevation);
    });

    testWidgets('prefers decoration over shorthand visual properties',
        (WidgetTester tester) async {
      const Color bgColor = Colors.blue;
      const Color decorationColor = Colors.green;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              backgroundColor: bgColor,
              decoration: BoxDecoration(color: decorationColor),
            ),
          ),
        ),
      );

      final containerFinder = find
          .descendant(
            of: find.byType(EzContactCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, decorationColor);
      expect(decoration.color, isNot(bgColor));
    });

    testWidgets('respects nameMaxLines and subtitleMaxLines',
        (WidgetTester tester) async {
      const int nameMaxLines = 2;
      const int subtitleMaxLines = 3;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              subtitle: testSubtitle,
              avatar: testAvatar,
              nameMaxLines: nameMaxLines,
              subtitleMaxLines: subtitleMaxLines,
            ),
          ),
        ),
      );

      final nameText = tester.widget<Text>(find.text(testName));
      final subtitleText = tester.widget<Text>(find.text(testSubtitle));

      expect(nameText.maxLines, nameMaxLines);
      expect(subtitleText.maxLines, subtitleMaxLines);
    });

    testWidgets('layout respects gap', (WidgetTester tester) async {
      const double customGap = 20.0;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              avatar: testAvatar,
              tail: testTail,
              gap: customGap,
            ),
          ),
        ),
      );

      // We expect two SizedBoxes with width = customGap
      final sizedBoxes = find.byType(SizedBox);
      bool foundGap = false;
      for (var element in tester.widgetList<SizedBox>(sizedBoxes)) {
        if (element.width == customGap) {
          foundGap = true;
        }
      }
      expect(foundGap, isTrue);
    });

    testWidgets('automatically generates EzCircleAvatar when avatar is omitted',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: 'Alice Cooper',
            ),
          ),
        ),
      );

      expect(find.byType(EzCircleAvatar), findsOneWidget);
      expect(find.text('AC'), findsOneWidget);
    });

    testWidgets(
        'renders zero argument constructor cleanly (drop-in compatibility)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(),
          ),
        ),
      );

      expect(find.byType(EzContactCard), findsOneWidget);
      expect(find.byType(EzCircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('omits avatar when showAvatar is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: 'No Avatar User',
              showAvatar: false,
            ),
          ),
        ),
      );

      expect(find.byType(EzCircleAvatar), findsNothing);
      expect(find.text('No Avatar User'), findsOneWidget);
    });

    testWidgets('supports leading, trailing, and title drop-in aliases',
        (WidgetTester tester) async {
      const leadingWidget = Icon(Icons.star);
      const trailingWidget = Icon(Icons.arrow_back);
      const titleWidget = Text('Custom Title');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              leading: leadingWidget,
              trailing: trailingWidget,
              title: titleWidget,
            ),
          ),
        ),
      );

      expect(find.byWidget(leadingWidget), findsOneWidget);
      expect(find.byWidget(trailingWidget), findsOneWidget);
      expect(find.byWidget(titleWidget), findsOneWidget);
    });

    testWidgets('applies filled variant styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: const Scaffold(
            body: EzContactCard(
              name: 'Filled Card',
              variant: EzContactCardVariant.filled,
            ),
          ),
        ),
      );

      final containerFinder = find
          .descendant(
            of: find.byType(EzContactCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.boxShadow, isNull);
      expect(decoration.border, isNull);
      expect(decoration.borderRadius, BorderRadius.circular(12.0));
    });

    testWidgets('applies outlined variant styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: const Scaffold(
            body: EzContactCard(
              name: 'Outlined Card',
              variant: EzContactCardVariant.outlined,
            ),
          ),
        ),
      );

      final containerFinder = find
          .descendant(
            of: find.byType(EzContactCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.border, isNotNull);
      expect(decoration.boxShadow, isNull);
    });

    testWidgets('applies none variant styling (transparent and unstyled)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: 'Unstyled Card',
              variant: EzContactCardVariant.none,
            ),
          ),
        ),
      );

      final containerFinder = find
          .descendant(
            of: find.byType(EzContactCard),
            matching: find.byType(Container),
          )
          .first;
      final container = tester.widget<Container>(containerFinder);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.color, Colors.transparent);
      expect(decoration.border, isNull);
      expect(decoration.boxShadow, isNull);
    });

    testWidgets('respects dense property for compact padding and gap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              tail: testTail,
              dense: true,
            ),
          ),
        ),
      );

      // Find the Padding widget inside InkWell
      final paddingFinder = find
          .descendant(
            of: find.byType(InkWell),
            matching: find.byType(Padding),
          )
          .first;
      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(
        paddingWidget.padding,
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      );

      // Verify gap is 12.0
      final sizedBoxes = find.byType(SizedBox);
      bool foundDenseGap = false;
      for (var element in tester.widgetList<SizedBox>(sizedBoxes)) {
        if (element.width == 12.0) {
          foundDenseGap = true;
        }
      }
      expect(foundDenseGap, isTrue);
    });

    testWidgets(
        'disables interaction and applies opacity when enabled is false',
        (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              enabled: false,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(EzContactCard));
      expect(tapped, isFalse);

      expect(find.byType(Opacity), findsOneWidget);
      final opacityWidget = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacityWidget.opacity, 0.6);
    });

    testWidgets('generates semantic labels accurately',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              subtitle: testSubtitle,
            ),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.byType(EzContactCard)),
        matchesSemantics(
          label: '$testName, $testSubtitle',
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
    });

    testWidgets('supports custom semanticLabel override',
        (WidgetTester tester) async {
      const customLabel = 'Custom screen reader text';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzContactCard(
              name: testName,
              semanticLabel: customLabel,
            ),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.byType(EzContactCard)),
        matchesSemantics(
          label: customLabel,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
    });
  });
}
