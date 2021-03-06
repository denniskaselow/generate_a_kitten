import 'package:generate_a_kitten/client.dart';

@MirrorsUsed(targets: const [BezierRenderingSystem, DebugBezierRenderingSystem,
                             RandomizingSystem, EarsRandomizingSystem,
                             HeadRandomizingSystem, EyeRandomizingSystem,
                             MouthRandomizingSystem, TailRandomizingSystem,
                             BodyRandomizingSystem, MonocleRenderingSystem,
                             BodyPartRenderingSystem, MonocleUpdatingSystem,
                             RandomizingBezierPathSystem, ShuffleTextSystem,
                             OttificationSystem
                            ])
import 'dart:mirrors';

void main() {
  Tween.combinedAttributesLimit = 9;
  new Game().start();
}

class Game extends GameBase {

  Game() : super.noAssets('generate_a_kitten', 'canvas', 500, 350);

  void createEntities() {
    var tm = world.getManager(TagManager);
    Entity e;
    // tail
    addEntity([new Tail(),
               new FillStyle(),
               new BezierPath(
        new Vector2(0.0, -25.0), new Vector2(40.0, 40.0), [
          new Matrix3(60.0, 15.0, 0.0, 120.0, -10.0, 0.0, 110.0, 35.0, 0.0),
          new Matrix3(100.0, 80.0, 0.0, 120.0, 75.0, 0.0, 130.0, 45.0, 0.0),
          new Matrix3(140.0, 15.0, 0.0, 160.0, -65.0, 0.0, 40.0, 15.0, 0.0)
        ])
    ]);
    // body behind
    addEntity([new Body(modX: 0.45, modY: 0.85),
               new FillStyle(),
               new BezierPath(
        new Vector2(0.0, -15.0), new Vector2(-30.0, 0.0), [
          // left leg
          new Matrix3(-30.0, 140.0, 0.0, -10.0, 120.0, 0.0, -5.0, 50.0, 0.0),
          // lower body
          new Matrix3(-5.0, 50.0, 0.0, 10.0, 50.0, 0.0, 5.0, 50.0, 0.0),
          // right leg
          new Matrix3(5.0, 120.0, 0.0, 30.0, 140.0, 0.0, 30.0, 0.0, 0.0)
        ])
    ]);
    // body front
    addEntity([new Body(),
               new FillStyle(),
               new BezierPath(
        new Vector2(0.0, -10.0), new Vector2(-40.0, -10.0), [
          // left leg
          new Matrix3(-55.0, 160.0, 0.0, -15.0, 140.0, 0.0, -20.0, 70.0, 0.0),
          // lower body
          new Matrix3(-20.0, 70.0, 0.0, 20.0, 70.0, 0.0, 20.0, 70.0, 0.0),
          // right leg
          new Matrix3(20.0, 140.0, 0.0, 55.0, 160.0, 0.0, 40.0, -10.0, 0.0)
        ])
    ]);
    // head
    e = addEntity([new Head(),
               new FillStyle(),
               new BezierPath(
        new Vector2(0.0, -80.0), new Vector2(-70.0, 10.0), [
          // left ear
          new Matrix3(-70.0, 10.0, 0.0, -80.0, -40.0, 0.0, -80.0, -40.0, 0.0),
          new Matrix3(-80.0, -40.0, 0.0, -50.0, -10.0, 0.0, -50.0, -10.0, 0.0),
          // upper head
          new Matrix3(-30.0, -30.0, 0.0, 30.0, -30.0, 0.0, 50.0, -10.0, 0.0),
          // right ear
          new Matrix3(50.0, -10.0, 0.0, 80.0, -40.0, 0.0, 80.0, -40.0, 0.0),
          new Matrix3(80.0, -40.0, 0.0, 70.0, 10.0, 0.0, 70.0, 10.0, 0.0),
          // lower head
          new Matrix3(70.0, 120.0, 0.0, -70.0, 120.0, 0.0, -70.0, 10.0, 0.0)
        ])
    ]);
    tm.register(e, TAG_HEAD);
    // left eye
    addEntity([new Eye(modX: -1.0),
               new FillStyle(),
               new BezierPath(
        new Vector2(-40.0, -50.0), new Vector2(10.0, 0.0), [
          new Matrix3(10.0, -20.0, 0.0, -10.0, -20.0, 0.0, -10.0, 0.0, 0.0),
          new Matrix3(-10.0, 20.0, 0.0, 10.0, 20.0, 0.0, 10.0, 0.0, 0.0)
        ])
    ]);
    // right eye
    e = addEntity([new Eye(),
               new FillStyle(),
               new BezierPath(
        new Vector2(40.0, -50.0), new Vector2(10.0, 0.0), [
          new Matrix3(10.0, -20.0, 0.0, -10.0, -20.0, 0.0, -10.0, 0.0, 0.0),
          new Matrix3(-10.0, 20.0, 0.0, 10.0, 20.0, 0.0, 10.0, 0.0, 0.0)
       ])
    ]);
    tm.register(e, TAG_RIGHT_EYE);
    // monocle
    addEntity([new Monocle(),
               new FillStyle(alpha: 0),
               new BezierPath(
        new Vector2(40.0, -50.0), new Vector2(18.0, 0.0), [
          new Matrix3(18.0, -25.0, 0.0, -18.0, -25.0, 0.0, -18.0, 0.0, 0.0),
          new Matrix3(-18.0, 25.0, 0.0, 18.0, 25.0, 0.0, 18.0, 0.0, 0.0),
          new Matrix3(18.0, 18.0, 0.0, 10.0, 18.0, 0.0, 10.0, 18.0, 0.0),
          new Matrix3(10.0, 125.0, 0.0, -20.0, 125.0, 0.0, -20.0, 60.0, 0.0),
       ])
    ]);
    // mouth
    addEntity([new Mouth(),
               new FillStyle(),
               new BezierPath(
        new Vector2(0.0, -20.0), new Vector2(-15.0, 0.0), [
          new Matrix3(-25.0, 10.0, 0.0, 0.0, 10.0, 0.0, 0.0, -5.0, 0.0),
          new Matrix3(0.0, -5.0, 0.0, -5.0, -10.0, 0.0, -5.0, -10.0, 0.0)
       ])
    ]);
    addEntity([new Mouth(modX: -1.0),
               new FillStyle(),
               new BezierPath(
        new Vector2(0.0, -20.0), new Vector2(15.0, 0.0), [
          new Matrix3(25.0, 10.0, 0.0, 0.0, 10.0, 0.0, 0.0, -5.0, 0.0),
          new Matrix3(0.0, -5.0, 0.0, 5.0, -10.0, 0.0, 5.0, -10.0, 0.0)
       ])
    ]);
    for (int i = 0; i < 6; i++) {
      addEntity([new Word('Molpy', 100 + (i % 2) * 300, 50 + (i ~/ 2) * 60, angle: -PI/4 + PI/2 * random.nextDouble())]);
    }
    for (int i = 0; i < 2; i++) {
      addEntity([new Word('Grapevine', 100 + (i % 2) * 300, 230, angle: -PI/4 + PI/2 * random.nextDouble())]);
    }
  }

  List<EntitySystem> getSystems() {
    return [
            new ButtonListeningSystem(canvas),
            new HeadRandomizingSystem(),
            new EarsRandomizingSystem(),
            new EyeRandomizingSystem(),
            new MouthRandomizingSystem(),
            new BodyRandomizingSystem(),
            new TailRandomizingSystem(),
            new ShuffleTextSystem(),
            new MonocleUpdatingSystem(),
            new CanvasCleaningSystem(canvas),
            new TweeningSystem(),
            new OttificationSystem(canvas),
            new BodyPartRenderingSystem(ctx),
            new MonocleRenderingSystem(ctx),
            new DebugBezierRenderingSystem(ctx),
//            new FpsRenderingSystem(ctx)
            new AnalyticsSystem(AnalyticsSystem.ITCHIO, 'Kitten')
    ];
  }

  Future onInit() {
    world.addManager(new TagManager());
  }
}
