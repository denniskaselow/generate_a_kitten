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

    var x1 = getRandom(50, 90);
    var y1 = getRandom(-20, 0);
    var x2 = getRandom(20, 70);
    var y2 = getRandom(-40, min(y1, -10));

    var x3 = getRandom(max(x2 - 45, 5), x2);
    var y3 = getRandom(-40, y2);
    var x4 = getRandom(30, min(x1, 70));
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
  double x1, x2, y1, y2;
  EyeRandomizingSystem() : super(randomizeEyesEvent, [Eye]);

  @override
  void begin() {
    x1 = getRandom(5, 25);
    y1 = getRandom(-30, 0);
    x2 = getRandom(5, 25);
    y2 = getRandom(-30, 0);
  }

  @override
  void processEntity(Entity entity) {
    var bp = bpm.get(entity);

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