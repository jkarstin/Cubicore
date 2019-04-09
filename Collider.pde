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
};
