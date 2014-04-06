library shared;

import 'package:event_bus/event_bus.dart';
import 'dart:math';

import 'package:gamedev_helpers/gamedev_helpers_shared.dart';

part 'src/shared/components.dart';

//part 'src/shared/systems/name.dart';
part 'src/shared/systems/logic.dart';

Random random = new Random();
EventBus eventBus = new EventBus();

var randomizeHeadEvent = new EventType<RandomizeHead>();
var randomizeEarsEvent = new EventType<RandomizeEars>();
var randomizeEyesEvent = new EventType<RandomizeEyes>();
var randomizeMouthEvent = new EventType<RandomizeMouth>();

class RandomizeHead {}
class RandomizeEars {}
class RandomizeEyes {}
class RandomizeMouth {}