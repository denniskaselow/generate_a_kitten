part of shared;

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
}

class HeadRandomizingSystem extends RandomizingSystem {
  HeadRandomizingSystem() : super(randomizeHeadEvent, [Head]);

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);

    // top
    var x1 = getRandom(10, 30);
    var y1 = getRandom(-40, 0);
    bp.path[2].storage[0] = -x1;
    bp.path[2].storage[1] = y1;
    bp.path[2].storage[3] = x1;
    bp.path[2].storage[4] = y1;

    // bottom
    var x2 = getRandom(40, 90);
    var y2 = getRandom(100, 140);
    bp.path[5].storage[0] = x2;
    bp.path[5].storage[1] = y2;
    bp.path[5].storage[3] = -x2;
    bp.path[5].storage[4] = y2;
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

    bp.path[0].storage[0] = -x1;
    bp.path[0].storage[1] = y1;
    bp.path[4].storage[3] = x1;
    bp.path[4].storage[4] = y1;

    bp.path[0].storage[3] = -x2;
    bp.path[0].storage[4] = y2;
    bp.path[4].storage[0] = x2;
    bp.path[4].storage[1] = y2;

    bp.path[1].storage[0] = -x3;
    bp.path[1].storage[1] = y3;
    bp.path[3].storage[3] = x3;
    bp.path[3].storage[4] = y3;

    bp.path[1].storage[3] = -x4;
    bp.path[1].storage[4] = y4;
    bp.path[3].storage[0] = x4;
    bp.path[3].storage[1] = y4;
  }
}

class EyeRandomizingSystem extends RandomizingSystem {
  double x0, x1, x2, x3;
  double y0, y1, y2, y3;
  ComponentMapper<Eye> em;
  EyeRandomizingSystem() : super(randomizeEyesEvent, [Eye]);


  @override
  void begin() {
    x0 = getRandom(25, 40);
    y0 = getRandom(-40 - (x0 - 10), -50);
    if (random.nextBool()) {
      x3 = getRandom(10, 20);
      y3 = getRandom(0, 20);
    } else {
      x3 = 10.0;
      y3 = 0.0;
    }
    x1 = x3 - 10 + getRandom(5, 25);
    y1 = y3 + getRandom(-30, 0);
    x2 = x3 - 10 + getRandom(5, 25);
    y2 = y3 + getRandom(-30, 0);
  }

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);

    bp.offset.x = x0 * em.get(entity).modX;
    bp.offset.y = y0;

    bp.origin.x = x3;
    bp.origin.y = y3;
    bp.path[1].storage[6] = -x3;
    bp.path[1].storage[7] = y3;
    bp.path[1].storage[6] = x3;
    bp.path[1].storage[7] = y3;

    // top
    bp.path[0].storage[0] = x1;
    bp.path[0].storage[1] = -y1;
    bp.path[0].storage[3] = -x1;
    bp.path[0].storage[4] = -y1;

    // bottom
    bp.path[1].storage[0] = -x2;
    bp.path[1].storage[1] = y2;
    bp.path[1].storage[3] = x2;
    bp.path[1].storage[4] = y2;
  }
}

class MouthRandomizingSystem extends RandomizingSystem {
  MouthRandomizingSystem() : super(randomizeMouthEvent, [Mouth]);

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);

    // top
    var x1 = getRandom(20, 40);
    var y1 = getRandom(-5, 20);
    var x2 = getRandom(-5, 5);
    var y2 = getRandom(-5, 20);
    bp.path[0].storage[0] = -x1;
    bp.path[0].storage[1] = y1;
    bp.path[0].storage[3] = -x2;
    bp.path[0].storage[4] = y2;
    bp.path[0].storage[7] = getRandom(-20, -5);

    bp.path[1].storage[0] = x2;
    bp.path[1].storage[1] = y2;
    bp.path[1].storage[3] = x1;
    bp.path[1].storage[4] = y1;
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

    bp.path[0].storage[0] = x1 * modX;
    bp.path[0].storage[1] = y1 * modY;
    bp.path[0].storage[3] = x2 * modX;
    bp.path[0].storage[4] = y2 * modY;

    bp.path[2].storage[0] = -x2 * modX;
    bp.path[2].storage[1] = y2 * modY;
    bp.path[2].storage[3] = -x1 * modX;
    bp.path[2].storage[4] = y1 * modY;

    bp.path[0].storage[6] = x3 * modX;
    bp.path[0].storage[7] = y3 * modY;
    bp.path[1].storage[6] = -x3 * modX;
    bp.path[1].storage[7] = y3 * modY;

    bp.path[1].storage[0] = x4 * modX;
    bp.path[1].storage[1] = y4 * modY;
    bp.path[1].storage[3] = -x4 * modX;
    bp.path[1].storage[4] = y4 * modY;

  }
}

class TailRandomizingSystem extends RandomizingSystem {
  TailRandomizingSystem() : super(randomizeTailEvent, [Tail]);

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);
    var xMod = random.nextBool() ? 1 : -1;
    var lengthMod = getRandom(0.5, 2.5);
    var x1 = getRandom(90, 150);
    var y1 = getRandom(15, 55);
    var x2 = getRandom(x1 + 20, x1 + 40);
    var y2 = getRandom(y1 - 10, y1 + 10);
    bp.path[0].storage[0] = getRandom(50, 75);
    bp.path[0].storage[1] = getRandom(0, 30);
    bp.path[0].storage[3] = getRandom(100, 150);
    bp.path[0].storage[4] = getRandom(-20, 10);
    bp.path[0].storage[6] = x1;
    bp.path[0].storage[7] = y1;

    bp.path[1].storage[6] = x2;
    bp.path[1].storage[7] = y2;
    // parallel
    bp.path[1].storage[3] = bp.path[1].storage[6] + (bp.path[0].storage[6] - bp.path[0].storage[3]) * getRandom(0.5, 1.5);
    bp.path[1].storage[4] = bp.path[1].storage[7] + (bp.path[0].storage[7] - bp.path[0].storage[4]) * getRandom(0.5, 1.5);
    // parallel
    bp.path[2].storage[3] = (bp.path[0].storage[0] - bp.origin.x.abs()) * 2.5 + bp.path[2].storage[6].abs();
    bp.path[2].storage[4] = (bp.path[0].storage[1] - bp.origin.y) * 2.5 + bp.path[2].storage[7];

    for (int i = 0; i < bp.path.length - 1; i++) {
      var diffX = bp.path[i].storage[6] - bp.path[i].storage[3];
      var diffY = bp.path[i].storage[7] - bp.path[i].storage[4];

      bp.path[i + 1].storage[0] = bp.path[i].storage[6] + diffX * lengthMod;
      bp.path[i + 1].storage[1] = bp.path[i].storage[7] + diffY * lengthMod;
    }

    bp.path.map((segment) => segment.storage).forEach((storage) {
      storage[0] = storage[0].abs() * xMod;
      storage[3] = storage[3].abs() * xMod;
      storage[6] = storage[6].abs() * xMod;
    });
    bp.origin.x = bp.origin.x.abs() * xMod;
  }
}