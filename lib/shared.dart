library shared;

import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:tweenengine/tweenengine.dart';
export 'package:tweenengine/tweenengine.dart' hide Timeline;

part 'src/shared/components.dart';

//part 'src/shared/systems/name.dart';
part 'src/shared/systems/logic.dart';

const TAG_RIGHT_EYE = "rightEye";
const TAG_HEAD = "HEAD";

final myManager = new TweenManager();

final randomizeHeadEvent = new EventType<RandomizeHead>();
final randomizeEarsEvent = new EventType<RandomizeEars>();
final randomizeEyesEvent = new EventType<RandomizeEyes>();
final randomizeMouthEvent = new EventType<RandomizeMouth>();
final randomizeTailEvent = new EventType<RandomizeTail>();
final randomizeBodyEvent = new EventType<RandomizeBody>();
final randomizeMonocleEvent = new EventType<RandomizeMonocle>();
final shuffleTextEvent = new EventType<ShuffleText>();

class RandomizeHead {}
class RandomizeEars {}
class RandomizeEyes {}
class RandomizeMouth {}
class RandomizeBody {}
class RandomizeTail {}
class RandomizeMonocle {}
class ShuffleText {}