import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SfDataGridDemo(),
    ),
  );
}

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource;
  DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(
      _employees,
      dataGridController,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter SfDataGrid')),
      body: SfDataGrid(
        source: _employeeDataSource,
        controller: dataGridController,
        selectionMode: SelectionMode.multiple,
        columns: [
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('ID'),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Name'),
            ),
          ),
          GridColumn(
            columnName: 'designation',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Designation'),
            ),
          ),
          GridColumn(
            columnName: 'button',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Details '),
            ),
          ),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead '),
      Employee(10002, 'Kathryn', 'Manager'),
      Employee(10003, 'Lara', 'Developer'),
      Employee(10004, 'Michael', 'Designer'),
      Employee(10005, 'Martin', 'Developer'),
      Employee(10006, 'Newberry', 'Developer'),
      Employee(10007, 'Balnc', 'Developer'),
      Employee(10008, 'Perry', 'Developer'),
      Employee(10009, 'Gable', 'Developer'),
      Employee(10010, 'Grimes', 'Developer'),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees, this.controller, this.context) {
    buildDataGridRow(employees);
  }

  void buildDataGridRow(List<Employee> employeeData) {
    dataGridRow =
        employeeData.map<DataGridRow>((employee) {
          return DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'id', value: employee.id),
              DataGridCell<String>(columnName: 'name', value: employee.name),
              DataGridCell<String>(
                columnName: 'designation',
                value: employee.designation,
              ),
              const DataGridCell<Widget>(columnName: 'button', value: null),
            ],
          );
        }).toList();
  }

  DataGridController controller;

  BuildContext context;

  List<DataGridRow> dataGridRow = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => dataGridRow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    bool isSelected = controller.selectedRows.contains(row);

    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((dataGridCell) {
            if (dataGridCell.columnName == 'button') {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (isSelected) {
                      dataGridRow.remove(row);
                      notifyListeners();
                    } else {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text('Employee Details'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'ID: ${row.getCells()[0].value.toString()}',
                                  ),
                                  Text(
                                    'Name: ${row.getCells()[1].value.toString()}',
                                  ),
                                  Text(
                                    'Designation: ${row.getCells()[2].value.toString()}',
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.red : Colors.blue,
                  ),
                  child:
                      isSelected
                          ? const Icon(Icons.delete, color: Colors.white)
                          : const Text('Details'),
                ),
              );
            }
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(dataGridCell.value.toString()),
            );
          }).toList(),
    );
  }
}

class Employee {
  Employee(this.id, this.name, this.designation);
  final int id;
  final String name;
  final String designation;
}
