public class Ray {
  private Coord mOrigin;
  private Coord mDirection;
  private float mDistance;
  
  public Ray() {
    this.mOrigin = new Coord();
    this.mDirection = new Coord();
    this.mDistance = 0;
  }
  public Ray(Coord origin, Coord direction, float distance) {
    this.mOrigin = origin;
    this.mDirection = direction;
    this.mDistance = distance;
  }
};
