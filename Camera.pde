/* Camera.pde
 * 
 * Camera management class.
 * 
 * J Karstin Neill    02.15.2019
 */

public class Camera {
  private Coord mLocation;
  private Coord mRotation;
  private Coord mUpVector;
  private float mRotXMax;
  private float mRotXMin;
  private float mNearClippingPlane;
  private float mFarClippingPlane;
  private float mFOV;
  private boolean mActive;
  
  public Camera() {
    this.setLocation(new Coord());
    this.setRotation(new Coord());
    this.setUpVector(new Coord(0f, 1f, 0f));
    this.mRotXMax =  80*PI/180;
    this.mRotXMin = -80*PI/180;
    this.setFOV(PI/3);
    this.setNearClippingPlane(50);
    this.setFarClippingPlane(10000);
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
  
  public void setFOV(float fov) {
    this.mFOV = fov;
  }
  
  public void setNearClippingPlane(float z) {
    this.mNearClippingPlane = z;
  }
  
  public void setFarClippingPlane(float z) {
    this.mFarClippingPlane = z;
  }
  
  public void setActive() {
    this.mActive = true;
  }
  
  public void setInactive() {
    this.mActive = false;
  }
  
  public boolean isActive() {
    return this.mActive;
  }
  
  public void move(Coord moveVect) {
    moveVect.rotateY(this.mRotation.y());
    this.mLocation.add(moveVect);
  }
  
  public void rotate(Coord rotVect) {
    this.mRotation.add(rotVect);
    this.mRotation.clampX(this.mRotXMin, this.mRotXMax);
  }
  
  public void update() {
    if (this.isActive()) {
      Coord focalPointLocVect = new Coord(0f, 0f, -this.mFarClippingPlane);
      focalPointLocVect.rotateX(this.mRotation.x());
      focalPointLocVect.rotateY(this.mRotation.y());
      focalPointLocVect.add(this.mLocation);
      
      float BT = this.mNearClippingPlane*tan(this.mFOV/2f);
      float LR = BT*width/height;
      
      frustum(-LR, LR, -BT, BT, this.mNearClippingPlane, this.mFarClippingPlane);
      camera(this.mLocation.x(), this.mLocation.y(), this.mLocation.z(), focalPointLocVect.x(), focalPointLocVect.y(), focalPointLocVect.z(), this.mUpVector.x(), this.mUpVector.y(), this.mUpVector.z());
    }
    else println("Camera is inactive, activate or update a different camera!");
  }
}
