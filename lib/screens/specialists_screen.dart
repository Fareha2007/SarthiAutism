import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/screens/doctor_profile_screen.dart';
import '../utils/colors.dart';
import '../widgets/widgets.dart';
import '../models/app_model.dart';
import '../data/static_data.dart' as data;
import 'package:sarthi_flutter_project/models/app_model.dart';

class SpecialistsScreen extends StatefulWidget {
  const SpecialistsScreen({super.key});

  @override
  State<SpecialistsScreen> createState() => _SpecialistsScreenState();
}

class _SpecialistsScreenState extends State<SpecialistsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchCtrl = TextEditingController();
  String _search = '';
  String _activeFilter = 'All';
  String _location = 'All India';

  static const _doctorFilters = [
    'All',
    'Paediatrician',
    'Neurologist',
    'Psychiatrist',
    'Govt',
    'Free'
  ];
  static const _therapistFilters = [
    'All',
    'Speech',
    'OT',
    'ABA',
    'Behaviour',
    'Online'
  ];
  static const _hospitalFilters = [
    'All',
    'Govt',
    'NGO',
    'Private',
    'Free OPD',
    'Inpatient'
  ];
  static const _schoolFilters = [
    'All',
    'Special',
    'Inclusive',
    'Residential',
    'CBSE',
    'RTE'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) setState(() => _activeFilter = 'All');
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  List<String> get _currentFilters => [
        _doctorFilters,
        _therapistFilters,
        _hospitalFilters,
        _schoolFilters,
      ][_tabController.index];

  bool _matchLoc(String city, String state) {
    if (_location == 'All India') return true;
    return city.toLowerCase().contains(_location.toLowerCase()) ||
        state.toLowerCase().contains(_location.toLowerCase());
  }

  List<SpecialistDoctor> get _doctors => data.SpecialistData.doctors.where((d) {
        if (!_matchLoc(d.city, d.state)) return false;
        if (_search.isNotEmpty) {
          final q = _search.toLowerCase();
          if (![d.name, d.speciality, d.city, d.hospital]
              .any((s) => s.toLowerCase().contains(q))) return false;
        }
        switch (_activeFilter) {
          case 'Govt':
            return d.isGovt;
          case 'Free':
            return d.isFree;
          case 'Paediatrician':
            return d.speciality.toLowerCase().contains('paediatrician');
          case 'Neurologist':
            return d.speciality.toLowerCase().contains('neurologist');
          case 'Psychiatrist':
            return d.speciality.toLowerCase().contains('psychiatrist');
          default:
            return true;
        }
      }).toList();

  List<Therapist> get _therapists => data.SpecialistData.therapists.where((t) {
        if (!_matchLoc(t.city, t.state)) return false;
        if (_search.isNotEmpty) {
          final q = _search.toLowerCase();
          if (![t.name, t.type, t.city].any((s) => s.toLowerCase().contains(q)))
            return false;
        }
        switch (_activeFilter) {
          case 'Speech':
            return t.type.toLowerCase().contains('speech');
          case 'OT':
            return t.type.toLowerCase().contains('occupational');
          case 'ABA':
            return t.type.toLowerCase().contains('aba');
          case 'Behaviour':
            return t.type.toLowerCase().contains('behaviour');
          case 'Online':
            return t.offersOnline;
          default:
            return true;
        }
      }).toList();

  List<SpecialistHospital> get _hospitals =>
      data.SpecialistData.hospitals.where((h) {
        if (!_matchLoc(h.city, h.state)) return false;
        if (_search.isNotEmpty) {
          final q = _search.toLowerCase();
          if (![h.name, h.city].any((s) => s.toLowerCase().contains(q)))
            return false;
        }
        switch (_activeFilter) {
          case 'Govt':
            return h.isGovt;
          case 'NGO':
            return h.type == 'NGO';
          case 'Private':
            return h.type == 'Private';
          case 'Free OPD':
            return h.isFree;
          case 'Inpatient':
            return h.hasInpatient;
          default:
            return true;
        }
      }).toList();

  List<SpecialistSchool> get _schools => data.SpecialistData.schools.where((s) {
        if (!_matchLoc(s.city, s.state)) return false;
        if (_search.isNotEmpty) {
          final q = _search.toLowerCase();
          if (![s.name, s.city].any((x) => x.toLowerCase().contains(q)))
            return false;
        }
        switch (_activeFilter) {
          case 'Special':
            return s.type == 'Special';
          case 'Inclusive':
            return s.type == 'Inclusive';
          case 'Residential':
            return s.isResidential;
          case 'CBSE':
            return s.board == 'CBSE';
          case 'RTE':
            return s.isRTE;
          default:
            return true;
        }
      }).toList();

  @override
  Widget build(BuildContext context) {
    final counts = [
      _doctors.length,
      _therapists.length,
      _hospitals.length,
      _schools.length
    ];
    final count = counts[_tabController.index];

    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Find Specialist', showBack: false),
          _buildSearch(),
          _buildTabBar(),
          _buildFilterRow(),
          _buildLocationBar(count),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDoctorList(),
                _buildTherapistList(),
                _buildHospitalList(),
                _buildSchoolList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SC.border),
          ),
          child: TextField(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _search = v),
            style: const TextStyle(fontSize: 14, color: SC.textDark),
            decoration: InputDecoration(
              hintText: 'Search name, city, speciality...',
              hintStyle: const TextStyle(fontSize: 14, color: SC.textMuted),
              prefixIcon: const Icon(Icons.search_rounded,
                  size: 18, color: SC.textMuted),
              suffixIcon: _search.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close_rounded,
                          size: 16, color: SC.textMuted),
                      onPressed: () {
                        _searchCtrl.clear();
                        setState(() => _search = '');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      );

  Widget _buildTabBar() => TabBar(
        controller: _tabController,
        isScrollable: false,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(width: 2.5, color: SC.purple),
          insets: const EdgeInsets.symmetric(horizontal: 12),
        ),
        labelColor: SC.purple,
        unselectedLabelColor: SC.textMuted,
        labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(
              icon: Icon(Icons.medical_services_rounded, size: 16),
              text: 'Doctors'),
          Tab(
              icon: Icon(Icons.psychology_rounded, size: 16),
              text: 'Therapists'),
          Tab(
              icon: Icon(Icons.local_hospital_rounded, size: 16),
              text: 'Centres'),
          Tab(icon: Icon(Icons.school_rounded, size: 16), text: 'Schools'),
        ],
        onTap: (_) => setState(() => _activeFilter = 'All'),
      );

  Widget _buildFilterRow() => SizedBox(
        height: 38,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
          itemCount: _currentFilters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final f = _currentFilters[i];
            final active = f == _activeFilter;
            return GestureDetector(
              onTap: () => setState(() => _activeFilter = f),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: active ? SC.purple : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: active ? SC.purple : SC.border),
                ),
                child: Text(f,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: active ? Colors.white : SC.textMuted)),
              ),
            );
          },
        ),
      );

  Widget _buildLocationBar(int count) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
      child: Row(children: [
        const Icon(Icons.location_on_rounded, size: 14, color: SC.purple),
        const SizedBox(width: 4),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _location,
            isDense: true,
            style: const TextStyle(
                fontSize: 13, color: SC.textDark, fontWeight: FontWeight.w500),
            items: data.SpecialistData.locationFilters
                .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                .toList(),
            onChanged: (v) => setState(() => _location = v!),
          ),
        ),
        const Spacer(),
        Text('$count found',
            style: const TextStyle(fontSize: 12, color: SC.textMuted)),
      ]),
    );
  }

  // ── DOCTORS ──────────────────────────────────────────────────────────────
  Widget _buildDoctorList() {
    if (_doctors.isEmpty) return _empty();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _doctors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _DoctorCard(doctor: _doctors[i]),
    );
  }

  // ── THERAPISTS ────────────────────────────────────────────────────────────
  Widget _buildTherapistList() {
    if (_therapists.isEmpty) return _empty();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _therapists.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _TherapistCard(therapist: _therapists[i]),
    );
  }

  // ── HOSPITALS ─────────────────────────────────────────────────────────────
  Widget _buildHospitalList() {
    if (_hospitals.isEmpty) return _empty();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _hospitals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _HospitalCard(hospital: _hospitals[i]),
    );
  }

  // ── SCHOOLS ───────────────────────────────────────────────────────────────
  Widget _buildSchoolList() {
    if (_schools.isEmpty) return _empty();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _schools.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _SchoolCard(school: _schools[i]),
    );
  }

  Widget _empty() => const Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.search_off_rounded, size: 48, color: SC.textMuted),
          SizedBox(height: 12),
          Text('No results found',
              style: TextStyle(fontSize: 15, color: SC.textMuted)),
          SizedBox(height: 4),
          Text('Try changing filters or location',
              style: TextStyle(fontSize: 13, color: SC.textMuted)),
        ]),
      );
}

