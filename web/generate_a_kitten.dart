import 'package:generate_a_kitten/client.dart';

@MirrorsUsed(targets: const [RenderingSystem
                            ])
import 'dart:mirrors';

void main() {
  new Game().start();
}

class Game extends GameBase {

  Game() : super.noAssets('generate_a_kitten', 'canvas', 800, 600);

  void createEntities() {
    // addEntity([Component1, Component2]);
  }

  List<EntitySystem> getSystems() {
    return [
            new CanvasCleaningSystem(canvas),
            new RenderingSystem(ctx),
            new FpsRenderingSystem(ctx)
    ];
  }
}
