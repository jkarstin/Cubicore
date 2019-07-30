/* Collider.pde
 * 
 * Collision management class.
 * **** WIP ****
 * Currently only focusing on supporting static rotation cube and sperical collider shapes.
 * Future intent to implement convex hull identification methods to allow for dynamic convex collider geometry.
 * 
 * J Karstin Neill    07.30.2019
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
