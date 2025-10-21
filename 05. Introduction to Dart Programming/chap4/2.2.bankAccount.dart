class BankAccount {
  String _accountNumber;
  double _balance;

  BankAccount(this._accountNumber, this._balance) {
    if (_balance < 0) throw Exception("Invalid balance");
  }

  String get accountNumber => _accountNumber;
  double get balance => _balance;

  void deposit(double amount) {
    if (amount <= 0) throw Exception("Invalid deposit amount");
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= 0) throw Exception("Invalid withdraw amount");
    if (_balance < amount) throw Exception("Balance not enough");
    _balance -= amount;
  }
}

void main() {
  var account = BankAccount('123', 20000);
  account.deposit(3000);
  account.withdraw(15000);

  print("Account: ${account._accountNumber}");
  print("Balance: ${account._balance}");
}