// ── DOCTOR CARD ──────────────────────────────────────────────────────────────
class _DoctorCard extends StatelessWidget {
  final SpecialistDoctor doctor;
  const _DoctorCard({required this.doctor});

  // @override
  // Widget build(BuildContext context) => SarthiCard(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DoctorProfileScreen(doctor: doctor))),
        child: SarthiCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration:
                      BoxDecoration(color: SC.lavLight, shape: BoxShape.circle),
                  child: Center(
                      child: Text(doctor.initials,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: SC.purple))),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(doctor.name,
                          style: const TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: 16,
                              color: SC.purpleDark)),
                      const SizedBox(height: 2),
                      Text(doctor.qualification,
                          style: const TextStyle(
                              fontSize: 12, color: SC.textMuted)),
                      const SizedBox(height: 2),
                      Text('${doctor.hospital} · ${doctor.city}',
                          style: const TextStyle(
                              fontSize: 12, color: SC.textMuted),
                          overflow: TextOverflow.ellipsis),
                    ])),
                if (doctor.isFree)
                  SarthiBadge(label: 'Free', color: const Color(0xFF2E7D32))
                else if (doctor.isGovt)
                  SarthiBadge(label: 'Govt', color: SC.skyDark),
              ]),
              const SizedBox(height: 10),
              Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: doctor.tags
                      .take(3)
                      .map((t) => SarthiBadge(label: t, color: SC.purple))
                      .toList()),
              const SizedBox(height: 10),
              Row(children: [
                const Icon(Icons.star_rounded, size: 14, color: SC.amber),
                const SizedBox(width: 3),
                Text('${doctor.rating} (${doctor.reviewCount})',
                    style: const TextStyle(
                        fontSize: 12,
                        color: SC.amber,
                        fontWeight: FontWeight.w700)),
                const SizedBox(width: 12),
                Text(doctor.fee,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: SC.textDark)),
                const Spacer(),
                if (doctor.offersOnline)
                  SarthiBadge(label: 'Online', color: SC.skyDark),
              ]),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                    color: SC.lavLight,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const Icon(Icons.schedule_rounded,
                      size: 13, color: SC.purple),
                  const SizedBox(width: 6),
                  Text('Next: ${doctor.nextSlot}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: SC.purple,
                          fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Text(doctor.availability,
                      style:
                          const TextStyle(fontSize: 11, color: SC.textMuted)),
                ]),
              ),
            ],
          ),
        ),
      );
}

