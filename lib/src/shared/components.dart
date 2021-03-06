part of shared;


class BezierPath extends Component implements Tweenable {
  static const OFFSET = -1;
  static const ORIGIN = -2;

  Vector2 offset;
  Vector2 origin;
  List<Matrix3> path;
  BezierPath(this.offset, this.origin, this.path);

  @override
  int getTweenableValues(int tweenType, List<num> returnValues) {
    switch (tweenType) {
      case OFFSET:
        returnValues[0] = offset.x;
        returnValues[1] = offset.y;
        return 2;
      case ORIGIN:
        returnValues[0] = origin.x;
        returnValues[1] = origin.y;
        return 2;
      default:
        path[tweenType].copyIntoArray(returnValues);
        return 9;
    }
    return 0;
  }

  @override
  void setTweenableValues(int tweenType, List<num> newValues) {
    switch (tweenType) {
      case OFFSET:
        offset.x = newValues[0];
        offset.y = newValues[1];
        break;
      case ORIGIN:
        origin.x = newValues[0];
        origin.y = newValues[1];
        break;
      default:
        List<double> values = new List<double>.from(newValues);
        path[tweenType].copyFromArray(values);
        break;
    }
  }
}

class FillStyle extends Component {
  int hue;
  num saturation;
  num lightness;
  num alpha;
  FillStyle({this.hue: 0, this.saturation: 0, this.lightness: 100, this.alpha: 1});
}

class Head extends Component {}
class Eye extends Component {
  double modX;
  Eye({this.modX: 1.0});
}
class Mouth extends Component {
  double modX;
  Mouth({this.modX: 1.0});
}
class Tail extends Component {}
class Body extends Component {
  double modX, modY;
  Body({this.modX: 1.0, this.modY: 1.0});
}
class Accessory extends Component {}
class Monocle extends Component {}

class Word extends Component implements Tweenable {
  static const POSITION = 0;
  static const ANGLE = 1;
  String value;
  double baseX, baseY;
  double x, y;
  double angle;
  Word(this.value, num x, num y, {this.angle: 0.0})
      : this.baseX = x.toDouble(),
        this.baseY = y.toDouble(),
        this.x = x.toDouble(),
        this.y = y.toDouble();

  @override
  int getTweenableValues(int tweenType, List<num> returnValues) {
    switch (tweenType) {
      case POSITION:
        returnValues[0] = x;
        returnValues[1] = y;
        return 2;
      case ANGLE:
        returnValues[0] = angle;
        return 1;
      default:
        return 0;
    }
  }

  @override
  void setTweenableValues(int tweenType, List<num> newValues) {
      switch (tweenType) {
        case POSITION:
          x = newValues[0];
          y = newValues[1];
          break;
        case ANGLE:
          angle = newValues[0];
          break;
      }
  }
}