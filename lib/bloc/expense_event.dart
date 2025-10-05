part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;

  AddExpense(this.expense);
}

class DeleteExpense extends ExpenseEvent {
  final Expense expense;

  DeleteExpense(this.expense);
}