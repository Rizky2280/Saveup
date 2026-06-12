import 'package:flutter_test/flutter_test.dart';
import 'package:saveup/features/simulation/domain/models/models.dart';
import 'package:saveup/features/simulation/domain/services/services.dart';

void main() {
  const calculator = SimulationCalculator();
  final now = DateTime(2026, 5, 15);

  test(
    'returns realistic state when required monthly saving fits available savings power',
    () {
      final result = calculator.calculate(
        SimulationInput(
          targetAmount: 6800000,
          targetMonth: DateTime(2026, 8, 20),
          initialSavings: 6200000,
          userSavingsPower: 300000,
          now: now,
        ),
      );

      expect(result.remainingAmount, 600000);
      expect(result.remainingMonths, 3);
      expect(result.requiredMonthlySaving, 200000);
      expect(result.totalActiveGoalsMonthlyCommitment, 0);
      expect(result.availableSavingsPower, 300000);
      expect(result.state, SimulationState.realistic);
    },
  );

  test(
    'returns optimistic state when required monthly saving exceeds available savings power',
    () {
      final result = calculator.calculate(
        SimulationInput(
          targetAmount: 6800000,
          targetMonth: DateTime(2026, 6, 2),
          initialSavings: 1200000,
          userSavingsPower: 740000,
          now: now,
        ),
      );

      expect(result.remainingAmount, 5600000);
      expect(result.remainingMonths, 1);
      expect(result.requiredMonthlySaving, 5600000);
      expect(result.availableSavingsPower, 740000);
      expect(result.state, SimulationState.optimistic);
    },
  );

  test('rounds up required monthly saving and active goal commitments', () {
    final result = calculator.calculate(
      SimulationInput(
        targetAmount: 1000,
        targetMonth: DateTime(2026, 7, 30),
        initialSavings: 0,
        userSavingsPower: 1000,
        activeGoals: [
          ActiveGoalSnapshot(
            targetAmount: 1000,
            currentSavings: 0,
            targetMonth: DateTime(2026, 7, 12),
          ),
        ],
        now: now,
      ),
    );

    expect(result.remainingMonths, 2);
    expect(result.requiredMonthlySaving, 500);
    expect(result.totalActiveGoalsMonthlyCommitment, 500);
    expect(result.availableSavingsPower, 500);
    expect(result.state, SimulationState.realistic);
  });

  test('treats current month target as one remaining month', () {
    final result = calculator.calculate(
      SimulationInput(
        targetAmount: 500000,
        targetMonth: DateTime(2026, 5, 31),
        initialSavings: 0,
        userSavingsPower: 500000,
        now: now,
      ),
    );

    expect(result.remainingMonths, 1);
    expect(result.requiredMonthlySaving, 500000);
    expect(result.state, SimulationState.realistic);
  });

  test('throws for past target month', () {
    expect(
      () => calculator.calculate(
        SimulationInput(
          targetAmount: 500000,
          targetMonth: DateTime(2026, 4, 30),
          initialSavings: 0,
          userSavingsPower: 500000,
          now: now,
        ),
      ),
      throwsA(isA<ArgumentError>()),
    );
  });

  test(
    'subtracts existing active goals commitments from available savings power',
    () {
      final result = calculator.calculate(
        SimulationInput(
          targetAmount: 2400000,
          targetMonth: DateTime(2026, 8, 1),
          initialSavings: 0,
          userSavingsPower: 1000000,
          activeGoals: [
            ActiveGoalSnapshot(
              targetAmount: 900000,
              currentSavings: 0,
              targetMonth: DateTime(2026, 8, 1),
            ),
            ActiveGoalSnapshot(
              targetAmount: 600000,
              currentSavings: 0,
              targetMonth: DateTime(2026, 6, 1),
            ),
            ActiveGoalSnapshot(
              targetAmount: 100000,
              currentSavings: 100000,
              targetMonth: DateTime(2026, 8, 1),
            ),
            ActiveGoalSnapshot(
              targetAmount: 400000,
              currentSavings: 0,
              targetMonth: DateTime(2026, 4, 1),
            ),
          ],
          now: now,
        ),
      );

      expect(result.totalActiveGoalsMonthlyCommitment, 900000);
      expect(result.availableSavingsPower, 100000);
      expect(result.requiredMonthlySaving, 800000);
      expect(result.state, SimulationState.optimistic);
    },
  );

  test('keeps negative available savings power and marks optimistic', () {
    final result = calculator.calculate(
      SimulationInput(
        targetAmount: 1000000,
        targetMonth: DateTime(2026, 6, 1),
        initialSavings: 900000,
        userSavingsPower: 100000,
        activeGoals: [
          ActiveGoalSnapshot(
            targetAmount: 300000,
            currentSavings: 0,
            targetMonth: DateTime(2026, 5, 1),
          ),
        ],
        now: now,
      ),
    );

    expect(result.totalActiveGoalsMonthlyCommitment, 300000);
    expect(result.availableSavingsPower, -200000);
    expect(result.requiredMonthlySaving, 100000);
    expect(result.state, SimulationState.optimistic);
  });

  test('uses defensive realistic result when remaining amount is zero', () {
    final result = calculator.calculate(
      SimulationInput(
        targetAmount: 1000000,
        targetMonth: DateTime(2026, 7, 1),
        initialSavings: 1000000,
        userSavingsPower: 100000,
        now: now,
      ),
    );

    expect(result.remainingAmount, 0);
    expect(result.remainingMonths, 2);
    expect(result.requiredMonthlySaving, 0);
    expect(result.state, SimulationState.realistic);
  });
}