// ── THERAPIST CARD ───────────────────────────────────────────────────────────
class _TherapistCard extends StatelessWidget {
  final Therapist therapist;
  const _TherapistCard({required this.therapist});

  @override
  Widget build(BuildContext context) => SarthiCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: SC.sky.withOpacity(0.15), shape: BoxShape.circle),
                child: Center(
                    child: Text(therapist.initials,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: SC.skyDark))),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(therapist.name,
                        style: const TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 16,
                            color: SC.purpleDark)),
                    const SizedBox(height: 2),
                    Text(therapist.type,
                        style:
                            const TextStyle(fontSize: 12, color: SC.textMuted)),
                    const SizedBox(height: 2),
                    Text('${therapist.centre} · ${therapist.city}',
                        style:
                            const TextStyle(fontSize: 12, color: SC.textMuted),
                        overflow: TextOverflow.ellipsis),
                  ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                SarthiBadge(label: 'RCI Reg.', color: SC.teal),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.star_rounded, size: 12, color: SC.amber),
                  const SizedBox(width: 2),
                  Text('${therapist.rating}',
                      style:
                          const TextStyle(fontSize: 12, color: SC.textMuted)),
                ]),
              ]),
            ]),
            const SizedBox(height: 10),
            Wrap(spacing: 6, runSpacing: 4, children: [
              ...therapist.sessionTypes
                  .map((s) => SarthiBadge(label: s, color: SC.skyDark)),
              ...therapist.ageGroups
                  .map((a) => SarthiBadge(label: 'Age $a', color: SC.purple)),
            ]),
            const SizedBox(height: 10),
            Wrap(
                spacing: 6,
                runSpacing: 4,
                children: therapist.specialities
                    .take(3)
                    .map((s) => SarthiBadge(label: s, color: SC.mint))
                    .toList()),
            const SizedBox(height: 10),
            Row(children: [
              Text(therapist.fee,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: SC.textDark)),
              const Spacer(),
              if (therapist.offersOnline)
                SarthiBadge(label: 'Online', color: SC.skyDark),
              if (therapist.offersHome) ...[
                const SizedBox(width: 6),
                SarthiBadge(label: 'Home Visit', color: SC.teal),
              ],
            ]),
          ],
        ),
      );
}

