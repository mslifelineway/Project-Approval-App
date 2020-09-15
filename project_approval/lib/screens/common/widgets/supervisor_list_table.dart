import 'package:flutter/material.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/utils/style.dart';

class SupervisorListTable extends StatelessWidget {
  final List<Supervisor> supervisorList;

  SupervisorListTable({this.supervisorList});

  @override
  Widget build(BuildContext context) {
    return supervisorList.length != 0
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
      rows: supervisorList.map(
            (supervisor) {
          return DataRow(cells: <DataCell>[
            DataCell(
              Text('${supervisor.name}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${supervisor.email}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${supervisor.phone}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${supervisor.branch}'),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text('${supervisor.designation}'),
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
