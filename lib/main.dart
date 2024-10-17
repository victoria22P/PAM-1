import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CurrencyConverterPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  String fromCurrency = 'MDL'; // Currency to convert from
  String toCurrency = 'USD'; // Currency to convert to
  double amount = 0; // Amount to convert
  double convertedAmount = 0.0; // Result of conversion
  double exchangeRate = 0.052; // Hardcoded exchange rate for MDL to USD

  TextEditingController convertedAmountController = TextEditingController(); // Controller for the converted amount TextField

  @override
  void initState() {
    super.initState();
    fetchExchangeRate(); // Set initial conversion
  }

  void fetchExchangeRate() {
    setState(() {
      // Fetch and update the exchange rate based on selected currencies
      if (fromCurrency == 'MDL' && toCurrency == 'USD') {
        exchangeRate = 0.052; // Example: 1 MDL = 0.052 USD
      } else if (fromCurrency == 'USD' && toCurrency == 'MDL') {
        exchangeRate = 1 / 0.052; // Example: 1 USD = 19.23 MDL
      }
      convertedAmount = amount * exchangeRate; // Calculate converted amount
      convertedAmountController.text = convertedAmount.toStringAsFixed(2); // Update the controller text
    });
  }

  void swapCurrencies() {
    setState(() {
      // Swap the currencies
      String tempCurrency = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = tempCurrency;

      // Recalculate based on the new currencies
      fetchExchangeRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
        ),
      ),
      body: Container(
        color: const Color(0xFFF2F2F2), // Background color
        child: Column(
          children: [
            const SizedBox(height: 43),
            const Text(
              'Currency Converter',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Color(0xFF1F2261), // Header text color
              ),
            ),
            const SizedBox(height: 42),
            Center(
              child: Container(
                width: 347,
                child: Card(
                  elevation: 20,
                  color: Color(0xFFFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Currency input field for the 'from' currency
                        Padding(
                          padding: EdgeInsets.only(top: 17, left: 22),
                          child: Row(
                            children: [
                              Image.asset(
                                fromCurrency == 'MDL'
                                    ? 'assets/flag-moldova.png'
                                    : 'assets/flag-usa.png',
                                width: 48,
                                height: 45,
                              ),
                              const Spacer(),
                              Text(fromCurrency,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF1F2261), // Currency label color
                                  )),
                              IconButton(
                                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1F2261)), // Mint green color for icon
                                  onPressed: () {}),
                              const Spacer(),
                              Container(
                                width: 120,
                                height: 45,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      amount = double.tryParse(value) ?? 0.0; // Parse input amount
                                      fetchExchangeRate(); // Update conversion
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Swap currencies button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFFE7E7EE),
                                  thickness: 2,
                                ),
                              ),
                              Container(
                                width: 47,
                                height: 47,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1F2261), // Background color for the button
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.swap_vert,
                                    color: Colors.white, // Icon color
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    swapCurrencies(); // Swap currencies when pressed
                                  },
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFFE7E7EE),
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Currency input field for the 'to' currency
                        Padding(
                          padding: EdgeInsets.only(top: 17, left: 22),
                          child: Row(
                            children: [
                              Image.asset(
                                toCurrency == 'USD'
                                    ? 'assets/flag-usa.png'
                                    : 'assets/flag-moldova.png',
                                width: 48,
                                height: 45,
                              ),
                              const Spacer(),
                              Text(toCurrency,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF1F2261), // Currency label color
                                  )),
                              IconButton(
                                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF1F2261)), // Mint green color for icon
                                  onPressed: () {}),
                              const Spacer(),
                              Container(
                                width: 120,
                                height: 45,
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  readOnly: true, // Read-only for converted amount
                                  controller: convertedAmountController
                                    ..text = convertedAmount.toStringAsFixed(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 45),
              child: Row(
                children: [
                  Text(
                    'Indicative Exchange Rate',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      color: Color(0xFFA1A1A1), // Text color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // Display exchange rate
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF1F2261), // Background color for exchange rate container
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '1 $fromCurrency = ${exchangeRate.toStringAsFixed(4)} $toCurrency',
                    style: const TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
