part of client;


class ButtonListeningSystem extends VoidEntitySystem {
  CanvasElement canvas;
  ButtonListeningSystem(this.canvas);

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
      eventBus.fire(randomizeBodyEvent, null);
    });
    querySelector('#randomizeTail').onClick.listen((_) {
      eventBus.fire(randomizeTailEvent, null);
    });
    querySelector('#randomizeBody').onClick.listen((_) {
      eventBus.fire(randomizeBodyEvent, null);
    });
    querySelector('#saveKitten').onClick.listen((_) {
      var trimmedCanvas = cq(cq(canvas).copy());
      var rect = trimmedCanvas.trim(color: '#FFFFFF');
      var dataUrl = trimmedCanvas.canvas.toDataUrl("image/png");
      (querySelector('#saveKitten') as AnchorElement).href = dataUrl;
    });
  }

  @override
  void processSystem() {}

  bool checkProcessing() => false;
}
