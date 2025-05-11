class Account {
  final String number;
  double _balance; //privado

  Account(this.number) : _balance = 0;

  void deposit(double amount) {
    if (amount <= 0) {
      throw ArgumentError("Deposit amount must be positive");
    }
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError("Withdrawal amount must be positive");
    }
    if (_balance < amount) {
      throw StateError("Insufficient funds");
    }
    _balance -= amount;
  }

  double get balance => _balance;
}
