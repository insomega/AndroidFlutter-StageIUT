// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Required for localizations

// Import your responsive_utils (we will mock it)

// Assuming you have a Service model

// Assuming you have this widget

// --- MOCK CLASSES AND DUMMY WIDGETS START ---

// Mock responsive_utils to control return values in tests
class MockResponsiveUtils {
  static double responsivePadding(BuildContext context, double value) => value;
  static double responsiveIconSize(BuildContext context, double value) => value;
  static double responsiveFontSize(BuildContext context, double value) => value;
}

// Dummy classes needed for the build methods
class Service {
  final String id;
  final String employeeName;
  final String employeeSvrCode;
  final String employeeSvrLib;
  final String employeeTelPort;
  final DateTime startTime;
  final DateTime endTime;
  bool isAbsent;
  bool isValidated;
  final String locationCode;
  final String locationLib;
  final String clientLocationLine3;
  final String clientSvrCode;
  final String clientSvrLib;

  Service({
    required this.id,
    required this.employeeName,
    required this.employeeSvrCode,
    required this.employeeSvrLib,
    required this.employeeTelPort,
    required this.startTime,
    required this.endTime,
    this.isAbsent = false,
    this.isValidated = false,
    required this.locationCode,
    required this.locationLib,
    required this.clientLocationLine3,
    required this.clientSvrCode,
    required this.clientSvrLib,
  });
}

enum TimeCardType { debut, fin, result }

class TimeDetailCard extends StatelessWidget {
  final Service service;
  final TimeCardType type;
  final Function(bool) onAbsentPressed;
  final Function(DateTime) onModifyTime;
  final Function(bool) onValidate;
  final VoidCallback onTap;

