/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/// Mobius — Widget (UI) Test Example
/// Feature: Transfer
/// Target Layer: Presentation (Page + Widgets)
/// Architecture Style: BLoC + Injectable DI
/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

// ── Nyx Feature Imports (Illustrative) ──
// import 'package:nyx/core/di/injection.dart';
// import 'package:nyx/features/transfer/presentation/bloc/transfer_bloc.dart';
// import 'package:nyx/features/transfer/presentation/pages/transfer_page.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// SECTION 1: Mock & Locator Setup
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class MockTransferBloc extends MockBloc<TransferEvent, TransferState>
    implements TransferBloc {}

class FakeTransferParams extends Fake implements TransferParams {}

final locator = GetIt.instance;

void main() {
  late MockTransferBloc mockTransferBloc;

  setUpAll(() {
    registerFallbackValue(FakeTransferParams());
  });

  setUp(() async {
    // 1. Reset locator instance to prevent cross-test contamination
    await locator.reset();

    // 2. Instantiate Mock BLoC
    mockTransferBloc = MockTransferBloc();

    // 3. Register mock BLoC inside GetIt locator container
    locator.registerFactory<TransferBloc>(() => mockTransferBloc);
  });

  tearDown(() async {
    // Clear all registrations
    await locator.reset();
  });

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // HELPER: Build subject widget wrapped with dependencies
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Widget buildSubject({TransferState? initialState}) {
    when(() => mockTransferBloc.state)
        .thenReturn(initialState ?? TransferInitial());

    return MaterialApp(
      theme: ThemeData.light(),
      home: BlocProvider<TransferBloc>.value(
        value: mockTransferBloc,
        child: const TransferPage(),
      ),
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 2: UI Elements Rendering Tests
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  group('TransferPage — Rendering', () {
    testWidgets('renders AppBar with title "Transfer Dana"', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Transfer Dana'), findsOneWidget);
    });

    testWidgets('renders form fields inside initial state', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(
        find.byKey(const Key('transfer_recipient_field')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('transfer_amount_field')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('transfer_submit_button')),
        findsOneWidget,
      );
    });
  });

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 3: BLoC State Reactions UI Tests
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  group('TransferPage — BLoC State Reactions', () {
    testWidgets('displays loading layout when state is TransferLoading',
        (tester) async {
      await tester.pumpWidget(
        buildSubject(initialState: TransferLoading()),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Submit button should be disabled when loading is active
      final button = tester.widget<ElevatedButton>(
        find.byKey(const Key('transfer_submit_button')),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets(
      'displays success bottom sheet dialog when state is TransferSuccess',
      (tester) async {
        // Build initial page view
        when(() => mockTransferBloc.state).thenReturn(TransferInitial());
        
        // Setup state stream emission
        whenListen(
          mockTransferBloc,
          Stream<TransferState>.fromIterable([
            TransferLoading(),
            const TransferSuccess(refId: 'REF-SUCCESS-101'),
          ]),
        );

        await tester.pumpWidget(buildSubject());
        await tester.pumpAndSettle();

        // Verify success popup displays correct elements
        expect(find.text('Transfer Berhasil'), findsOneWidget);
        expect(find.text('REF-SUCCESS-101'), findsOneWidget);
      },
    );

    testWidgets(
      'displays error message banner when state is TransferFailure',
      (tester) async {
        when(() => mockTransferBloc.state).thenReturn(TransferInitial());
        
        whenListen(
          mockTransferBloc,
          Stream<TransferState>.fromIterable([
            TransferLoading(),
            const TransferFailure(message: 'Core banking connection refused'),
          ]),
        );

        await tester.pumpWidget(buildSubject());
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Core banking connection refused'), findsOneWidget);
      },
    );
  });

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 4: User Actions Interaction Tests
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  group('TransferPage — Interactions', () {
    testWidgets('submits correct event when submit button is pressed',
        (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      // Simulate inputs
      await tester.enterText(
        find.byKey(const Key('transfer_recipient_field')),
        '0099887766',
      );
      await tester.enterText(
        find.byKey(const Key('transfer_amount_field')),
        '500000',
      );

      // Trigger submit
      await tester.tap(find.byKey(const Key('transfer_submit_button')));
      await tester.pump();

      // Verify BLoC Event was correctly dispatched with validated inputs
      verify(() => mockTransferBloc.add(any(that: isA<SubmitTransferEvent>()))).called(1);
    });

    testWidgets('shows validation indicators when fields are empty',
        (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      // Directly tap without setting inputs
      await tester.tap(find.byKey(const Key('transfer_submit_button')));
      await tester.pumpAndSettle();

      expect(find.text('Nomor rekening tidak valid'), findsOneWidget);
      expect(find.text('Nominal wajib diisi'), findsOneWidget);

      // Verify BLoC was not invoked
      verifyNever(() => mockTransferBloc.add(any()));
    });
  });
}
