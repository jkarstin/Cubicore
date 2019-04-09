/* GameObject.pde
 * 
 * Game world object management class.
 * 
 * J Karstin Neill    04.19.2019
 */

public class GameObject {
  private Transform mTransform;
  private Mesh mMesh;
  private Collider mCollider;
  
  public GameObject() {
    this.mTransform = new Transform();
    this.mMesh = new Mesh();
    this.mCollider = new Collider();
  }
};
