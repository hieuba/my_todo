abstract class ApplicationEvent {}

class TriggerAppEvent extends ApplicationEvent {
  final int index;

  TriggerAppEvent(this.index);
}
