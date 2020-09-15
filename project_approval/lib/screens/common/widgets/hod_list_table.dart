import 'package:flutter/material.dart';
import 'package:project_approval/models/hod.dart';
import 'package:project_approval/utils/style.dart';


class HodListTable extends StatelessWidget {
  final List<Hod> hodList;

  HodListTable({this.hodList});

  @override
  Widget build(BuildContext context) {
    return hodList.length != 0
        ? DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            "Name",
            style: dataTableHeaderTextStyle,
          ),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Hod Name",
        ),
        DataColumn(
          label: Text(
            "Email",
            style: dataTableHeaderTextStyle,
          ),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Hod email",
        ),
        DataColumn(
          label: Text(
            "Phone",
            style: dataTableHeaderTextStyle,
          ),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Contact Number",
        ),
        DataColumn(
          label: Text(
            "Branch",
            style: dataTableHeaderTextStyle,
          ),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Hod Branch",
        ),
        DataColumn(
          label: Text(
            "Designation",
            style: dataTableHeaderTextStyle,
          ),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Designation",
        ),
      ],
      rows: hodList.map(
            (hod) {
          return DataRow(cells: <DataCell>[
            DataCell(
              Text('${hod.name}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${hod.email}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${hod.phone}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${hod.branch}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${hod.designation}'),
              showEditIcon: false,
              placeholder: false,
            ),
          ]);
        },
      ).toList(),
    )
        : Center(
      child: Container(
        child: Text("No record found!"),
      ),
    );
  }
}