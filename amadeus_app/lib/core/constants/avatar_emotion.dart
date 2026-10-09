enum AvatarEmotion {
  neutral(description: 'default state, normal conversation'),
  angry(
    riveInput: 'angry',
    description: 'annoyed, angry, or when called Christina/Assistant/Zombie',
  ),
  blushing(
    riveInput: 'isBlushing',
    description: 'shy, embarrassed, complimented, or acting tsundere',
  ),
  handToChest(
    riveInput: 'Hand_to_Chest',
    description: 'explaining a theory, acting proud, or confident',
  ),
  shakingHead(
    riveInput: 'no',
    description: 'disappointed, sighing, or disagreeing with nonsense',
  ),
  checkingOnUser(
    riveInput: 'are_u_okay',
    description: 'asking a question, curious, or worried about the user',
  );

  final String? riveInput;

  final String description;

  const AvatarEmotion({this.riveInput, required this.description});

  static AvatarEmotion fromName(String? raw) {
    final name = raw?.trim().toLowerCase();
    for (final e in values) {
      if (e.name.toLowerCase() == name) return e;
    }
    return neutral;
  }

  static String get promptList =>
      values.map((e) => '- ${e.name} (use when ${e.description})').join('\n');
}
