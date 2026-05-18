---
name: flutter-testing-coverage
trigger: "unit test", "widget test", "ui test", "integration test", "coverage", "sonarqube", "test coverage", "generate test", "lcov", "bamboo", "bitbucket"
platform: mobile/flutter
version: "1.1.0"
---

# Flutter — Testing & Coverage Skill (Nyx Core Stack: BLoC + Injectable)

## Overview

This skill enables AI agents to generate high-quality **Unit Tests** and **UI (Widget) Tests** for a specific feature scope in the **Nyx** codebase, targeting a specific code coverage percentage in **SonarQube** using **lcov**, integrated with the **Bitbucket** and **Bamboo** pipeline.

### Keyword-Based Scoping
To ignore legacy code and focus strictly on newly implemented or refactored features, this skill supports **keyword-based scoping** (e.g. `v2`, `totp`) instead of rigid file path constraints. This allows testing of:
- **v2 Features**: e.g., `transaction_v2_list_page.dart`
- **Specific Feature Modules**: e.g., `totp_verification_bloc.dart` (which may not contain the `v2` keyword but is a new development target).

### Nyx Core Architecture Stack
1. **State Management**: `flutter_bloc` (Events and States, utilizing `bloc_test`).
2. **Dependency Injection**: `get_it` + `injectable` (for automated service registration).
3. **Mocking Framework**: `mocktail` (null-safe, no-codegen mocking).
4. **CI/CD Integration**: Local verification using `lcov` -> Push to **Bitbucket** -> Automated coverage analysis and SonarQube quality gates executed via **Bamboo**.

---

## 🛑 Required Questions (MUST Ask Before Starting)

Before generating any test, the agent **MUST** collect the following information:

| # | Question | Example Answer |
|---|----------|----------------|
| 1 | What are the **scoping keywords** or **path**? | `v2, totp` (to scan for matching files) or `lib/features/transfer/` |
| 2 | What **type of tests** do you need? | `unit`, `widget (UI)`, or `both` |
| 3 | What is the **target coverage percentage**? | `80%` (standard SonarQube quality gate) |
| 4 | Are there any custom injected dependencies using `@injectable` in this feature? | e.g. `TransferRepository`, `CheckLimitUseCase` |
| 5 | Are there **existing tests** matching these keywords in the `test/` directory? | Yes/No (If yes, specify path or names) |

---

## Step-by-Step Workflow

### Phase 1 — Feature Discovery & Audit

#### Step 1.1 — Map the Feature Structure by Keyword

Scan the codebase to find all files related to the scope keyword(s). For example, if searching for keywords `v2` and `totp`:

- **Keyword: `v2`**
  - `lib/presentation/pages_v2/transaction/transaction_v2_list_page.dart` → [TESTABLE: Widget]
  - `lib/presentation/pages_v2/transaction/bloc/transaction_v2_bloc.dart` → [TESTABLE: Unit]
  - `lib/data/models/transaction_v2_model.dart` → [TESTABLE: Unit]
- **Keyword: `totp`**
  - `lib/features/totp/presentation/bloc/totp_bloc.dart` → [TESTABLE: Unit]
  - `lib/features/totp/presentation/pages/totp_page.dart` → [TESTABLE: Widget]

Classify matching files into the standard testing matrix:
- **Models/Entities**: Unit tests (equality, conversion, JSON mapping)
- **UseCases/Repositories**: Unit tests (invocations, error branches, offline handling)
- **BLoCs/Cubits**: Unit tests (event-to-state stream mapping using `bloc_test`)
- **Pages/Widgets**: Widget/UI tests (state rendering, clicks, navigation)

#### Step 1.2 — Run Local Coverage (lcov)

Before writing any new tests, establish the current coverage baseline for files matching your keywords:

```bash
# Run tests with coverage
flutter test --coverage

# View general summary
lcov --summary coverage/lcov.info

# Extract and isolate coverage specifically for target keywords (e.g. 'v2' and 'totp')
lcov --extract coverage/lcov.info '*v2*' '*totp*' -o coverage/feature_scoped.info
lcov --summary coverage/feature_scoped.info
```

#### Step 1.3 — Identify Scoped Coverage Gaps

Generate local HTML reports to identify which lines or branches are missing coverage inside the scoped files:

```bash
genhtml coverage/feature_scoped.info -o coverage/html/scoped_report
# Open coverage/html/scoped_report/index.html in your browser
```

Create a **Coverage Gap Matrix**:

