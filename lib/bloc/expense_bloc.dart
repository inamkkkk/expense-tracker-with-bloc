import 'package:bloc/bloc.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/database_helper.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpenses>((event, emit) async {
      emit(ExpenseLoading());
      try {
        final expenses = await DatabaseHelper.instance.getExpenses();
        emit(ExpenseLoaded(expenses));
      } catch (e) {
        emit(ExpenseError('Failed to load expenses: $e'));
      }
    });

    on<AddExpense>((event, emit) async {
      try {
        await DatabaseHelper.instance.insertExpense(event.expense);
        final expenses = await DatabaseHelper.instance.getExpenses();
        emit(ExpenseLoaded(expenses));
      } catch (e) {
        emit(ExpenseError('Failed to add expense: $e'));
      }
    });

    on<DeleteExpense>((event, emit) async {
        try {
          await DatabaseHelper.instance.deleteExpense(event.expense.id!);
          final expenses = await DatabaseHelper.instance.getExpenses();
          emit(ExpenseLoaded(expenses));
        } catch (e) {
          emit(ExpenseError('Failed to delete expense: $e'));
        }
    });
  }
}