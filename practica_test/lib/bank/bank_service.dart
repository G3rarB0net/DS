import '../account/account.dart';
import '../transaction/transaction.dart';
import 'dart:collection';

class BankService {
  final Map<String, Account> _accounts = {};
  int _accountCounter = 0;
  int _transactionCounter = 0;

  String generateAccountNumber() => 'ES-${_accountCounter++}'; // si hubiera un banco real, se generaría un número de cuenta único con hora del sistema o algo asi
  String generateTransactionId() => 'TX-${_transactionCounter++}';

  Account createAccount() {
    final number = generateAccountNumber();
    final account = Account(number);
    _accounts[number] = account;
    return account;
  }

  void deposit(String accountNumber, double amount) {
    final account = _getAccount(accountNumber);
    final tx = DepositTransaction(generateTransactionId(), amount);
    tx.apply(account);
  }

  void withdrawal(String accountNumber, double amount) {
    final account = _getAccount(accountNumber);
    final tx = WithdrawalTransaction(generateTransactionId(), amount);
    tx.apply(account);
  }

  void transfer(String fromNumber, String toNumber, double amount) {
    final fromAccount = _getAccount(fromNumber);
    final toAccount = _getAccount(toNumber);
    final tx = TransferTransaction(generateTransactionId(), amount, toAccount);
    tx.apply(fromAccount);
  }

  double getBalance(String accountNumber) {
    return _getAccount(accountNumber).balance;
  }

  List<Account> getAllAccounts() {
    return List.unmodifiable(_accounts.values);
  }

  Account _getAccount(String number) {
    final account = _accounts[number];
    if (account == null) {
      throw ArgumentError('Account not found: $number');
    }
    return account;
  }
}
