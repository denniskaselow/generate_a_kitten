part of shared;

class TweeningSystem extends VoidEntitySystem {

  @override
  void processSystem() {
    myManager.update(world.delta / 1000);
  }
}

abstract class RandomizingSystem extends EntityProcessingSystem {
  bool randomize = false;
  ComponentMapper<BezierPath> bpm;
  EventType eventType;
  RandomizingSystem(this.eventType, List<Type> types) : super(Aspect.getAspectForAllOf([BezierPath]).allOf(types));

  @override
  void initialize() {
    eventBus.on(eventType).listen((_) => randomize = true);
  }

  @override
  void end() {
    randomize = false;
  }

  @override
  bool checkProcessing() => randomize;

  double getRandom(num min, num max) => min + random.nextDouble() * (max - min);

  void tweenPath(BezierPath path, int index, List<double> newValues) {
    Tween.to(path, index, 0.5)
         ..targetValues = newValues
         ..easing = Linear.INOUT
         ..start(myManager);
  }

  void tweenOrigin(BezierPath path, double x, double y) {
    Tween.to(path, BezierPath.ORIGIN, 0.5)
         ..targetValues = [x, y]
         ..easing = Linear.INOUT
         ..start(myManager);
  }

  void tweenOffset(BezierPath path, double x, double y) {
    Tween.to(path, BezierPath.OFFSET, 0.5)
         ..targetValues = [x, y]
         ..easing = Linear.INOUT
         ..start(myManager);
  }
}

class HeadRandomizingSystem extends RandomizingSystem {
  HeadRandomizingSystem() : super(randomizeHeadEvent, [Head]);

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);

    // top
    var x1 = getRandom(10, 30);
    var y1 = getRandom(-40, 0);
    tweenPath(bp, 2, [-x1, y1, 0.0, x1, y1, 0.0, bp.path[2].storage[6], bp.path[2].storage[7], 0.0]);

    // bottom
    var x2 = getRandom(40, 90);
    var y2 = getRandom(100, 140);
    tweenPath(bp, 5, [x2, y2, 0.0, -x2, y2, 0.0, bp.path[5].storage[6], bp.path[5].storage[7], 0.0]);
  }
}

class EarsRandomizingSystem extends RandomizingSystem {
  EarsRandomizingSystem() : super(randomizeEarsEvent, [Head]);

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);

    var x1 = getRandom(60, 100);
    var y1 = getRandom(-20, 0);
    var x2 = getRandom(30, 80);
    var y2 = getRandom(-40, min(y1, -10));

    var x3 = getRandom(max(x2 - 45, 5), x2);
    var y3 = getRandom(-40, y2);
    var x4 = getRandom(40, min(x1, 80));
    var y4 = getRandom(-40, -15);

    tweenPath(bp, 0, [-x1, y1, 0.0, -x2, y2, 0.0, bp.path[0].storage[6], bp.path[0].storage[7], 0.0]);
    tweenPath(bp, 1, [-x3, y3, 0.0, -x4, y4, 0.0, bp.path[1].storage[6], bp.path[1].storage[7], 0.0]);
    tweenPath(bp, 3, [x4, y4, 0.0, x3, y3, 0.0, bp.path[3].storage[6], bp.path[3].storage[7], 0.0]);
    tweenPath(bp, 4, [x2, y2, 0.0, x1, y1, 0.0, bp.path[4].storage[6], bp.path[4].storage[7], 0.0]);
  }
}

class EyeRandomizingSystem extends RandomizingSystem {
  double x0, x1, x2, x3;
  double y0, y1, y2, y3;
  bool useCutenessBug;
  ComponentMapper<Eye> em;
  EyeRandomizingSystem() : super(randomizeEyesEvent, [Eye]);


  @override
  void begin() {
    x0 = getRandom(25, 40);
    y0 = getRandom(-40 - (x0 - 10), -50);
    if (random.nextBool()) {
      x3 = getRandom(10, 20);
      y3 = getRandom(0, 20);
      useCutenessBug = true;
    } else {
      x3 = 10.0;
      y3 = 0.0;
      useCutenessBug = false;
    }
    x1 = x3 - 10 + getRandom(5, 25);
    y1 = y3 + getRandom(-30, 0);
    x2 = x3 - 10 + getRandom(5, 25);
    y2 = y3 + getRandom(-30, 0);
//    useCutenessBug = random.nextBool();
  }

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);

    tweenOffset(bp, x0 * em.get(entity).modX, y0);
    tweenOrigin(bp, x3, y3);
    tweenPath(bp, 0, [x1, y1, 0.0, -x1, y1, 0.0, useCutenessBug ? bp.path[0].storage[6] : -x3, useCutenessBug ? bp.path[0].storage[7] : y3, 0.0]);
    tweenPath(bp, 1, [-x2, -y2, 0.0, x2, -y2, 0.0, x3, y3, 0.0]);
  }
}

