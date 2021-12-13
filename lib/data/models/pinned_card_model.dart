class PinnedCardModel {
  int totalTasksQuantity = 0;
  int tasksDoneQuantity = 0;
  int tasksDonePercent = 0;
  double progressValue = 0;

  PinnedCardModel();

  PinnedCardModel.init(
      {required this.totalTasksQuantity,
      required this.tasksDoneQuantity,
      required this.tasksDonePercent,
      required this.progressValue});
}
