/* Transform.pde
 * 
 * World location, rotation, scale management class.
 * 
 * J Karstin Neill    04.19.2019
 */

public class Transform {
  private Coord mLocation;
  private Coord mRotation;
  private Coord mScale;
  private Transform mParent;
  
  public Transform() {
    this.mLocation = new Coord();
    this.mRotation = new Coord();
    this.mScale = new Coord(1f);
    this.mParent = null;
  }
  
  public void setLocationLocal(Coord ll) {
    this.mLocation = ll;
  }
  
  public void setRotationLocal(Coord rl) {
    this.mRotation = rl;
  }
  
  public void setScaleLocal(Coord sl) {
    this.mScale = sl;
  }
  
  public void setParent(Transform p) {
    this.mParent = p;
  }
  
  public Coord locationLocal() {
    return this.mLocation;
  }
  
  public Coord rotationLocal() {
    return this.mRotation;
  }
  
  //****** WIP ******
  public Coord scaleLocal() {
    return this.mScale;
  }
  
  public Transform parent() {
    return this.mParent;
  }
  
  public Coord locationGlobal() {
    if (this.mParent == null) {
      return this.locationLocal();
    }
    else {
      Coord c = this.locationLocal().makeCopy();
      c.rotateZ(this.mParent.rotationGlobal().z());
      c.rotateX(this.mParent.rotationGlobal().x());
      c.rotateY(this.mParent.rotationGlobal().y());
      c.add(this.mParent.locationGlobal());
      return c;
    }
  }
  
  public Coord rotationGlobal() {
    if (this.mParent == null) {
      return this.rotationLocal();
    }
    else {
      return this.mParent.rotationGlobal().plus(this.rotationLocal());
    }
  }
  
  //***** WIP ******
  public Coord scaleGlobal() {
    if (this.mParent == null) {
      return this.scaleLocal();
    }
    else {
      return this.scaleLocal();
    }
  }
};
