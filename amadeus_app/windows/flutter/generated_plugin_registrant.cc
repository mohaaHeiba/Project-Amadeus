//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_tts/flutter_tts_plugin.h>
#include <rive_native/rive_native_plugin.h>
#include <speech_to_text_windows/speech_to_text_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FlutterTtsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterTtsPlugin"));
  RiveNativePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RiveNativePlugin"));
  SpeechToTextWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SpeechToTextWindows"));
}
