import 'package:flutter/material.dart';
import 'package:qr_code/Widgets/button.dart';
import 'package:qr_code/user_role.dart' as UserRoles;
import '../sheets_api.dart';

class QrResultPage extends StatefulWidget {
  final VoidCallback closeScreen;
  final String qrResult;
  final UserRoles.UserRole userRole;

  const QrResultPage({
    Key? key,
    required this.closeScreen,
    required this.qrResult,
    required this.userRole,
  }) : super(key: key);

  @override
  _QrResultPageState createState() => _QrResultPageState();
}

class _QrResultPageState extends State<QrResultPage> {
  Map<String, dynamic>? studentData;
  bool isDataLoaded = false;
  String? attendanceStatus;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  void fetchStudentData() async {
    setState(() {
      isDataLoaded = false;
    });

    Map<String, dynamic>? data = await SheetsApi.getSpreadsheetData(widget.qrResult);
    setState(() {
      if (data != null) {
        studentData = data;
        attendanceStatus = data.values.first['Status'];
      }
      isDataLoaded = true;
    });
  }

  void updateAttendance() async {
    if (attendanceStatus == 'null') {
      await SheetsApi.updateAttendance(widget.qrResult);
      fetchStudentData();
    }
  }

  void updateTestAttendance() async {
    if (attendanceStatus == 'Present') {
      await SheetsApi.updateTestAttendance(widget.qrResult);
      fetchStudentData();
    }
  }

  void updateInterviewAttendance() async {
    if (attendanceStatus == 'Test Attended') {
      await SheetsApi.updateInterviewAttendance(widget.qrResult);
      fetchStudentData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Details',
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    if (isDataLoaded && studentData != null)
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundImage: NetworkImage('${studentData!.values.first['Image'] ?? ''}'),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFF1B61A9), width: 2),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  buildDetailRow('Appl Number', '${studentData!.values.first['ApplicationNumber']}'),
                                  buildDetailRow('Serial Number', '${studentData!.values.first['SerialNumber']}'),
                                  buildDetailRow('Category', '${studentData!.values.first['Category']}'),
                                  buildDetailRow('Name', '${studentData!.values.first['Name']}'),
                                  buildDetailRow('Aadhar/Passport', '${studentData!.values.first['AadharNumber']}'),
                                  buildDetailRow('Interview Date', '${studentData!.values.first['InterviewDate']}'),
                                  buildDetailRow('Interview Time', '${studentData!.values.first['InterviewTime']}'),
                                  buildDetailRow('Batch', '${studentData!.values.first['Batch']}'),
                                  buildDetailRow('Test Venue', '${studentData!.values.first['TestVenue']}'),
                                  SizedBox(height: 10),
                                  if (attendanceStatus != null && attendanceStatus == 'Present')
                                    buildDetailRow('Present', '${studentData!.values.first['AppearedWhen']}'),
                                  if (attendanceStatus == 'Test Attended')
                                    Column(
                                      children: [
                                        buildDetailRow('Present', '${studentData!.values.first['AppearedWhen']}'),
                                        buildDetailRow('Test ', '${studentData!.values.first['TestWhen']}'),
                                      ],
                                    ),
                                  if (attendanceStatus == 'Interview Attended')
                                    Column(
                                      children: [
                                        buildDetailRow('Present', '${studentData!.values.first['AppearedWhen']}'),
                                        buildDetailRow('Test', '${studentData!.values.first['TestWhen']}'),
                                        buildDetailRow('Interview', '${studentData!.values.first['InterviewedOn']}'),
                                      ],
                                    ),
                                  SizedBox(height: 10),
                                  if (widget.userRole == UserRoles.UserRole.Verifier && attendanceStatus == 'null')
                                    Column(
                                      children: [
                                        MyButton(
                                          text: "Mark Attendance",
                                          onPressed: updateAttendance,
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 45),
                                      ],
                                    ),
                                  if (widget.userRole == UserRoles.UserRole.Proctor && attendanceStatus == 'Present')
                                    Column(
                                      children: [
                                        MyButton(
                                          text: "Mark Test Attendance",
                                          onPressed: updateTestAttendance,
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 45),
                                      ],
                                    ),
                                  if (widget.userRole == UserRoles.UserRole.Interviewer && attendanceStatus == 'Test Attended')
                                    Column(
                                      children: [
                                        MyButton(
                                          text: "Mark Interview Attendance",
                                          onPressed: updateInterviewAttendance,
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 45),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (isDataLoaded && studentData == null)
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Bad Request, Scan Again',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      CircularProgressIndicator(),

                    if (isDataLoaded &&
                        studentData != null &&
                        studentData!.values.first.containsKey('Panel') &&
                        studentData!.values.first['Panel'] != 'null')
                      Positioned(
                        top: 5,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,  // Set the desired background color
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '${studentData!.values.first['Panel']}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
