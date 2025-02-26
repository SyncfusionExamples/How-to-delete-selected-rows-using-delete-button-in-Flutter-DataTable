# How to delete selected rows using delete button in Flutter DataTable (SfDataGrid)?.

In this article, we will show you how to delete selected rows using delete button in [Flutter DataTable](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. In the [buildRow](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/buildRow.html) method, display the `Details` and `Delete` buttons based on row selection using the selectedRows list from the [DataGridController](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridController-class.html). When a row is selected, the delete button will appear in the last column. Tapping the delete button removes the corresponding row from [DataGridSource.rows](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/rows.html), and calling [notifyListeners()](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSourceChangeNotifier/notifyListeners.html) refreshes the SfDataGrid to reflect the changes.

```dart
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
```

You can download this example on [GitHub](https://github.com/SyncfusionExamples/How-to-delete-selected-rows-using-delete-button-in-Flutter-DataTable).