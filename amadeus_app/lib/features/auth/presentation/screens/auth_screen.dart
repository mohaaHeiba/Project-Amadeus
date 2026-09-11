import 'package:amadeus_app/core/Extensions/spacing.dart';
import 'package:amadeus_app/core/routes/app_routes.dart';
import 'package:amadeus_app/core/theme/app_colors.dart';
import 'package:amadeus_app/core/utils/custom_snackbar.dart';
import 'package:amadeus_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:amadeus_app/features/auth/presentation/widgets/amadeus_text_field.dart';
import 'package:amadeus_app/features/auth/presentation/widgets/cyber_button.dart';
import 'package:amadeus_app/features/auth/presentation/widgets/cyber_panel.dart';
import 'package:amadeus_app/features/auth/presentation/widgets/telemetry_header.dart';
import 'package:amadeus_app/features/auth/presentation/widgets/terminal_footer.dart';
import 'package:amadeus_app/features/splash/presentation/widgets/grid_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController nameController = TextEditingController();

  void _onInitiateLink() {
    context.read<AuthBloc>().add(SaveOperatorNameEvent(nameController.text));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    print("asdas");

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            CustomSnackbar.show(
              isError: true,
              context: context,
              message: state.message,
            );
          } else if (state is AuthSuccess) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (context.mounted) {
                context.go(AppRouter.splash);
              }
            });
          }
        },
        builder: (context, state) {
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
          return Stack(
            children: [
              // Background Cyber Grid (Continuous with Splash)
              Positioned.fill(
                child: CustomPaint(size: size, painter: GridPainter()),
              ),

              // Ambient Warm Amber Glow at Top
              Positioned(
                top: -120,
                left: 0,
                right: 0,
                height: 380,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topCenter,
                      radius: 0.9,
                      colors: [
                        AppColors.primaryContainer.withValues(alpha: 0.14),
                        AppColors.secondaryContainer.withValues(alpha: 0.04),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Subtle Bottom Dark Fade
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 160,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.scaffoldBackground,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Main Interactive Area
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),

                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header with telemetry & branding
                        TelemetryHeader(
                          statusText: headerStatus,
                          statusColor: headerColor,
                          isPulsing: isPulsing,
                        ),
                        32.verticalSpace,

                        // Futuristic Auth Panel
                        CyberPanel(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Terminal status bar inside panel
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.choiceBackground,
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: AppColors.dividerLight,
                                    width: 0.8,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryContainer,
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    const Expanded(
                                      child: Text(
                                        'OPERATOR IDENTIFICATION PROTOCOL',
                                        style: TextStyle(
                                          fontFamily: 'JetBrains Mono',
                                          fontFamilyFallback: ['monospace'],
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              24.verticalSpace,

                              // Single Name Input Field
                              AmadeusTextField(
                                controller: nameController,
                                label: 'OPERATOR NAME',
                                hintText: 'Enter name or callsign...',
                                prefixIcon: Icons.badge_outlined,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                              ),
                              14.verticalSpace,

                              // Cyber Subtext / Prompt
                              Row(
                                children: [
                                  const Icon(
                                    Icons.info_outline_rounded,
                                    size: 13,
                                    color: AppColors.textPlaceholder,
                                  ),
                                  6.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                      'Identifier will be bound to current neural session.',
                                      style: TextStyle(
                                        fontFamily: 'JetBrains Mono',
                                        fontFamilyFallback: const ['monospace'],
                                        fontSize: 10,
                                        letterSpacing: 0.5,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              28.verticalSpace,

                              // Primary Action Button
                              ValueListenableBuilder<TextEditingValue>(
                                valueListenable: nameController,
                                builder:
                                    (
                                      BuildContext context,
                                      value,
                                      Widget? child,
                                    ) {
                                      final bool isFieldEmpty = value.text
                                          .trim()
                                          .isEmpty;
                                      return CyberButton(
                                        text: 'INITIATE LINK',
                                        icon: Icons.power_settings_new_rounded,
                                        isSecondary: isFieldEmpty,
                                        onPressed: _onInitiateLink,
                                      );
                                    },
                              ),
                            ],
                          ),
                        ),
                        32.verticalSpace,

                        // Terminal Footer Metadata
                        Center(child: TerminalFooter()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
