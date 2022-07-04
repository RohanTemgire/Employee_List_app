import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/employees.dart';
import '../screens/add_employee.dart';
import '../widgets/card_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  //is init is set so that in didChangeDependencies the getEmployee method is not run everytime.
  var _isinit = true;
  var employees = Employees();

  @override
  void initState() {

    super.initState();
    employees.initializeDatabase().then((_) {
      // print('-----------------database initialized------');
    });
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    if (_isinit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Employees>(context).getEmployee().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isinit = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Zylu Employees List'),
          centerTitle: false,
        ),
        
        body: const CardView(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const AddEmployee())),
            splashColor: Colors.cyan,
            label: const Text('Add'),
            icon: const Icon(Icons.add)),
      ),
    );
  }
}
