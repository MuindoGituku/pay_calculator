import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pay Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String numHours = "0";
  String hourRate = "0";
  String regularPay = "0";
  String overtimePay = "0";
  String totalPay = "0";
  String tax = "0";

  calculatePay() {
    double numHoursDouble = double.parse(numHours);
    double hourRateDouble = double.parse(hourRate);
    double regularPayDouble = double.parse(regularPay);
    double overtimePayDouble = double.parse(overtimePay);
    double totalPayDouble = double.parse(totalPay);
    double taxDouble = double.parse(tax);

    if (numHoursDouble <= 40) {
      totalPayDouble = numHoursDouble * hourRateDouble;
      taxDouble = totalPayDouble * 0.18;

      setState(() {
        regularPay = totalPayDouble.toStringAsFixed(2);
        totalPay = totalPayDouble.toStringAsFixed(2);
        tax = taxDouble.toStringAsFixed(2);
        overtimePay = "0.00";
      });
    } else {
      int hoursOver40 = (numHoursDouble - 40).toInt();
      overtimePayDouble = hoursOver40 * hourRateDouble * 1.5;
      regularPayDouble = 40 * hourRateDouble;
      taxDouble = (overtimePayDouble + regularPayDouble) * 0.18;
      totalPayDouble = overtimePayDouble + regularPayDouble;

      setState(() {
        regularPay = regularPayDouble.toStringAsFixed(2);
        overtimePay = overtimePayDouble.toStringAsFixed(2);
        totalPay = totalPayDouble.toStringAsFixed(2);
        tax = taxDouble.toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => setState(() => numHours = value),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter an amount.";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Number of Hours",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => setState(() => hourRate = value),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your rate.";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Hourly Rate",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => calculatePay(),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 50),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Report",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            height: 2,
                          ),
                        ),
                        Text(
                          "Regular Pay: CAD\$ $regularPay",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            height: 2,
                          ),
                        ),
                        Text(
                          "Overtime Pay: CAD\$ $overtimePay",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            height: 2,
                          ),
                        ),
                        Text(
                          "Total Pay: CAD\$ $totalPay",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            height: 2,
                          ),
                        ),
                        Text(
                          "Tax: CAD\$ $tax",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Name: Muindo N. Gituku",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "College ID: 301372521",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
