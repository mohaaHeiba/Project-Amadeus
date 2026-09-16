import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amadeus_app/features/auth/presentation/widgets/telemetry_header.dart';
import 'package:flutter/material.dart';

Widget buildTelemetryHeader(AuthState state) {
  String headerStatus = 'SYSTEM READY - WAITING FOR INPUT';
  Color headerColor = AppColors.primaryContainer;
  bool isPulsing = false;

  if (state is AuthLoading) {
    headerStatus = ' CONNECTING // ESTABLISHING LINK';
    headerColor = AppColors.primaryContainer;
  } else if (state is AuthError) {
    headerStatus = 'STATUS: LINK FAILED // ACCESS DENIED';
    headerColor = AppColors.error;
    isPulsing = true;
  } else if (state is AuthSuccess) {
    headerStatus = ' STATUS: UPLINK ESTABLISHED';
    headerColor = AppColors.success;
    isPulsing = false;
  }

  return TelemetryHeader(
    statusText: headerStatus,
    statusColor: headerColor,
    isPulsing: isPulsing,
  );
}
