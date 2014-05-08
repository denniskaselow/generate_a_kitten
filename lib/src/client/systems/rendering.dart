part of client;


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
  BodyPartRenderingSystem(CanvasRenderingContext2D ctx) : super(ctx, Aspect.getAspectForAllOf([BezierPath, FillStyle]).exclude([Accessory]));
}

class AccessoryRenderingSystem extends BezierRenderingSystem {
  AccessoryRenderingSystem(CanvasRenderingContext2D ctx) : super(ctx, Aspect.getAspectForAllOf([BezierPath, FillStyle, Accessory]));
}

class DebugBezierRenderingSystem extends BezierRenderingSystem {
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
}