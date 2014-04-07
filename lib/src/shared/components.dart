part of shared;


class BezierPath extends Component {
  Vector2 offset;
  Vector2 origin;
  List<Matrix3> path;
  BezierPath(this.offset, this.origin, this.path);
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