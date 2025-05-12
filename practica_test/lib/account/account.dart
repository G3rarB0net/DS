class Account {
  final String number;
  double _balance; //privado

  Account(this.number) : _balance = 0;

  void deposit(double amount) {
    if (amount <= 0) {
      throw ArgumentError("El monto del depósito debe ser positivo");
    }
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError("El monto del retiro debe ser positivo y mayor de 0");
    }
    if (_balance < amount) {
      throw StateError("El saldo es insuficiente para retirar $amount");
    }
    _balance -= amount;
  }

  double get balance => _balance;
}