| File | Total Lines | Covered | Missing Lines/Branches | Current % | Priority |
|------|-------------|---------|------------------------|-----------|----------|
| `transaction_v2_bloc.dart` | 92 | 18 | Lines 45-60, 75-90 (Error States) | 19.5% | 🔴 HIGH |
| `totp_bloc.dart` | 65 | 0 | All branches | 0% | 🔴 HIGH |
| `transaction_v2_model.dart` | 20 | 20 | None | 100% | ✅ DONE |
| `totp_page.dart` | 110 | 0 | Pin entering and validation errors | 0% | 🟡 MEDIUM |

---

### Phase 2 — Unit Test Generation (BLoC & Injectable Stack)

#### Step 2.1 — Test File Structure

Mirror the `lib/` structure under the `test/` directory, naming test files with `_test.dart` suffixes matching target filenames:

```
test/
└── presentation/
    └── pages_v2/
        └── transaction/
            ├── bloc/
            │   └── transaction_v2_bloc_test.dart
            └── transaction_v2_list_page_test.dart
```

#### Step 2.2 — BLoC Unit Test Template

Use `bloc_test` to verify that your BLoC correctly transitions states in response to events. Do not call `.add()` and `.expect()` manually; always use the `blocTest` block.

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// Import Nyx dependencies
import 'package:nyx/core/error/failures.dart';
import 'package:nyx/features/transfer/domain/usecases/execute_transfer_use_case.dart';
import 'package:nyx/features/transfer/presentation/bloc/transfer_bloc.dart';

class MockExecuteTransferUseCase extends Mock implements ExecuteTransferUseCase {}
class FakeTransferParams extends Fake implements TransferParams {}

void main() {
  late TransferBloc transferBloc;
  late MockExecuteTransferUseCase mockExecuteTransferUseCase;

  setUpAll(() {
    registerFallbackValue(FakeTransferParams());
  });

  setUp(() {
    mockExecuteTransferUseCase = MockExecuteTransferUseCase();
    transferBloc = TransferBloc(executeTransfer: mockExecuteTransferUseCase);
  });

  tearDown(() {
    transferBloc.close();
  });

  group('TransferBloc Tests', () {
    test('initial state should be TransferInitial', () {
      expect(transferBloc.state, equals(TransferInitial()));
    });

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferSuccess] when transfer is successful',
      build: () {
        when(() => mockExecuteTransferUseCase(any())).thenAnswer(
          (_) async => const Right(TransferResult(refId: 'REF123')),
        );
        return transferBloc;
      },
      act: (bloc) => bloc.add(const SubmitTransferEvent(amount: 100000)),
      expect: () => [
        TransferLoading(),
        const TransferSuccess(refId: 'REF123'),
      ],
      verify: (_) {
        verify(() => mockExecuteTransferUseCase(any())).called(1);
      },
    );

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferFailure] when transfer fails',
      build: () {
        when(() => mockExecuteTransferUseCase(any())).thenAnswer(
          (_) async => const Left(ServerFailure('Connection Timeout')),
        );
        return transferBloc;
      },
      act: (bloc) => bloc.add(const SubmitTransferEvent(amount: 100000)),
      expect: () => [
        TransferLoading(),
        const TransferFailure(message: 'Connection Timeout'),
      ],
    );
  });
}
```

---

### Phase 3 — UI (Widget) Test Generation with Mock Injectable

In the Nyx application, UI components frequently depend on services registered through `injectable` / `get_it`. When writing widget tests, you must mock these dependencies inside the test container before pumping the widget.

#### Step 3.1 — Setup Mock DI Environment

Always reset and register required mocks with `GetIt` inside the test file to avoid test contamination:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

// Nyx DI and feature imports
import 'package:nyx/core/di/injection.dart'; 
import 'package:nyx/features/transfer/presentation/bloc/transfer_bloc.dart';
import 'package:nyx/features/transfer/presentation/pages/transfer_page.dart';

// Define mocks
class MockTransferBloc extends MockBloc<TransferEvent, TransferState> implements TransferBloc {}

final locator = GetIt.instance;

void main() {
  late MockTransferBloc mockTransferBloc;

  setUp(() async {
    // Reset GetIt before each test to clear previous registrations
    await locator.reset();
    
    mockTransferBloc = MockTransferBloc();
    
    // Register the mock instance into GetIt
    locator.registerFactory<TransferBloc>(() => mockTransferBloc);
  });

  tearDown(() async {
    await locator.reset();
  });

  Widget buildSubject() {
    return const MaterialApp(
      home: Scaffold(
        body: TransferPage(),
      ),
    );
  }

  group('TransferPage Widget Tests', () {
    testWidgets('should render Page title and input form', (WidgetTester tester) async {
      when(() => mockTransferBloc.state).thenReturn(TransferInitial());

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.text('Transfer Dana'), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('should trigger submit event when submit button is pressed', (WidgetTester tester) async {
      when(() => mockTransferBloc.state).thenReturn(TransferInitial());

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      // Enter amount
      await tester.enterText(find.byType(TextField).first, '150000');
      
      // Tap submit button
      await tester.tap(find.byKey(const Key('submit_btn')));
      await tester.pump();

      // Verify Event was dispatched to BLoC
      verify(() => mockTransferBloc.add(const SubmitTransferEvent(amount: 150000))).called(1);
    });
  });
}
```

