part of client;


class RenderingSystem extends VoidEntitySystem {
  CanvasRenderingContext2D ctx;

  RenderingSystem(this.ctx);

  void begin() {
    ctx.save();
    ctx.translate(400, 300);
    ctx..beginPath()
       ..moveTo(0, -300)
       ..lineTo(0, 300)
       ..moveTo(-400, 0)
       ..lineTo(400, 0)
       ..stroke()
       ..closePath();
  }

  @override
  void processSystem() {
    ctx..beginPath()
       ..lineWidth = 5
       // left eye
       ..moveTo(-20, -60)
       ..bezierCurveTo(-20, -80, -40, -80, -40, -60)
       ..bezierCurveTo(-40, -40, -20, -40, -20, -60)
       // right eye
       ..moveTo(20, -60)
       ..bezierCurveTo(20, -80, 40, -80, 40, -60)
       ..bezierCurveTo(40, -40, 20, -40, 20, -60)
       // facial expression
       ..moveTo(-15, -20)
       ..bezierCurveTo(-30, 5, 0, 5, 0, -20)
       ..bezierCurveTo(0, 5, 30, 5, 15, -20)
       // left ear
       ..moveTo(-60, -70)
       ..bezierCurveTo(-60, -70, -70, -120, -70, -120)
       ..bezierCurveTo(-70, -120, -40, -90, -40, -90)
       // right ear
       ..moveTo(60, -70)
       ..bezierCurveTo(60, -70, 70, -120, 70, -120)
       ..bezierCurveTo(70, -120, 40, -90, 40, -90)
       // top head
       ..moveTo(-40, -90)
       ..bezierCurveTo(-20, -110, 20, -110, 40, -90)
       // bottom head
       ..moveTo(-60, -70)
       ..bezierCurveTo(-60, 40, 60, 40, 60, -70)
       // body left
       ..moveTo(-40, -10)
       ..bezierCurveTo(-55, 160, -15, 140, -20, 70)
       // body right
       ..moveTo(40, -10)
       ..bezierCurveTo(55, 160, 15, 140, 20, 70)
       // body bottom
       ..moveTo(-20, 70)
       ..bezierCurveTo(-20, 70, 20, 70, 20, 70)
       // left hind leg
       ..moveTo(-20, 100)
       ..bezierCurveTo(-15, 110, -10, 90, -10, 70)
       // right hind leg
       ..moveTo(20, 100)
       ..bezierCurveTo(15, 110, 10, 90, 10, 70)
       // tail
       ..moveTo(-45, 50)
       ..bezierCurveTo(-60, -20, -150, -20, -110, 20)
       ..bezierCurveTo(-70, 60, -120, 60, -130, 30)
       ..bezierCurveTo(-150, 0, -160, -80, -40, 0)
       ..stroke()
       ..closePath();
  }

  void end() {
    ctx.restore();
  }
}