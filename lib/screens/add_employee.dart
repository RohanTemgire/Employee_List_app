import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/employee.dart';
import '../models/employees.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  var _selectGenderValue;
  var _selectActiveValue;


  var _employee = Employee(
      id: '', name: '', age: 0, gender: '', yrsInOrganization: 0, isActive: '');

  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    Future<void> _saveForm() async {
      final isValid = _form.currentState!.validate();

      if (!isValid) {
        return;
      }

      _form.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<Employees>(context, listen: false)
            .addEmployee(_employee);
      } catch (err) {
        return await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error has been occurred!!'),
            content: const Text('Something went Wrong!!'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay'))
            ],
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Zylu Employees List'),
          actions: [
            IconButton(
                onPressed: _saveForm, icon: const Icon(Icons.done_rounded))
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          decoration: const InputDecoration(
                              labelText: 'Name of Employee',
                              errorBorder: InputBorder.none),
                          onSaved: (val) {
                            _employee = Employee(
                                id: _employee.id,
                                name: val.toString(),
                                age: _employee.age,
                                gender: _employee.gender,
                                yrsInOrganization: _employee.yrsInOrganization,
                                isActive: _employee.isActive);
                          },
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    const InputDecoration(labelText: 'Age'),
                                onSaved: (val) {
                                  _employee = Employee(
                                      id: _employee.id,
                                      name: _employee.name,
                                      age: int.parse(val.toString()),
                                      gender: _employee.gender,
                                      yrsInOrganization:
                                          _employee.yrsInOrganization,
                                      isActive: _employee.isActive);
                                },
                                validator: (val) {
                                  if (val.toString().isEmpty) {
                                    return 'Please Enter Age';
                                  }
                                  if (double.tryParse(val.toString()) == null) {
                                    return 'Enter a valid Age';
                                  }
                                  if (double.parse(val.toString()) <= 16) {
                                    return 'Value greater than 16';
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  label: const Text('Select Gender'),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) =>
                                    value == null ? "Select a gender" : null,
                                value: _selectGenderValue,
                                onChanged: (newValue) {
                                  _selectGenderValue = newValue;
                                },
                                onSaved: (val) {
                                  _selectGenderValue = val.toString();
                                  _employee = Employee(
                                      id: _employee.id,
                                      name: _employee.name,
                                      age: _employee.age,
                                      gender: _selectGenderValue,
                                      yrsInOrganization:
                                          _employee.yrsInOrganization,
                                      isActive: _employee.isActive);
                                },
                                items: const [
                                  DropdownMenuItem(
                                    child: Text('Male'),
                                    value: 'Male',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Female'),
                                    value: 'Female',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Other'),
                                    value: 'Other',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          // controller: _yrsInOrganizationController,
                          decoration: const InputDecoration(
                            labelText: 'Year\'s in Organization',
                          ),
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return 'Please Enter valid number';
                            }
                            if (double.tryParse(val.toString()) == null) {
                              return 'Enter a valid number';
                            }
                            if (double.parse(val.toString()) <= 0) {
                              return 'plz enter value greater than 0';
                            }
                          },
                          onSaved: (val) {
                            _employee = Employee(
                                id: _employee.id,
                                name: _employee.name,
                                age: _employee.age,
                                gender: _employee.gender,
                                yrsInOrganization: int.parse(val.toString()),
                                isActive: _employee.isActive);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              label: const Text('Select Active/Inactive'),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) =>
                              value == null ? "Select this field" : null,
                          value: _selectActiveValue,
                          onChanged: (newValue) {
                            // setState(() {
                            //   _selectActiveValue = newValue;
                            // });
                            _selectActiveValue = newValue;
                          },
                          onSaved: (val) {
                            _selectActiveValue = val.toString();
                            _employee = Employee(
                                id: _employee.id,
                                name: _employee.name,
                                age: _employee.age,
                                gender: _employee.gender,
                                yrsInOrganization: _employee.yrsInOrganization,
                                isActive: _selectActiveValue);
                          },
                          items: const [
                            DropdownMenuItem(
                              child: Text('Active'),
                              value: 'Active',
                            ),
                            DropdownMenuItem(
                              child: Text('Inactive'),
                              value: 'Inactive',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
