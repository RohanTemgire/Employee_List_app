import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/employees.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Employees>(context).getEmployees;
    return data == null
        ? const Center(
            child: Text('No Employees'),
          )
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 2,
                child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 100),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        '${data[index].name}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ),
                                    Text('Age : ${data[index].age}'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Gender : ${data[index].gender}'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '${data[index].yrsInOrganization} Years in Organisation'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '${data[index].isActive} with the Organization'),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${data[index].name}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            data[index].yrsInOrganization >= 5 &&
                                    data[index]
                                            .isActive
                                            .toString()
                                            .toLowerCase() ==
                                        'active'
                                ? const Icon(
                                    Icons.flag,
                                    color: Colors.green,
                                  )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${data[index].yrsInOrganization} Years in Organisation',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black38),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${data[index].isActive} with the Organization',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black38),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
