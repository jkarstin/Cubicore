/* Collider.pde
 * 
 * Collision management class.
 * 
 * J Karstin Neill    04.19.2019
 */

public class Collider {
  public Transform mTransform;
  public Coord mDimensions;
  
  public Collider() {
    this.mTransform = new Transform();
    this.mDimensions = new Coord(1f);
  }
  
  public void setTransform(Transform t) {
    this.mTransform = t;
  }
  
  public void setDimensions(Coord d) {
    this.mDimensions = d;
  }
  
  public Transform transform() {
    return this.mTransform;
  }
  
  public Coord dimensions() {
    return this.mDimensions;
  }
  
  //***** WIP ******
  public boolean collidingWith(Collider other) {
    //Find where 8 collider corners are located in global space for each of the colliders
    
    Coord myLocationGlobal = this.transform().locationGlobal();
    
    return false;
  }
};
