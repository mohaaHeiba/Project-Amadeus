import 'package:amadeus_app/core/constants/assets.dart';
import 'package:amadeus_app/core/widgets/custom_background/custom_background.dart';
import 'package:amadeus_app/features/avatar/presentation/avatar_bloc/avatar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  late final fileLoader = FileLoader.fromAsset(
    Assets.riveAvatarAmadeus,
    riveFactory: Factory.flutter,
  );

  RiveWidgetController? _amadeusController;

  @override
  void dispose() {
    fileLoader.dispose();
    super.dispose();
  }

  void _syncRiveInputs(AvatarState avatarState) {
    final controller = _amadeusController;
    if (controller == null) return;

    try {
      final inputsMap = avatarState.toRiveInputsMap();

      inputsMap.forEach((inputName, value) {
        if (value is bool) {
          controller.stateMachine.boolean(inputName)?.value = value;
        } else if (value is double) {
          controller.stateMachine.number(inputName)?.value = value;
        }
      });
    } catch (e) {
      debugPrint('Error syncing Rive inputs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvatarBloc, AvatarState>(
      listener: (context, avatarState) {
        _syncRiveInputs(avatarState);
      },
      builder: (context, avatarState) {
        return Stack(
          children: [
            Center(
              child: FractionallySizedBox(
                heightFactor: 1,
                child: RiveWidgetBuilder(
                  fileLoader: fileLoader,
                  stateMachineSelector: StateMachineSelector.byName(
                    'State Machine 2',
                  ),
                  builder: (context, riveState) {
                    switch (riveState) {
                      case RiveLoading():
                        return const Center(child: CircularProgressIndicator());

                      case RiveFailed():
                        return ErrorWidget.withDetails(
                          message: riveState.error.toString(),
                          error: FlutterError(riveState.error.toString()),
                        );

                      case RiveLoaded():
                        _amadeusController = riveState.controller;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _syncRiveInputs(avatarState);
                        });
                        return RiveWidget(
                          controller: riveState.controller,
                          fit: Fit.contain,
                        );
                    }
                  },
                ),
              ),
            ),
            customBackground(context),
          ],
        );
      },
    );
  }
}
