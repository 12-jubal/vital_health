import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vital_health/app/dashboard/dashboard_cubit.dart';
import 'package:vital_health/app/dashboard/dashboard_state.dart';
import 'package:vital_health/app/journaling/journaling_cubit.dart';
import 'package:vital_health/app/journaling/journaling_state.dart';
import 'package:vital_health/core/repositories/health_repository.dart';
import 'package:vital_health/core/repositories/motivational_message_repository.dart';
import 'package:vital_health/utils/widgets/health_card.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                DashboardCubit(HealthRepository())..fetchHealthData()),
        BlocProvider(
            create: (_) => JournalingCubit(MotivationalMessageRepository())
              ..fetchJournalsAndMotivationalMessage()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, healthState) {
            return BlocBuilder<JournalingCubit, JournalingState>(
                builder: (context, journalState) {
              // Loading states
              if (healthState is DashboardLoading ||
                  journalState is JournalingLoading) {
                return Center(child: CircularProgressIndicator());
              }
              // Error states
              if (healthState is DashboardError) {
                return Center(child: Text('Error: ${healthState.message}'));
              }
              if (journalState is JournalingError) {
                return Center(child: Text('Error: ${journalState.message}'));
              }
              // Loaded states
              final healthData = (healthState as DashboardLoaded).healthData;
              final journalEntries =
                  (journalState as JournalingLoaded).journalEntries;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Health stats',
                                style: TextStyle(fontSize: 18.sp)),
                            Spacer(),
                            Text(
                              DateFormat('yyyy-MM-dd – kk:mm').format(
                                  DateTime.parse(healthData['lastUpdated'])),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HealthCard(
                              icon: Icons.directions_walk,
                              label: 'Steps',
                              value: healthData['steps'].toString(),
                            ),
                            HealthCard(
                              icon: Icons.favorite,
                              label: 'Heart Rate',
                              value: '${healthData['heartRate']} bpm',
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Text('Journal Entries: ${journalState.journalEntries}'),
                    // Journal entries
                    Text('My Journals', style: TextStyle(fontSize: 18.sp)),
                    journalEntries.isEmpty
                        ? Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                'No journal entries yet.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: journalEntries.length,
                            itemBuilder: (context, index) {
                              final entry = journalEntries[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    entry['mood'],
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                title: Text(
                                  entry['content'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(DateTime.parse(entry['date'])),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
