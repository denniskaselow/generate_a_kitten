part of client;


class ButtonListeningSystem extends VoidEntitySystem {
  CanvasElement canvas;
  ButtonListeningSystem(this.canvas);

  @override
  void initialize() {
    querySelector('#randomizeEars').onClick.listen((_) {
      trackRandomize('Ears');
      eventBus.fire(randomizeEarsEvent, null);
    });
    querySelector('#randomizeEyes').onClick.listen((_) {
      trackRandomize('Eyes');
      eventBus.fire(randomizeEyesEvent, null);
    });
    querySelector('#randomizeMouth').onClick.listen((_) {
      trackRandomize('Mouth');
      eventBus.fire(randomizeMouthEvent, null);
    });
    querySelector('#randomizeHead').onClick.listen((_) {
      trackRandomize('Head');
      eventBus.fire(randomizeHeadEvent, null);
      eventBus.fire(randomizeEarsEvent, null);
      eventBus.fire(randomizeEyesEvent, null);
      eventBus.fire(randomizeMouthEvent, null);
    });
    querySelector('#randomizeKitten').onClick.listen((_) {
      trackRandomize('Everything');
      eventBus.fire(randomizeHeadEvent, null);
      eventBus.fire(randomizeEarsEvent, null);
      eventBus.fire(randomizeEyesEvent, null);
      eventBus.fire(randomizeMouthEvent, null);
      eventBus.fire(randomizeTailEvent, null);
      eventBus.fire(randomizeBodyEvent, null);
    });
    querySelector('#randomizeTail').onClick.listen((_) {
      trackRandomize('Tail');
      eventBus.fire(randomizeTailEvent, null);
    });
    querySelector('#randomizeBody').onClick.listen((_) {
      trackRandomize('Body');
      eventBus.fire(randomizeBodyEvent, null);
    });
    querySelector('#saveKitten').onClick.listen((_) {
      eventBus.fire(analyticsTrackEvent, new AnalyticsTrackEvent('Save', 'PNG'));
      var trimmedCanvas = cq(cq(canvas).copy());
      var rect = trimmedCanvas.trim(color: '#FFFFFF');
      var dataUrl = trimmedCanvas.canvas.toDataUrl("image/png");
      (querySelector('#saveKitten') as AnchorElement).href = dataUrl;
    });
  }

  void trackRandomize(String type) {
    eventBus.fire(analyticsTrackEvent, new AnalyticsTrackEvent('Randomize', type));
  }

  @override
  void processSystem() {}

  bool checkProcessing() => false;
}