// ── HOSPITAL CARD ─────────────────────────────────────────────────────────────
class _HospitalCard extends StatelessWidget {
  final SpecialistHospital hospital;
  const _HospitalCard({required this.hospital});

  @override
  Widget build(BuildContext context) => SarthiCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: SC.lavLight,
                    borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.local_hospital_rounded,
                    color: SC.teal, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(hospital.name,
                        style: const TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 16,
                            color: SC.purpleDark)),
                    const SizedBox(height: 2),
                    Text(hospital.address,
                        style:
                            const TextStyle(fontSize: 12, color: SC.textMuted),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ])),
              const SizedBox(width: 6),
              SarthiBadge(
                  label: hospital.type,
                  color: hospital.type == 'Govt'
                      ? const Color(0xFF2E7D32)
                      : hospital.type == 'NGO'
                          ? SC.teal
                          : SC.skyDark),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.access_time_rounded,
                  size: 13, color: SC.textMuted),
              const SizedBox(width: 4),
              Text('${hospital.opdDays} · ${hospital.opdTime}',
                  style: const TextStyle(fontSize: 12, color: SC.textMuted)),
            ]),
            const SizedBox(height: 8),
            Wrap(
                spacing: 6,
                runSpacing: 4,
                children: hospital.services
                    .map((s) => SarthiBadge(label: s, color: SC.teal))
                    .toList()),
            const SizedBox(height: 10),
            Row(children: [
              if (hospital.isFree)
                SarthiBadge(label: 'Free OPD', color: const Color(0xFF2E7D32)),
              if (hospital.hasInpatient) ...[
                const SizedBox(width: 6),
                SarthiBadge(label: 'Inpatient', color: SC.skyDark),
              ],
            ]),
          ],
        ),
      );
}

// ── SCHOOL CARD ───────────────────────────────────────────────────────────────
class _SchoolCard extends StatelessWidget {
  final SpecialistSchool school;
  const _SchoolCard({required this.school});

  @override
  Widget build(BuildContext context) => SarthiCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: SC.amber.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14)),
                child:
                    const Icon(Icons.school_rounded, color: SC.amber, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(school.name,
                        style: const TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 16,
                            color: SC.purpleDark)),
                    const SizedBox(height: 2),
                    Text('${school.board} · ${school.ageRange}',
                        style:
                            const TextStyle(fontSize: 12, color: SC.textMuted)),
                    const SizedBox(height: 1),
                    Text('${school.city}, ${school.state}',
                        style:
                            const TextStyle(fontSize: 12, color: SC.textMuted)),
                  ])),
              SarthiBadge(
                  label: school.type,
                  color: school.type == 'Special'
                      ? SC.amber
                      : school.type == 'Inclusive'
                          ? SC.skyDark
                          : SC.purple),
            ]),
            const SizedBox(height: 10),
            Wrap(spacing: 6, runSpacing: 4, children: [
              ...school.therapiesOnCampus
                  .map((t) => SarthiBadge(label: t, color: SC.amber)),
              if (school.isRTE)
                SarthiBadge(
                    label: 'RTE Free Seat', color: const Color(0xFF2E7D32)),
              if (school.isResidential)
                SarthiBadge(label: 'Residential', color: SC.purple),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Text(school.fees,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: SC.textDark)),
              const Spacer(),
              Text(school.phone,
                  style: const TextStyle(fontSize: 12, color: SC.textMuted)),
            ]),
          ],
        ),
      );
}
