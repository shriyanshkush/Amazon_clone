
import 'package:flutter/material.dart';

import '../../../common/widgets/loader.dart';
import '../models/sales.dart';
import '../services/admin_services.dart';
import '../widgets/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getearnings();
  }

  void getearnings() async{
    var EarningData=await adminServices.getEarnings(context);
    print(EarningData.toString());

    totalSales=EarningData['totalEarnigs'];
    earnings=EarningData['sales'];

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? Loader()
        : Column(
      children: [
        Text(
          '\$$totalSales',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 250,
          child: CategoryProductsChart(
            salesData: earnings!,
          ),
        ),
      ],
    );
  }
}
