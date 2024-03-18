class UnboardingContent {
  String json;
  String title;
  String description;

  UnboardingContent(
      {required this.json, required this.title, required this.description});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      title: 'Problem',
      json: 'assets/animations/Reslove24.json',
      description: "You can easily report problems 24 hours a day,"
          " whether it's a problem with Software, Hardware, or Service Request."),
  UnboardingContent(
      title: 'Resolve',
      json: 'assets/animations/Pro_Resolve.json',
      description:
          "You will receive an expert response to help you with any problems you encounter."),
  UnboardingContent(
      title: 'UX/UI',
      json: 'assets/animations/UX_UI.json',
      description:
          "Attention to user experience from the development team to make it easy for you to use."),
];
