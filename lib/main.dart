import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

// widget raiz imutável
class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculadoraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//  O StatefulWidget propriamente dito que serve como configuração e é imutável
class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

//  Classe State, que armazena o estado mutável e gerencia a lógica
class _CalculadoraPageState extends State<CalculadoraPage> {
  // Controladores para capturar o texto digitado pelo usuário nos campos de texto
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // variável de estado mutável que guardará o resultado para ser exibido na tela
  String _resultado = "0.0";

  // metodo responsável por fazer o cálculo e atualizar o estado
  void _calcular(String operacao) {
    // Converte os textos digitados para números decimais (double)
    double? num1 = double.tryParse(_num1Controller.text);
    double? num2 = double.tryParse(_num2Controller.text);

    // validação para evitar erros caso o usuário deixe os campos vazios
    if (num1 == null || num2 == null) {
      setState(() {
        _resultado = "Erro: Digite números válidos.";
      });
      return;
    }

    double res = 0.0;

    // lógica das quatro operações básicas
    switch (operacao) {
      case '+':
        res = num1 + num2;
        break;
      case '-':
        res = num1 - num2;
        break;
      case '*':
        res = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          // a chamada ao setState() avisa ao flutter que o estado foi alterado e a tela precisa ser atualizada
          setState(() {
            _resultado = "Erro: Divisão por zero.";
          });
          return;
        }
        res = num1 / num2;
        break;
    }

    // após o cálculo, a lógica da aplicação muda o estado do widget
    // o setState avisa ao Flutter para executar de novo o método build() e reconstruir a UI com o novo valor
    setState(() {
      _resultado = res.toStringAsFixed(2);
    });
  }

  // o método build é chamado responsável por descrever a interface do usuário com base no estado atual
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // campo para o primeiro número
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Primeiro Número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // campo para o segundo número
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Segundo Número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // linha com os botões das operações
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calcular('+'),
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('-'),
                  child: const Text('-', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('*'),
                  child: const Text('x', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('/'),
                  child: const Text('÷', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // exibição do estado atualizado, ou seja, o resultado
            Text(
              'Resultado: $_resultado',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
