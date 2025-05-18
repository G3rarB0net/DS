import 'package:flutter/material.dart';
import './bank/bank_service.dart';

void main() {
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const BankHomePage(),
    );
  }
}

class BankHomePage extends StatefulWidget {
  const BankHomePage({super.key});

  @override
  State<BankHomePage> createState() => _BankHomePageState();
}

class _BankHomePageState extends State<BankHomePage> {
  final BankService _bankService = BankService();
  String? _selectedAccount;

  void _createAccount() {
    final account = _bankService.createAccount();
    setState(() {
      _selectedAccount = account.number;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red[50],
        title: const Text(
          'Error',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.redAccent),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }


  void _showTransactionDialog(String type) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$type Dinero'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cantidad'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(controller.text) ?? 0;
                if (_selectedAccount != null) {
                  try {
                    setState(() {
                      if (type == 'Depositar') {
                        _bankService.deposit(_selectedAccount!, amount);
                      } else {
                        _bankService.withdrawal(_selectedAccount!, amount);
                      }
                    });
                    Navigator.pop(context);
                  } on ArgumentError catch (e) {
                    _showErrorDialog(e.message.toString());
                  } on StateError catch (e) {
                    _showErrorDialog(e.message.toString());
                  } catch (e) {
                    _showErrorDialog('Ocurrió un error inesperado: $e');
                  }
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showTransferDialog() {
    final controller = TextEditingController();
    String? toAccount;
    final accounts = _bankService.getAllAccounts()
        .where((a) => a.number != _selectedAccount)
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Transferir Dinero'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                hint: const Text('Cuenta destino'),
                isExpanded: true,
                value: toAccount,
                items: accounts.map((acc) {
                  return DropdownMenuItem(
                    value: acc.number,
                    child: Text(acc.number),
                  );
                }).toList(),
                onChanged: (value) => setState(() => toAccount = value),
              ),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cantidad'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(controller.text) ?? 0;
                if (_selectedAccount != null && toAccount != null && amount > 0) {
                  setState(() {
                    //Comprobar que la cuenta tiene saldo suficiente====================================================
                    _bankService.transfer(_selectedAccount!, toAccount!, amount);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Transferir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accounts = _bankService.getAllAccounts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bank'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _createAccount,
              icon: const Icon(Icons.account_box),
              label: const Text('Crear Cuenta'),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              hint: const Text('Selecciona una cuenta'),
              value: _selectedAccount,
              isExpanded: true,
              items: accounts.map((account) {
                return DropdownMenuItem(
                  value: account.number,
                  child: Text('${account.number} - \$${account.balance.toStringAsFixed(2)}'),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedAccount = value),
            ),
            const SizedBox(height: 24),
            if (_selectedAccount != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _showTransactionDialog('Depositar'),
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text('Depositar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showTransactionDialog('Retirar'),
                    icon: const Icon(Icons.arrow_upward),
                    label: const Text('Retirar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showTransferDialog,
                    icon: const Icon(Icons.compare_arrows),
                    label: const Text('Transferir'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
