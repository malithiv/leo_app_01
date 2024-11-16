import 'package:flutter/material.dart';


class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String selectedPaymentMethod = 'Credit Card';
  int selectedPackage = -1;

  final List<Map<String, dynamic>> diamondPackages = [
    {'diamonds': 100, 'price': 500, 'bonus': 0},
    {'diamonds': 500, 'price': 2000, 'bonus': 50},
    {'diamonds': 1000, 'price': 3500, 'bonus': 150},
    {'diamonds': 2000, 'price': 6000, 'bonus': 400},
    {'diamonds': 5000, 'price': 12500, 'bonus': 1250},
    {'diamonds': 10000, 'price': 20000, 'bonus': 3000},
    {'diamonds': 20000, 'price': 35000, 'bonus': 7000},
    {'diamonds': 50000, 'price': 75000, 'bonus': 20000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.purple[400]!, Colors.blue[600]!],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/diamond.png', height: 80),
                      SizedBox(height: 10),
                      Text(
                        '1,234',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Current Balance',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Choose a package',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buildPackageCard(index);
                },
                childCount: diamondPackages.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Payment Method',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildPaymentMethodRadio('Credit Card'),
                  _buildPaymentMethodRadio('PayPal'),
                  _buildPaymentMethodRadio('Google Pay'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedPackage != -1 ? () {
                      // Handle purchase
                    } : null,
                    child: Text('Purchase'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue[700],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(double.infinity, 50),
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

  Widget _buildPackageCard(int index) {
    final package = diamondPackages[index];
    final isSelected = selectedPackage == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackage = index;
        });
      },
      child: Card(
        elevation: isSelected ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.blue[700]! : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/diamond.png', height: 50),
              SizedBox(height: 10),
              Text(
                '${package['diamonds']}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              Text(
                'Diamonds',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${package['price']} LKR',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (package['bonus'] > 0)
                Text(
                  '+${package['bonus']} bonus',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodRadio(String method) {
    return RadioListTile<String>(
      title: Text(method),
      value: method,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value!;
        });
      },
      activeColor: Colors.blue[700],
    );
  }
}