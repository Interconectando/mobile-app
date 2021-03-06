import 'package:flutter/material.dart';
import 'package:support_app/routes/IssueList.dart';
import 'package:support_app/utils/helpers.dart';
import 'package:support_app/widgets/detail_view.dart';
import 'package:support_app/widgets/filter_list.dart';

Map wireframe = {
  "appBarTitle": "Issue Detail",
  "doctype": "Issue",
  "grids": [
    {
      "header": "header",
      "widget": {
        "fieldtype": "Link",
        "refDoctype": 'Issue',
        "hint": 'Issue Type',
        "doctype": 'Issue Type',
        "fieldname": 'issue_type',
        "in_standard_filter": true
      }
    },
    {
      "header": "header",
      "widget": {
        "fieldtype": "Link",
        "refDoctype": 'Issue',
        "hint": 'Issue Priority',
        "doctype": 'Issue Priority',
        "fieldname": 'priority'
      },
    },
    {
      "header": "header",
      "widget": {
        "fieldtype": "Select",
        "fieldname": 'status',
        "hint": "Issue Status"
      },
    },
    {
      "header": "header",
      "widget": {
        "fieldtype": "Select",
        "fieldname": 'agreement_fulfilled',
        "hint": "SLA"
      },
    }
  ]
};

class IssueDetail extends StatefulWidget {
  final String name;

  const IssueDetail(this.name);

  @override
  _IssueDetailState createState() => _IssueDetailState();
}

class _IssueDetailState extends State<IssueDetail> {
  Future futureProcessedData;

  @override
  void initState() {
    super.initState();
    futureProcessedData = processData(wireframe);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureProcessedData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DetailView(
              doctype: 'Issue',
              name: widget.name,
              wireframe: wireframe,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}

class FilterIssue extends StatefulWidget {
  @override
  _FilterIssueState createState() => _FilterIssueState();
}

class _FilterIssueState extends State<FilterIssue> {
  Future futureProcessedData;

  @override
  void initState() {
    super.initState();
    futureProcessedData = processData(wireframe);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureProcessedData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FilterList(
              filterCallback: (f) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IssueList(f);
                }));
              },
              wireframe: wireframe,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}
