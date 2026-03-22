import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../models/models.dart';

class BookingScreen extends StatefulWidget {
  final SpecialistDoctor doctor;
  const BookingScreen({super.key, required this.doctor});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _date;
  String? _time;
  final _reasonCtrl = TextEditingController();

  final _times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM'
  ];

  String get dateStr {
    if (_date == null) return "Select Date";
    final m = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return "${_date!.day} ${m[_date!.month - 1]} ${_date!.year}";
  }

  Future<void> _pickDate() async {
    final p = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (p != null) setState(() => _date = p);
  }

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      // 🔥 Bottom Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: width * 0.05,
          right: width * 0.05,
          bottom: mq.padding.bottom + 12,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: SC.lavender,
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: (_date != null && _time != null)
              ? () {
                  Navigator.push(
                    context,
                    fadeRoute(
                      ConfirmationScreen(
                        doctor: widget.doctor,
                        date: _date!,
                        time: _time!,
                        reason: _reasonCtrl.text,
                      ),
                    ),
                  );
                }
              : null,
          child: const Text(
            "Confirm Appointment",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600, // optional but looks better
            ),
          ),
          //   child: const Text("Confirm Appointment",style: TextStyle( Colors.white),),
        ),
      ),

      appBar: AppBar(
        title: const Text("Book Appointment"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 👨‍⚕️ Doctor Card
            Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                  )
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.07,
                    backgroundColor: SC.lavLight,
                    child: Text(
                      widget.doctor.initials,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: SC.purpleDark,
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.doctor.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      SizedBox(height: height * 0.005),
                      Text(widget.doctor.speciality,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: height * 0.03),

            /// 📅 Date
            const Text("Select Date",
                style: TextStyle(fontWeight: FontWeight.w600)),

            SizedBox(height: height * 0.012),

            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    SizedBox(width: width * 0.03),
                    Text(
                      dateStr,
                      style: TextStyle(
                        color: _date == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.03),

            /// ⏰ Time
            const Text("Select Time",
                style: TextStyle(fontWeight: FontWeight.w600)),

            SizedBox(height: height * 0.012),

            Wrap(
              spacing: width * 0.025,
              runSpacing: height * 0.015,
              children: _times.map((t) {
                final selected = _time == t;

                return GestureDetector(
                  onTap: () => setState(() => _time = t),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.012,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? SC.purple : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      t,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: height * 0.03),

            /// 📝 Reason
            const Text("Reason (Optional)",
                style: TextStyle(fontWeight: FontWeight.w600)),

            SizedBox(height: height * 0.012),

            TextField(
              controller: _reasonCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Describe your issue...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(width * 0.04),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),

            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}

/// ✅ Confirmation Screen FIXED (no underscore issue)
class ConfirmationScreen extends StatelessWidget {
  final SpecialistDoctor doctor;
  final DateTime date;
  final String time;
  final String reason;

  const ConfirmationScreen({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final dateStr = '${date.day} ${months[date.month - 1]} ${date.year}';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text("Confirmation"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(width * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.25,
                height: width * 0.25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 40),
              ),
              SizedBox(height: height * 0.02),
              const Text("Appointment Confirmed",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text("Your booking is successful",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: height * 0.03),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row("Doctor", doctor.name),
                    _row("Hospital", '${doctor.hospital}, ${doctor.city}'),
                    _row("Date", dateStr),
                    _row("Time", time),
                    if (reason.isNotEmpty) _row("Reason", reason),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
