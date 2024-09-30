import 'package:eskool/users/component/CustomScaffold.dart';
import 'package:eskool/users/component/customAppBar2.dart';
import 'package:eskool/users/forBackend/fetchResult.dart';
import 'package:flutter/material.dart';

class Seeresult extends StatefulWidget {
  final String studentId;
  final String studentName;
  const Seeresult({
    Key? key,
    required this.studentId,
    required this.studentName,
  }) : super(key: key);

  @override
  State<Seeresult> createState() => _SeeresultState();
}

class _SeeresultState extends State<Seeresult> {
  List<dynamic> resultItem = [];
  double totalMarks = 0.0;
  double percentage = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResult(widget.studentId).then((data) {
      setState(() {
        resultItem = data;
        totalMarks =
            resultItem.fold(0, (sum, item) => sum + (item['marks'] ?? 0.0));
        percentage = (totalMarks / resultItem.length);
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error fetching Result: $error')),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 30, 50, 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Name
            Text(
              'Student Name: ${widget.studentName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Result Header
            Text(
              'Result:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),

            // Result List
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator()) // Loading state
                  : ListView.builder(
                      itemCount: resultItem.length,
                      itemBuilder: (context, index) {
                        final item = resultItem[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item['subject'],
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Text(
                            '${item['marks'].toStringAsFixed(2)}', // Consistent 'marks' key
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
            ),

            // Total Marks and Percentage
            Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Marks:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${totalMarks.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Percentage:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(2)}%',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      appBar: customAppBar2("Result of ${widget.studentName}"),
    );
  }
}
