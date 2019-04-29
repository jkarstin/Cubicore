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
  
  public void setTransform(Transform t) {
    this.mTransform = t;
  }
  
  public void setMesh(Mesh m) {
    this.mMesh = m;
  }
  
  public void setCollider(Collider c) {
    this.mCollider = c;
  }
  
  public Transform transform() {
    return this.mTransform;
  }
  
  public Mesh mesh() {
    return this.mMesh;
  }
  
  public Collider collider() {
    return this.mCollider;
  }
};
