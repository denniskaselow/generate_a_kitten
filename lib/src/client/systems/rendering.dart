part of client;

class CanvasCleaningSystem extends VoidEntitySystem {
  CanvasElement canvas;

  CanvasCleaningSystem(this.canvas);

  void processSystem() {
    canvas.context2D.clearRect(0, 0, canvas.width, canvas.height);
  }
}

class BezierRenderingSystem extends EntityProcessingSystem {
  CanvasRenderingContext2D ctx;
  ComponentMapper<BezierPath> bpm;
  ComponentMapper<FillStyle> fsm;
  BezierRenderingSystem(this.ctx, Aspect aspect) : super(aspect);

  @override
  void begin() {
    ctx..save()
       ..lineWidth = 3
       ..translate(250, 150);
  }

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);
    var fs = fsm.get(entity);
    ctx..save()
       ..setFillColorHsl(fs.hue, fs.saturation, fs.lightness, fs.alpha)
       ..translate(bp.offset.x, bp.offset.y)
       ..beginPath()
       ..moveTo(bp.origin.x, bp.origin.y);

    bp.path.map((segment) => segment.storage).forEach((part) {
      ctx.bezierCurveTo(part[0], part[1], part[3], part[4], part[6], part[7]);
    });

    ctx..fill()
       ..stroke()
       ..closePath()
       ..restore();
  }

  @override
  void end() {
    ctx.restore();
  }
}

class BodyPartRenderingSystem extends BezierRenderingSystem {
  BodyPartRenderingSystem(CanvasRenderingContext2D ctx) : super(ctx, Aspect.getAspectForAllOf([BezierPath, FillStyle]).exclude([Monocle]));
}

class MonocleRenderingSystem extends BezierRenderingSystem {
  CheckboxInputElement showMonocle = querySelector('#showMonocle');
  MonocleRenderingSystem(CanvasRenderingContext2D ctx) : super(ctx, Aspect.getAspectForAllOf([BezierPath, FillStyle, Monocle]));

  @override
  bool checkProcessing() => showMonocle.checked;
}

class DebugBezierRenderingSystem extends BezierRenderingSystem {
  CheckboxInputElement showControlPoints = querySelector('#showControlPoints');
  DebugBezierRenderingSystem(CanvasRenderingContext2D ctx) : super(ctx, Aspect.getAspectForAllOf([BezierPath, FillStyle]));

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);
    ctx..save()
       ..translate(bp.offset.x, bp.offset.y)
       ..beginPath()
       ..moveTo(bp.origin.x, bp.origin.y);

    bp.path.map((segment) => segment.storage).forEach((part) {
      ctx..lineTo(part[0], part[1])
         ..arc(part[0], part[1], 2, 0.0, 2 * PI)
         ..moveTo(part[6], part[7])
         ..lineTo(part[3], part[4])
         ..arc(part[3], part[4], 2, 0.0, 2 * PI)
         ..moveTo(part[6], part[7]);
    });

    ctx..stroke()
       ..closePath()
       ..restore();
  }

  @override
  bool checkProcessing() => showControlPoints.checked;
}

class OttificationSystem extends EntityProcessingSystem {
  CheckboxInputElement ottification = querySelector('#ottification');
  CheckboxInputElement noOttText = querySelector('#noOttText');
  ComponentMapper<Word> wm;
  CanvasElement xkcdCanvas;
  CanvasRenderingContext2D ctx;
  OttificationSystem(CanvasElement canvas)
      : xkcdCanvas = new CanvasElement(width: canvas.width, height: canvas.height),
        ctx = canvas.context2D,
        super(Aspect.getAspectForAllOf([Word]));

  @override
  void initialize() {
    xkcdCanvas.context2D..textBaseline = 'top'
                        ..font = '30px XKCD';
  }

  @override
  void begin() {
    xkcdCanvas.context2D.clearRect(0, 0, xkcdCanvas.width, xkcdCanvas.height);
  }


  @override
  void processEntity(Entity entity) {
    var w = wm.get(entity);
    var wordWith = xkcdCanvas.context2D.measureText(w.value).width;
    xkcdCanvas.context2D..save()
                        ..translate(w.x, w.y)
                        ..rotate(-w.angle)
                        ..translate(- wordWith ~/ 2, 0.0)
                        ..fillText(w.value, 0, 0)
                        ..restore();
  }

  @override
  void end() {
    ctx.drawImage(xkcdCanvas, 0, 0);
  }

  @override
  bool checkProcessing() => ottification.checked && !noOttText.checked;
}