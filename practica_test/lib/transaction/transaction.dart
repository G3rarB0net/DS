import '../account/account.dart';

abstract class Transaction {
  final String id;
  final double amount;

  Transaction(this.id, this.amount);

  void apply(Account account);
}

class DepositTransaction extends Transaction {
  DepositTransaction(String id, double amount) : super(id, amount);

  @override
  void apply(Account account) {
    account.deposit(amount);
  }
}

class WithdrawalTransaction extends Transaction {
  WithdrawalTransaction(String id, double amount) : super(id, amount);

  @override
  void apply(Account account) {
    account.withdraw(amount);
  }
}

class TransferTransaction extends Transaction {
  final Account destination;

  TransferTransaction(String id, double amount, this.destination) : super(id, amount);

  @override
  void apply(Account source) {
    source.withdraw(amount);
    destination.deposit(amount);
  }
}