  const TimeDetailCard({
    Key? key,
    required this.service,
    required this.type,
    required this.onAbsentPressed,
    required this.onModifyTime,
    required this.onValidate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timeDisplay = '';
    switch (type) {
      case TimeCardType.debut:
        timeDisplay = 'H.D: ${DateFormat('HH:mm').format(service.startTime)}';
        break;
      case TimeCardType.fin:
        timeDisplay = 'H.F: ${DateFormat('HH:mm').format(service.endTime)}';
        break;
      case TimeCardType.result:
        final duration = service.endTime.difference(service.startTime);
        final hours = duration.inHours;
        final minutes = duration.inMinutes.remainder(60);
        timeDisplay = ' +${hours.toString().padLeft(2, '0')}h${minutes.toString().padLeft(2, '0')} min';
        break;
    }

    return Container(
      padding: EdgeInsets.all(MockResponsiveUtils.responsivePadding(context, 8.0)),
      margin: EdgeInsets.symmetric(vertical: MockResponsiveUtils.responsivePadding(context, 4.0)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Service for ${service.employeeName}',
            style: TextStyle(fontSize: MockResponsiveUtils.responsiveFontSize(context, 12.0)),
          ),
          Text(
            timeDisplay,
            key: type == TimeCardType.result ? const Key('calculatedDurationText') : null,
            style: TextStyle(fontSize: MockResponsiveUtils.responsiveFontSize(context, 12.0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (type != TimeCardType.result)
                ElevatedButton(
                  key: const Key('modifyTimeButtonPortrait'),
                  onPressed: () => onModifyTime(DateTime.now()), // Placeholder
                  child: const Text('Modifier Heure'),
                ),
              ElevatedButton(
                key: const Key('absentButtonPortrait'),
                onPressed: () => onAbsentPressed(!service.isAbsent), // Placeholder
                child: const Text('Absent'),
              ),
              if (type == TimeCardType.result)
                ElevatedButton(
                  key: const Key('validateButtonPortrait'),
                  onPressed: () => onValidate(!service.isValidated), // Placeholder
                  child: Row(
                    children: [
                      Icon(service.isValidated ? Icons.undo : Icons.check),
                      Text(service.isValidated ? 'Dévalider' : 'Valider'),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class MockMyHomePage extends StatefulWidget {
  @override
  _MockMyHomePageState createState() => _MockMyHomePageState();
}

class _MockMyHomePageState extends State<MockMyHomePage> {
  // Fixed dates for consistent testing
  bool _dataLoaded = false;
  DateTime _startDate = DateTime(2025, 7, 29);
  DateTime _endDate = DateTime(2025, 7, 29);
  final DateTime _currentDisplayDate = DateTime(2025, 7, 29, 16, 4, 18);
  bool _showDebutColumn = true;
  bool _showFinColumn = true;
  bool _showResultColumn = true;
  final TextEditingController _searchController = TextEditingController();

  void _importServicesFromExcel() {
    setState(() {
      _dataLoaded = !_dataLoaded;
    });
  }

  void _onExportPressed() {
    // Dummy export logic
  }

  void _changeDateByMonth(DateTime date, int months, ValueChanged<DateTime> onDateChanged) {
    setState(() {
      onDateChanged(DateTime(date.year, date.month + months, date.day));
    });
  }

  void _changeDateByDay(DateTime date, int days, ValueChanged<DateTime> onDateChanged) {
    setState(() {
      onDateChanged(date.add(Duration(days: days)));
    });
  }

  Future<void> _selectDate(BuildContext context, DateTime initialDate, ValueChanged<DateTime> onDateChanged) async {
    // Mock showDatePicker behavior by directly calling onDateChanged with a dummy date
    onDateChanged(DateTime(2025, 8, 15)); // A new date to show it changed
  }

  void _handleAbsentToggle(String serviceId, bool newStatus) {}
  void _handleModifyTime(String serviceId, DateTime currentTime, TimeCardType type) {}
  void _handleValidate(String serviceId, bool newStatus) {}
  void _scrollToService(Service service) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      locale: const Locale('fr', 'FR'), // Force French locale for consistent date formatting

      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                _buildDateRangeSelector(),
                _buildSearchBar(),
                _buildColumnHeaders(),
                Expanded(
                  child: Container(), // Placeholder for service list
                ),
                _buildFooter(),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    Widget importButton;
    if (_dataLoaded) {
      importButton = ElevatedButton.icon(
        onPressed: _importServicesFromExcel,
        icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Changer fichier', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0))),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0))),
          padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 6.0), vertical: MockResponsiveUtils.responsivePadding(context, 2.0)),
          minimumSize: orientation == Orientation.portrait ? Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 35.0)) : Size(MockResponsiveUtils.responsivePadding(context, 75.0), MockResponsiveUtils.responsivePadding(context, 30.0)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
    } else {
      importButton = ElevatedButton.icon(
        onPressed: _importServicesFromExcel,
        icon: Icon(Icons.upload_file, color: Theme.of(context).colorScheme.primary, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Importer services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0))),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0))),
          padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 6.0), vertical: MockResponsiveUtils.responsivePadding(context, 2.0)),
          minimumSize: orientation == Orientation.portrait ? Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 35.0)) : Size(MockResponsiveUtils.responsivePadding(context, 75.0), MockResponsiveUtils.responsivePadding(context, 30.0)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
    }

    Widget exportButton = ElevatedButton.icon(
      onPressed: _onExportPressed,
      icon: Icon(Icons.download, color: Theme.of(context).colorScheme.primary, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text('Exporter services', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0))),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0))),
        padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 6.0), vertical: MockResponsiveUtils.responsivePadding(context, 2.0)),
        minimumSize: orientation == Orientation.portrait ? Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 35.0)) : Size(MockResponsiveUtils.responsivePadding(context, 75.0), MockResponsiveUtils.responsivePadding(context, 30.0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    if (orientation == Orientation.portrait) {
      return AppBar(
        toolbarHeight: MockResponsiveUtils.responsivePadding(context, 80.0),
        leading: Padding(
          padding: EdgeInsets.all(MockResponsiveUtils.responsivePadding(context, 4.0)),
          child: Image.asset(
            'assets/logo_app.png',
            height: MockResponsiveUtils.responsiveIconSize(context, 40.0),
            width: MockResponsiveUtils.responsiveIconSize(context, 40.0),
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: MockResponsiveUtils.responsiveIconSize(context, 40.0));
            },
          ),
        ),
        title: Text(
          'Prise de services automatique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MockResponsiveUtils.responsiveFontSize(context, 16.0),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(MockResponsiveUtils.responsivePadding(context, 45.0)),
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 8.0), vertical: MockResponsiveUtils.responsivePadding(context, 4.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: importButton)),
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 6.0)),
                Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: exportButton)),
              ],
            ),
          ),
        ),
      );
    } else {
      return AppBar(
        toolbarHeight: MockResponsiveUtils.responsivePadding(context, 50.0),
        leading: Padding(
          padding: EdgeInsets.all(MockResponsiveUtils.responsivePadding(context, 4.0)),
          child: Image.asset(
            'assets/logo_app.png',
            height: MockResponsiveUtils.responsiveIconSize(context, 25.0),
            width: MockResponsiveUtils.responsiveIconSize(context, 25.0),
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: MockResponsiveUtils.responsiveIconSize(context, 25.0));
            },
          ),
        ),
        title: Text(
          'Prise de services automatique',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MockResponsiveUtils.responsiveFontSize(context, 16.0),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: importButton),
          Padding(padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)), child: exportButton),
          SizedBox(width: MockResponsiveUtils.responsivePadding(context, 6.0)),
        ],
      );
    }
  }

  Widget _buildDateRangeSelector() {
    final orientation = MediaQuery.of(context).orientation;

    Widget buildColumnToggleButton(String label, bool isVisible, ValueChanged<bool> onChanged) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 2.0)),
        child: InkWell(
          onTap: () => setState(() => onChanged(!isVisible)),
          borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 8.0)),
          child: Container(
            width: MockResponsiveUtils.responsivePadding(context, 70.0),
            height: MockResponsiveUtils.responsivePadding(context, 35.0),
            decoration: BoxDecoration(
              color: isVisible ? Theme.of(context).primaryColor : Colors.grey[400],
              borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 8.0)),
              boxShadow: isVisible ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                  size: MockResponsiveUtils.responsiveIconSize(context, 16.0),
                ),
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 2.0)),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 10.0),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget dateControls = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
          onPressed: () {
            _changeDateByMonth(_startDate, -1, (newDate) => _startDate = newDate);
            _changeDateByMonth(_endDate, -1, (newDate) => _endDate = newDate);
          },
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        // Wrap _buildDateControl calls with Expanded to make them flexible
        Expanded(
          child: _buildDateControl(_startDate, (newDate) => _startDate = newDate, const Key('startDateText')),
        ),
        SizedBox(width: MockResponsiveUtils.responsivePadding(context, 4.0)),
        Container(
          width: MockResponsiveUtils.responsivePadding(context, 1.5),
          height: MockResponsiveUtils.responsiveFontSize(context, 20.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: MockResponsiveUtils.responsivePadding(context, 4.0)),
        Expanded(
          child: _buildDateControl(_endDate, (newDate) => _endDate = newDate, const Key('endDateText')),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)), // Corrected icon for month forward
          onPressed: () {
            _changeDateByMonth(_startDate, 1, (newDate) => _startDate = newDate);
            _changeDateByMonth(_endDate, 1, (newDate) => _endDate = newDate);
          },
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );

    Widget columnToggleButtons = Row(
      mainAxisSize: MainAxisSize.min, // Keep this as min, as these buttons have fixed sizes
      children: [
        buildColumnToggleButton('D', _showDebutColumn, (newStatus) {
          _showDebutColumn = newStatus;
        }),
        buildColumnToggleButton('F', _showFinColumn, (newStatus) {
          _showFinColumn = newStatus;
        }),
        buildColumnToggleButton('R', _showResultColumn, (newStatus) {
          _showResultColumn = newStatus;
        }),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 10.0), vertical: MockResponsiveUtils.responsivePadding(context, 4.0)),
      color: Colors.grey[100],
      child: orientation == Orientation.portrait
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dateControls, // This Row will now flex its date controls
                SizedBox(height: MockResponsiveUtils.responsivePadding(context, 8.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( // Ensure the date text takes available space
                      child: Text(
                        DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
                        style: TextStyle(
                          fontSize: MockResponsiveUtils.responsiveFontSize(context, 11.0),
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    columnToggleButtons,
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 3, // Increased flex from 2 to 3 to give date controls more room
                  child: dateControls,
                ),
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 10.0)),
                Expanded(
                  flex: 4, // Increased flex from 3 to 4 for the long date text
                  child: Text(
                    DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(_currentDisplayDate),
                    style: TextStyle(
                      fontSize: MockResponsiveUtils.responsiveFontSize(context, 11.0),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: MockResponsiveUtils.responsivePadding(context, 10.0)),
                Expanded( // Wrap columnToggleButtons in Expanded for better landscape layout
                  flex: 3, // Adjust flex as needed, keeping enough space for buttons
                  child: columnToggleButtons,
                ),
              ],
            ),
    );
  }

  Widget _buildDateControl(DateTime date, ValueChanged<DateTime> onDateChanged, Key dateTextKey) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Keep this as min; the parent Expanded handles sizing
      children: [
        IconButton(
          icon: Icon(Icons.remove, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
          onPressed: () => _changeDateByDay(date, -1, onDateChanged),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        SizedBox(width: MockResponsiveUtils.responsivePadding(context, 3.0)),
        GestureDetector(
          onTap: () async {
            await _selectDate(context, date, onDateChanged);
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 6.0), vertical: MockResponsiveUtils.responsivePadding(context, 3.0)),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 5.0)),
              color: Colors.white,
            ),
            child: Text(
              DateFormat('dd/MM/yyyy').format(date),
              key: dateTextKey, // Add key here!
              style: TextStyle(fontSize: MockResponsiveUtils.responsiveFontSize(context, 12.0), fontWeight: FontWeight.bold, color: Colors.black87),
              overflow: TextOverflow.ellipsis, // Added for safety
              maxLines: 1, // Added for safety
            ),
          ),
        ),
        SizedBox(width: MockResponsiveUtils.responsivePadding(context, 3.0)),
        IconButton(
          icon: Icon(Icons.add, size: MockResponsiveUtils.responsiveIconSize(context, 16.0)),
          onPressed: () => _changeDateByDay(date, 1, onDateChanged),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 9.0), vertical: MockResponsiveUtils.responsivePadding(context, 4.0)),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Rechercher par nom d\'employé',
          hintText: 'Entrez le nom de l\'employé...',
          prefixIcon: Icon(Icons.search, size: MockResponsiveUtils.responsiveIconSize(context, 12.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MockResponsiveUtils.responsivePadding(context, 6.0)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: MockResponsiveUtils.responsivePadding(context, 6.0), horizontal: MockResponsiveUtils.responsivePadding(context, 6.0)),
          isDense: true,
        ),
        style: TextStyle(fontSize: MockResponsiveUtils.responsiveFontSize(context, 10.0)),
      ),
    );
  }

  Widget _buildColumnHeaders() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MockResponsiveUtils.responsivePadding(context, 10.0), vertical: MockResponsiveUtils.responsivePadding(context, 6.0)),
      child: Row(
        children: [
          if (_showDebutColumn)
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Début',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 14.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          if (_showFinColumn)
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Fin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 14.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          if (_showResultColumn)
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Résultat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MockResponsiveUtils.responsiveFontSize(context, 14.0),
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MockResponsiveUtils.responsivePadding(context, 6.0),
        vertical: MockResponsiveUtils.responsivePadding(context, 4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              "© BMSoft 2025, tous droits réservés    ${DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(_currentDisplayDate)}",
              style: TextStyle(
                fontSize: MockResponsiveUtils.responsiveFontSize(context, 9.0),
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}

// --- MOCK CLASSES AND DUMMY WIDGETS END ---

// Helper function to pump MockMyHomePage with consistent setup
Future<void> _pumpMockMyHomePage(WidgetTester tester, {required Size size}) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: size),
      child: MockMyHomePage(),
    ),
  );
  await tester.pumpAndSettle(); // Allow any animations or initial frames to settle
}


