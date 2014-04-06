part of client;


class BezierRenderingSystem extends EntityProcessingSystem {
  CanvasRenderingContext2D ctx;
  ComponentMapper<BezierPath> bpm;
  BezierRenderingSystem(this.ctx) : super(Aspect.getAspectForAllOf([BezierPath]));

  @override
  void begin() {
    ctx..save()
       ..lineWidth = 3
       ..translate(250, 150);
  }

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);
    ctx..save()
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

class DebugBezierRenderingSystem extends BezierRenderingSystem {
  DebugBezierRenderingSystem(CanvasRenderingContext2D ctx) : super(ctx);

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