class MouthRandomizingSystem extends RandomizingSystem {
  double x1, x2, x4;
  double y1, y2, y3, y4;
  ComponentMapper<Mouth> mm;
  MouthRandomizingSystem() : super(randomizeMouthEvent, [Mouth]);

  @override
  void begin() {
    x1 = getRandom(20, 30);
    y1 = getRandom(5, 15);
    x2 = getRandom(-5, 5);
    y2 = getRandom(5, 15);
    y3 = getRandom(-10, 0);
    x4 = getRandom(5, 13);
    y4 = getRandom(-13, y3 - 3);
  }

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);
    var modX = mm.get(entity).modX;

    tweenPath(bp, 0, [-x1 * modX, y1, 0.0, -x2 * modX, y2, 0.0, bp.path[0].storage[6], y3, 0.0]);
    tweenPath(bp, 1, [bp.path[1].storage[0], y3, 0.0, bp.path[1].storage[3], bp.path[1].storage[4], 0.0, -x4 * modX, y4, 0.0]);
  }
}

class BodyRandomizingSystem extends RandomizingSystem {
  ComponentMapper<Body> bm;
  double x1, x2, x3, x4;
  double y1, y2, y3, y4;
  BodyRandomizingSystem() : super(randomizeBodyEvent, [Body]);

  @override
  void begin() {
    // legs
    x1 = getRandom(-70, -40);
    y1 = getRandom(120, 180);
    x2 = getRandom(-20, -10);
    y2 = getRandom(120, 180);
    // lower body
    x3 = getRandom(-25, -15);
    y3 = getRandom(40, 90);
    x4 = getRandom(x3, x3 + 10);
    y4 = getRandom(y3 - 20, 90);
  }

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);
    var modX = bm.get(entity).modX;
    var modY = bm.get(entity).modY;

    tweenPath(bp, 0, [x1 * modX, y1 * modY, 0.0, x2 * modX, y2 * modY, 0.0, x3 * modX, y3 * modY, 0.0]);
    tweenPath(bp, 1, [x4 * modX, y4 * modY, 0.0, -x4 * modX, y4 * modY, 0.0, -x3 * modX, y3 * modY, 0.0]);
    tweenPath(bp, 2, [-x2 * modX, y2 * modY, 0.0, -x1 * modX, y1 * modY, 0.0, bp.path[2].storage[6], bp.path[2].storage[7], 0.0]);
  }
}

class TailRandomizingSystem extends RandomizingSystem {
  TailRandomizingSystem() : super(randomizeTailEvent, [Tail]);

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);
    var xMod = random.nextBool() ? 1 : -1;
    var lengthMod = getRandom(0.5, 2.5);

    var bp00 = getRandom(50, 75) * xMod;
    var bp01 = getRandom(0, 30);
    var bp03 = getRandom(100, 150) * xMod;
    var bp04 = getRandom(-20, 10);
    var bp06 = getRandom(90, 150) * xMod;
    var bp07 = getRandom(15, 55);

    var bp16 = getRandom(bp06 + 20 * xMod, bp06 + 40 * xMod);
    var bp17 = getRandom(bp07 - 10, bp07 + 10);
    // parallel
    var bp13 = bp16 + (bp06 - bp03) * getRandom(0.5, 1.5);
    var bp14 = bp17 + (bp07 - bp04) * getRandom(0.5, 1.5);
    // parallel
    var diffX = (bp00 - bp.origin.x.abs() * xMod);
    var diffY = (bp01 - bp.origin.y);
    var bp23 = diffX * 2.5 + bp.path[2].storage[6].abs() * xMod;
    var bp24 = diffY * 2.5 + bp.path[2].storage[7];

    tweenPath(bp, 0, [bp00, bp01, 0.0, bp03, bp04, 0.0, bp06, bp07, 0.0]);
    tweenPath(bp, 1, [bp06 + (bp06 - bp03) * lengthMod, bp07 + (bp07 - bp04) * lengthMod, 0.0, bp13, bp14, 0.0, bp16, bp17, 0.0]);
    tweenPath(bp, 2, [bp16 + (bp16 - bp13) * lengthMod, bp17 + (bp17 - bp14) * lengthMod, 0.0, bp23, bp24, 0.0, bp.path[2].storage[6].abs() * xMod, bp.path[2].storage[7], 0.0]);
    tweenOrigin(bp, bp.origin.x.abs() * xMod, bp.origin.y);
  }
}