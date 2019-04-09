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
};