---

### Phase 4 — Bitbucket + Bamboo + SonarQube Integration Workflow

The Nyx testing pipeline follows a **push-and-forget** architecture, where quality control is delegated to the CI/CD environment.

```
[Local Dev]                 [Bitbucket Repo]                 [Bamboo CI]                [SonarQube]
  1. Write tests              1. Commit                        1. Run test suite          1. Parse lcov.info
  2. Run lcov locally  ────>  2. Push branch  ──────────────>  2. Generate lcov.info  ─>  2. Assess quality gates
  3. Validate coverage                                         3. Upload report
```

#### Step 4.1 — Local Scope Validation

Before committing, developers execute the coverage check script using keyword filters to verify target coverage:

```bash
# Verify 80% coverage on files containing 'v2' or 'totp'
./plugins/mobile/flutter/testing-coverage/scripts/coverage_check.sh v2,totp 80
```

#### Step 4.2 — Push to Bitbucket

Once tests pass locally, push to Bitbucket:

```bash
git add .
git commit -m "feat(transfer-v2): Add unit & widget tests targeting 80% coverage"
git push origin feature/transfer-v2
```

#### Step 4.3 — Bamboo & SonarQube Execution

Upon receiving the push, **Bamboo** runs the test suite inside an isolated agent container. Bamboo reads the `sonar-project.properties` configuration inside the project root to map tests and source directories.

Example `sonar-project.properties` configuration:

```properties
sonar.projectKey=id.co.bri.nyx:mobile-app
sonar.projectName=Nyx Mobile Application
sonar.sources=lib
sonar.tests=test
sonar.dart.lcov.reportPaths=coverage/lcov.info

# Exclude generated code and layout frameworks from coverage
sonar.coverage.exclusions=\
  **/*.g.dart,\
  **/*.freezed.dart,\
  **/*.config.dart,\
  **/generated/**,\
  **/l10n/**,\
  lib/main.dart,\
  lib/core/di/injection.dart,\
  lib/core/navigation/app_router.dart,\
  lib/core/navigation/app_router.gr.dart,\
  lib/core/theme/**,\
  lib/core/constants/**

sonar.test.exclusions=\
  test/helpers/**,\
  test/fixtures/**
```

---

### Phase 5 — Verification Checklist

After generating all tests, verify:

- [ ] Every dependency injected via `@injectable` in the target file is either mocked or registered inside `GetIt` for the test.
- [ ] No `// ignore` or `// coverage:ignore` lines are added to bypass SonarQube checks.
- [ ] Tests run successfully without timing out locally: `flutter test`.
- [ ] Code is formatted and passes static analysis: `flutter format . && flutter analyze`.
- [ ] No state leakage between tests (e.g. calling `GetIt.instance.reset()` in `tearDown`).

---

### Troubleshooting

```
ISSUE:   GetIt: "Dependency already registered" Exception
FIX:     Call await GetIt.instance.reset() in setUp() or tearDown() of your test file to clear container states.

ISSUE:   BlocTest fails to record emitted states
FIX:     Ensure you are testing events inside the "act" block, and validating the returned state objects in "expect".

ISSUE:   SonarQube displays 0% coverage for newly added files
FIX:     Check sonar-project.properties configuration. Make sure target file imports in the test files are using package paths (e.g. package:nyx/...) rather than relative paths (../../).

ISSUE:   Widget test fails with "No MaterialLocalizations found"
FIX:     Wrap the widget inside MaterialApp when executing pumpWidget in the test helper.
```

---

## Quick Reference — Test Count Estimator

For a typical feature targeting **80% coverage** in SonarQube:

| Layer | Files | Tests per File | Total Tests |
|-------|-------|----------------|-------------|
| Model (Serialization & Equality) | 2-3 | 3-5 | ~12 |
| UseCase (Invocations & Failures) | 1-2 | 2-3 | ~5 |
| Repository Impl (Remote vs Cache) | 1 | 4-6 | ~5 |
| DataSource (HTTP Calls & Errors) | 1 | 3-4 | ~4 |
| BLoC (Event/State transitions) | 1-2 | 5-8 | ~12 |
| Page & Components (Widget Tests) | 3-5 | 4-6 | ~18 |
| **TOTAL** | | | **~56 tests** |
