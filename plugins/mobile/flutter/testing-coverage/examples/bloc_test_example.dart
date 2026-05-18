/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/// Mobius — BLoC Unit Test Example
/// Feature: Transfer
/// Target Layer: Presentation (Bloc)
/// Architecture Style: BLoC + Injectable
/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

// ── Nyx Mocking/Feature Imports (Illustrative) ──
// import 'package:nyx/core/error/failures.dart';
// import 'package:nyx/features/transfer/domain/usecases/execute_transfer_use_case.dart';
// import 'package:nyx/features/transfer/presentation/bloc/transfer_bloc.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// SECTION 1: Mock Declarations
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class MockExecuteTransferUseCase extends Mock
    implements ExecuteTransferUseCase {}

class FakeTransferParams extends Fake implements TransferParams {}

// GetIt instance for DI registration testing
final locator = GetIt.instance;

void main() {
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 2: Setup & Teardown with DI
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  late TransferBloc transferBloc;
  late MockExecuteTransferUseCase mockExecuteTransferUseCase;

  // Test fixtures — reusable data instances
  final tParams = TransferParams(
    recipientAccount: '9876543210',
    amount: 250000,
    currency: 'IDR',
  );

  final tSuccessResult = TransferResult(
    refId: 'REF-NYX-998877',
    timestamp: DateTime(2026, 5, 18, 11, 0),
  );

  setUpAll(() {
    // Required for mocktail when using matcher arguments like `any()`
    registerFallbackValue(FakeTransferParams());
  });

  setUp(() async {
    // 1. Reset DI locator to ensure clean slate between test runs
    await locator.reset();

    // 2. Instantiate mocks
    mockExecuteTransferUseCase = MockExecuteTransferUseCase();

    // 3. Register within GetIt locator (matching the @injectable pattern)
    locator.registerFactory<ExecuteTransferUseCase>(() => mockExecuteTransferUseCase);

    // 4. Instantiate BLoC, resolving the usecase through locator or constructor
    transferBloc = TransferBloc(executeTransfer: locator<ExecuteTransferUseCase>());
  });

  tearDown(() async {
    // 1. Close BLoC stream to prevent memory leak
    await transferBloc.close();
    
    // 2. Clear all mock registrations
    await locator.reset();
  });

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 3: Initial State Verification
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  group('Initial State', () {
    test('should be TransferInitial', () {
      expect(transferBloc.state, equals(TransferInitial()));
    });
  });

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 4: Events Mapping to States (Success)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  group('SubmitTransferEvent — Success', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferSuccess] when execution succeeds',
      build: () {
        when(() => mockExecuteTransferUseCase(any()))
            .thenAnswer((_) async => Right(tSuccessResult));
        return transferBloc;
      },
      act: (bloc) => bloc.add(SubmitTransferEvent(params: tParams)),
      expect: () => [
        TransferLoading(),
        TransferSuccess(result: tSuccessResult),
      ],
      verify: (_) {
        // Assert dependency was invoked exactly once with appropriate arguments
        verify(() => mockExecuteTransferUseCase(any())).called(1);
      },
    );
  });

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 5: Events Mapping to States (Failures)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  group('SubmitTransferEvent — Failures', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferFailure] when usecase returns ServerFailure',
      build: () {
        when(() => mockExecuteTransferUseCase(any())).thenAnswer(
          (_) async => const Left(ServerFailure('Connection lost with core banking')),
        );
        return transferBloc;
      },
      act: (bloc) => bloc.add(SubmitTransferEvent(params: tParams)),
      expect: () => [
        TransferLoading(),
        const TransferFailure(message: 'Connection lost with core banking'),
      ],
    );

    blocTest<TransferBloc, TransferState>(
      'should emit [TransferLoading, TransferFailure] when usecase returns NetworkFailure',
      build: () {
        when(() => mockExecuteTransferUseCase(any())).thenAnswer(
          (_) async => const Left(NetworkFailure('No Internet Access')),
        );
        return transferBloc;
      },
      act: (bloc) => bloc.add(SubmitTransferEvent(params: tParams)),
      expect: () => [
        TransferLoading(),
        const TransferFailure(message: 'No Internet Access'),
      ],
    );
  });

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 6: Input Validation & Bounds
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  group('SubmitTransferEvent — Validation', () {
    blocTest<TransferBloc, TransferState>(
      'should emit [TransferValidationError] without calling usecase when amount is negative',
      build: () => transferBloc,
      act: (bloc) => bloc.add(
        SubmitTransferEvent(params: tParams.copyWith(amount: -5000)),
      ),
      expect: () => [
        const TransferValidationError(message: 'Amount must be greater than zero'),
      ],
      verify: (_) {
        // Usecase must never be invoked for validation failure scenarios
        verifyNever(() => mockExecuteTransferUseCase(any()));
      },
    );
  });
}