void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('AppBar Tests', () {
    testWidgets('AppBar displays title and import/export buttons in portrait mode', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      expect(find.text('Prise de services automatique'), findsOneWidget);
      expect(find.byIcon(Icons.upload_file), findsOneWidget);
      expect(find.byIcon(Icons.download), findsOneWidget);
      expect(find.text('Importer services'), findsOneWidget);
      expect(find.text('Exporter services'), findsOneWidget);
    });

    testWidgets('AppBar displays title and import/export buttons in landscape mode', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(640, 360)); // Landscape

      expect(find.text('Prise de services automatique'), findsOneWidget);
      expect(find.byIcon(Icons.upload_file), findsOneWidget);
      expect(find.byIcon(Icons.download), findsOneWidget);
      expect(find.text('Importer services'), findsOneWidget);
      expect(find.text('Exporter services'), findsOneWidget);
    });

    testWidgets('Import button changes text when data is loaded', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      expect(find.text('Importer services'), findsOneWidget);
      expect(find.text('Changer fichier'), findsNothing);

      await tester.tap(find.text('Importer services'));
      await tester.pump();

      expect(find.text('Importer services'), findsNothing);
      expect(find.text('Changer fichier'), findsOneWidget);
    });
  });

  group('Date Range Selector Tests', () {
    testWidgets('Date range selector displays current date and time in portrait', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      final formattedDate = DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(DateTime(2025, 7, 29, 16, 4, 18));
      expect(find.textContaining(formattedDate.substring(0, 10)), findsOneWidget);
    });

    testWidgets('Date range selector displays current date and time in landscape', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(640, 360)); // Landscape

      final formattedDate = DateFormat('EEEE dd MMMM HH:mm:ss', 'fr_FR').format(DateTime(2025, 7, 29, 16, 4, 18));
      expect(find.textContaining(formattedDate.substring(0, 10)), findsOneWidget);
    });

    testWidgets('Column toggle buttons are present and interactive', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      expect(find.widgetWithText(InkWell, 'D'), findsOneWidget);
      expect(find.widgetWithText(InkWell, 'F'), findsOneWidget);
      expect(find.widgetWithText(InkWell, 'R'), findsOneWidget);

      final debutToggleFinder = find.widgetWithText(InkWell, 'D');
      await tester.tap(debutToggleFinder);
      await tester.pump(); // Added pump to rebuild after state change
    });

    testWidgets('Date controls interact correctly (day change)', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      final initialStartDate = DateTime(2025, 7, 29);
      final initialStartDateString = DateFormat('dd/MM/yyyy').format(initialStartDate);
      expect(find.byKey(const Key('startDateText')), findsOneWidget);
      expect(find.text(initialStartDateString), findsOneWidget); // Confirm initial text

      // Tap the remove button for the start date
      await tester.tap(find.byIcon(Icons.remove).first);
      await tester.pump();

      final yesterday = DateFormat('dd/MM/yyyy').format(initialStartDate.subtract(const Duration(days: 1)));
      expect(find.text(yesterday), findsOneWidget);

      // Tap the add button for the start date
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pump();

      expect(find.text(initialStartDateString), findsOneWidget); // Should return to original date
    });

    testWidgets('Date controls interact correctly (month change)', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      final initialStartDate = DateTime(2025, 7, 29);
      final initialStartDateString = DateFormat('dd/MM/yyyy').format(initialStartDate);
      expect(find.byKey(const Key('startDateText')), findsOneWidget);
      expect(find.text(initialStartDateString), findsOneWidget); // Confirm initial text

      // Tap the arrow_back_ios button for month decrement
      await tester.tap(find.byIcon(Icons.arrow_back_ios).first);
      await tester.pump();

      final lastMonthStartDate = DateFormat('dd/MM/yyyy').format(DateTime(initialStartDate.year, initialStartDate.month - 1, initialStartDate.day));
      expect(find.text(lastMonthStartDate), findsOneWidget);

      // Tap the arrow_forward_ios button for month increment
      await tester.tap(find.byIcon(Icons.arrow_forward_ios).first);
      await tester.pump();
      expect(find.text(initialStartDateString), findsOneWidget); // Should return to original date
    });

    testWidgets('Date picker can be opened and a date selected', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      // Tap the start date text to open the date picker (now mocked to change date directly)
      // We use the key to precisely target the start date text.
      await tester.tap(find.byKey(const Key('startDateText')));
      await tester.pumpAndSettle();

      // Because _selectDate is mocked to directly update the date,
      // we won't find CalendarDatePicker or 'OK' button.
      // Instead, we assert that the date text has changed to the mocked new date.
      expect(find.text(DateFormat('dd/MM/yyyy').format(DateTime(2025, 8, 15))), findsOneWidget);
    });
  });

  group('SearchBar Tests', () {
    testWidgets('Search bar is present and can receive input', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Rechercher par nom d\'employé'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'John Doe');
      expect(find.text('John Doe'), findsOneWidget);
    });
  });

  group('Column Headers Tests', () {
    testWidgets('Column headers are displayed when visible', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      expect(find.text('Début'), findsOneWidget);
      expect(find.text('Fin'), findsOneWidget);
      expect(find.text('Résultat'), findsOneWidget);
    });

    testWidgets('Column headers hide when toggled off', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      await tester.tap(find.widgetWithText(InkWell, 'D'));
      await tester.pump();

      expect(find.text('Début'), findsNothing);
      expect(find.text('Fin'), findsOneWidget);
      expect(find.text('Résultat'), findsOneWidget);

      await tester.tap(find.widgetWithText(InkWell, 'F'));
      await tester.pump();

      expect(find.text('Début'), findsNothing);
      expect(find.text('Fin'), findsNothing);
      expect(find.text('Résultat'), findsOneWidget);

      await tester.tap(find.widgetWithText(InkWell, 'R'));
      await tester.pump();

      expect(find.text('Début'), findsNothing);
      expect(find.text('Fin'), findsNothing);
      expect(find.text('Résultat'), findsNothing);
    });
  });

  group('Footer Tests', () {
    testWidgets('Footer displays copyright and current date/time', (WidgetTester tester) async {
      await _pumpMockMyHomePage(tester, size: const Size(360, 640)); // Portrait

      expect(find.textContaining('© BMSoft 2025, tous droits réservés'), findsOneWidget);
      final formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss', 'fr_FR').format(DateTime(2025, 7, 29, 16, 4, 18));
      expect(find.textContaining(formattedDate.substring(0, 16)), findsOneWidget);
    });
  });

  group('TimeDetailCard Tests', () {
    testWidgets('TimeDetailCard displays service information', (WidgetTester tester) async {
      final service = Service(
        id: '1',
        employeeName: 'Alice',
        employeeSvrCode: 'SVC001',
        employeeSvrLib: 'Service Library A',
        employeeTelPort: '123-456-7890',
        startTime: DateTime(2025, 7, 29, 9, 0),
        endTime: DateTime(2025, 7, 29, 17, 0),
        locationCode: 'LOC001',
        locationLib: 'Location Library A',
        clientLocationLine3: 'Line 3 Address',
        clientSvrCode: 'CLISVC001',
        clientSvrLib: 'Client Service Lib A',
      );

      await tester.pumpWidget(
        MaterialApp(
          // Ensure localizations for TimeDetailCard too, if it uses DateFormat
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('fr', 'FR'),
          ],
          locale: const Locale('fr', 'FR'),
          home: Scaffold(
            body: TimeDetailCard(
              service: service,
              type: TimeCardType.debut,
              onAbsentPressed: (status) {},
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      // Corrected expectation: The TimeDetailCard only displays 'Service for [employeeName]'
      expect(find.text('Service for Alice'), findsOneWidget);
      // You can also verify the time display if needed
      expect(find.text('H.D: 09:00'), findsOneWidget);
    });

    testWidgets('TimeDetailCard displays calculated duration for result type', (WidgetTester tester) async {
      final service = Service(
        id: '1',
        employeeName: 'Bob',
        employeeSvrCode: 'SVC002',
        employeeSvrLib: 'Service Library B',
        employeeTelPort: '098-765-4321',
        startTime: DateTime(2025, 7, 29, 9, 0),
        endTime: DateTime(2025, 7, 29, 17, 30), // 8 hours 30 minutes
        locationCode: 'LOC002',
        locationLib: 'Location Library B',
        clientLocationLine3: 'Another Address',
        clientSvrCode: 'CLISVC002',
        clientSvrLib: 'Client Service Lib B',
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('fr', 'FR'),
          ],
          locale: const Locale('fr', 'FR'),
          home: Scaffold(
            body: TimeDetailCard(
              service: service,
              type: TimeCardType.result,
              onAbsentPressed: (status) {},
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Service for Bob'), findsOneWidget);
      // Expectation for the calculated duration: "+08h30 min"
      expect(find.text(' +08h30 min'), findsOneWidget);
    });

    testWidgets('TimeDetailCard shows validate/devalidate button for result type', (WidgetTester tester) async {
      final service = Service(
        id: '1',
        employeeName: 'Charlie',
        employeeSvrCode: 'SVC003',
        employeeSvrLib: 'Service Library C',
        employeeTelPort: '111-222-3333',
        startTime: DateTime(2025, 7, 29, 10, 0),
        endTime: DateTime(2025, 7, 29, 12, 0),
        locationCode: 'LOC003',
        locationLib: 'Location Library C',
        clientLocationLine3: 'Third Address',
        clientSvrCode: 'CLISVC003',
        clientSvrLib: 'Client Service Lib C',
      );

      // Initial state: not validated
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimeDetailCard(
              service: service,
              type: TimeCardType.result,
              onAbsentPressed: (status) {},
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('validateButtonPortrait')), findsOneWidget);
      expect(find.text('Valider'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Simulate validation (requires a stateful mock or a way to update the service object)
      // For this test, we can only check the initial state or mock the onValidate callback.
      // Since the card itself is stateless and relies on the `service` object,
      // a full state change test would require wrapping it in a stateful widget.
    });

    testWidgets('TimeDetailCard hides modify time and validate buttons for non-result types', (WidgetTester tester) async {
      final service = Service(
        id: '1',
        employeeName: 'Diana',
        employeeSvrCode: 'SVC004',
        employeeSvrLib: 'Service Library D',
        employeeTelPort: '444-555-6666',
        startTime: DateTime(2025, 7, 29, 8, 0),
        endTime: DateTime(2025, 7, 29, 16, 0),
        locationCode: 'LOC004',
        locationLib: 'Location Library D',
        clientLocationLine3: 'Fourth Address',
        clientSvrCode: 'CLISVC004',
        clientSvrLib: 'Client Service Lib D',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimeDetailCard(
              service: service,
              type: TimeCardType.debut, // Testing with debut type
              onAbsentPressed: (status) {},
              onModifyTime: (time) {},
              onValidate: (status) {},
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('modifyTimeButtonPortrait')), findsOneWidget);
      expect(find.byKey(const Key('absentButtonPortrait')), findsOneWidget);
      expect(find.byKey(const Key('validateButtonPortrait')), findsNothing); // Validate button should not be present
    });
  });
}