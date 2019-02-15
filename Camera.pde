public class Camera {
  private Coord mLocation;
  private Coord mRotation;
  private Coord mUpVector;
  private float mNearClippingPlane;
  private float mFarClippingPlane;
  private float mFOV;
  private boolean mActive;
  
  public Camera() {
    this.setLocation(new Coord());
    this.setRotation(new Coord());
    this.setUpVector(new Coord(0f, 1f, 0f));
    this.setInactive();
  }
  
  public void setLocation(Coord loc) {
    this.mLocation = loc;
  }
  
  public void setRotation(Coord rot) {
    this.mRotation = rot;
  }
  
  public void setUpVector(Coord up) {
    this.mUpVector = up;
  }
  
  public void setActive() {
    this.mActive = true;
  }
  
  public void setInactive() {
    this.mActive = false;
  }
  
  public void update() {
    
  }
}
