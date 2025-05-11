import 'package:flutter_test/flutter_test.dart';
import 'package:practica_test/account/account.dart';
import 'package:practica_test/transaction/transaction.dart';
import 'package:practica_test/bank/bank_service.dart';

void main() {
  group('Account', () {
    test('El balance inicial de una cuenta debe ser cero', () {
      final account = Account('A1');
      expect(account.balance, equals(0));
    });

    test('No se permite depositar cantidades negativas o cero', () {
      final account = Account('A2');
      expect(() => account.deposit(0), throwsArgumentError);
      expect(() => account.deposit(-100), throwsArgumentError);
    });

    test('No se permite retirar cantidades negativas o cero', () {
      final account = Account('A3');
      expect(() => account.withdraw(0), throwsArgumentError);
      expect(() => account.withdraw(-50), throwsArgumentError);
    });
  });

  group('Transaction', () {
    test('DepositTransaction.apply aumenta el saldo correctamente', () {
      final account = Account('A1');
      final tx = DepositTransaction('TX1', 100);
      tx.apply(account);
      expect(account.balance, equals(100));
    });

    test('WithdrawalTransaction.apply lanza StateError cuando no hay fondos', () {
      final account = Account('A2');
      final tx = WithdrawalTransaction('TX2', 50);
      expect(() => tx.apply(account), throwsStateError);
    });

    test('TransferTransaction.apply mueve fondos entre cuentas correctamente', () {
      final source = Account('A3')..deposit(200);
      final dest = Account('A4');
      final tx = TransferTransaction('TX3', 150, dest);
      tx.apply(source);
      expect(source.balance, equals(50));
      expect(dest.balance, equals(150));
    });
  });

  group('BankService', () {
    test('La lista inicial de cuentas está vacía', () {
      final bank = BankService();
      expect(bank.getAllAccounts(), isEmpty);
    });

    test('deposit aumenta el saldo de la cuenta', () {
      final bank = BankService();
      final account = bank.createAccount();
      bank.deposit(account.number, 300);
      expect(bank.getBalance(account.number), equals(300));
    });

    test('withdraw lanza StateError cuando el saldo es insuficiente', () {
      final bank = BankService();
      final account = bank.createAccount();
      expect(() => bank.withdrawal(account.number, 100), throwsStateError);
    });

    test('transfer mueve fondos correctamente', () {
      final bank = BankService();
      final from = bank.createAccount();
      final to = bank.createAccount();
      bank.deposit(from.number, 500);
      bank.transfer(from.number, to.number, 200);
      expect(bank.getBalance(from.number), equals(300));
      expect(bank.getBalance(to.number), equals(200));
    });

    test('transfer lanza StateError cuando los fondos son insuficientes', () {
      final bank = BankService();
      final from = bank.createAccount();
      final to = bank.createAccount();
      expect(() => bank.transfer(from.number, to.number, 50), throwsStateError);
    });

    test('txId genera identificadores únicos', () {
      final bank = BankService();
      final id1 = bank.generateTransactionId();
      final id2 = bank.generateTransactionId();
      expect(id1, isNot(equals(id2)));
    });
  });
}
