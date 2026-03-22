import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'booking_screen.dart';

class DoctorProfileScreen extends StatelessWidget {
  final SpecialistDoctor doctor;
  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final d = doctor;
    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Specialist'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      color: SC.lavLight,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                            color: SC.purple.withOpacity(0.15),
                            blurRadius: 16,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Center(
                      child: Text(d.initials,
                          style: const TextStyle(
                              fontSize: 28,
                              color: SC.purpleDark,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(d.name,
                      style: const TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 22,
                          color: SC.purpleDark),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 4),
                  Text(d.speciality,
                      style:
                          const TextStyle(fontSize: 14, color: SC.textMuted)),
                  const SizedBox(height: 10),
                  Wrap(spacing: 8, children: [
                    SarthiBadge(label: '⭐ ${d.rating}', color: SC.amber),
                    SarthiBadge(
                        label: '${d.reviewCount} reviews', color: SC.textMuted),
                  ]),
                  const SizedBox(height: 20),
                  SarthiCard(
                    child: Column(
                      children: [
                        _detailRow(Icons.location_on_rounded, 'Location',
                            '${d.hospital}, ${d.city}'),
                        const Divider(color: SC.border, height: 20),
                        _detailRow(Icons.attach_money_rounded, 'Fee', d.fee),
                        const Divider(color: SC.border, height: 20),
                        _detailRow(Icons.translate_rounded, 'Languages',
                            d.languages.join(', ')),
                        const Divider(color: SC.border, height: 20),
                        _detailRow(Icons.schedule_rounded, 'Availability',
                            d.availability),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SarthiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('SPECIALISATIONS',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: SC.textMuted,
                                letterSpacing: 1)),
                        const SizedBox(height: 12),
                        Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: d.tags
                                .map((t) =>
                                    SarthiBadge(label: t, color: SC.purple))
                                .toList()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SarthiCard(
                    color: SC.lavLight,
                    border: Border.all(color: SC.lavender),
                    child: Row(children: [
                      const Icon(Icons.calendar_today_rounded,
                          color: SC.purple, size: 16),
                      const SizedBox(width: 10),
                      Text('Next Available: ${d.nextSlot}',
                          style: const TextStyle(
                              fontSize: 13,
                              color: SC.purple,
                              fontWeight: FontWeight.w800)),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  SarthiButton(
                    label: 'Book Appointment',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => Navigator.push(
                        context, slideRoute(BookingScreen(doctor: d))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) =>
      Row(children: [
        Icon(icon, size: 16, color: SC.textMuted),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 13, color: SC.textMuted)),
        const Spacer(),
        Flexible(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: SC.textDark),
                textAlign: TextAlign.right)),
      ]);
}
