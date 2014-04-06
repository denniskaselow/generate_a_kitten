part of client;


class ButtonListeningSystem extends VoidEntitySystem {

  @override
  void initialize() {
    querySelector('#randomizeEars').onClick.listen((_) {
      eventBus.fire(randomizeEarsEvent, null);
    });
    querySelector('#randomizeEyes').onClick.listen((_) {
      eventBus.fire(randomizeEyesEvent, null);
    });
    querySelector('#randomizeMouth').onClick.listen((_) {
      eventBus.fire(randomizeMouthEvent, null);
    });
    querySelector('#randomizeHead').onClick.listen((_) {
      eventBus.fire(randomizeHeadEvent, null);
      eventBus.fire(randomizeEarsEvent, null);
      eventBus.fire(randomizeEyesEvent, null);
      eventBus.fire(randomizeMouthEvent, null);
    });
    querySelector('#randomizeKitten').onClick.listen((_) {
      eventBus.fire(randomizeHeadEvent, null);
      eventBus.fire(randomizeEarsEvent, null);
      eventBus.fire(randomizeEyesEvent, null);
      eventBus.fire(randomizeMouthEvent, null);
      eventBus.fire(randomizeTailEvent, null);
    });
    querySelector('#randomizeTail').onClick.listen((_) {
      eventBus.fire(randomizeTailEvent, null);
    });
  }

  @override
  void processSystem() {}

  bool checkProcessing() => false;
}
