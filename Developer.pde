import java.awt.*;

public class Developer {
  final float moveSpeed = 50;
  final float turnSpeed = 0.5;
  final float focalDepth = 3000;
  final UVUtils UVU = new UVUtils();
  
  PShape table;
  PShape leg1, leg2, leg3, leg4;
  PShape door;
  PShape cube;
  
  boolean moveLeft=false, moveRight=false, moveForward=false, moveBack=false, turnLeft=false, turnRight=false;
  boolean lockMouse, locking;
  
  int middleX, middleY;
  
  Coord moveVect, mouseVect, turnVect;
  Camera cam;
  
  Robot mouseRobot;
  
  public void Start() {
    PVector l = getWindowLocation();
    middleX = (int)l.x+(width/2);
    middleY = (int)l.y+(height/2);
    
    try{
      mouseRobot = new Robot();
    } catch (Exception e) {
      println("ERROR: mouseRobot failed to initialize!");
      exit();
    }
    
    lockMouse = true;
    mouseRobot.mouseMove(middleX, middleY);
    locking = true;
    
    cam = new Camera();
    cam.setActive();
    cam.move(new Coord(0, -2000, 3000));
    
    moveVect = new Coord();
    mouseVect = new Coord();
    turnVect = new Coord();
    
    cam.update();
    
    table = UVU.wrapBox("WoodenTable.png", new Coord(700, 50, 400), new Coord(2000, 50, 1000));
    cube = UVU.wrapCube("bitCubeTexture.png", 80, 100);
    leg1 = UVU.wrapBox("TableLeg.png", new Coord(40, 500, 40), new Coord(50, 1000, 50), UVUtils.SHELL);
    leg2 = UVU.wrapBox("TableLeg.png", new Coord(40, 500, 40), new Coord(50, 1000, 50), UVUtils.SHELL);
    leg3 = UVU.wrapBox("TableLeg.png", new Coord(40, 500, 40), new Coord(50, 1000, 50), UVUtils.SHELL);
    leg4 = UVU.wrapBox("TableLeg.png", new Coord(40, 500, 40), new Coord(50, 1000, 50), UVUtils.SHELL);
    door = UVU.wrapBox("Door.png", new Coord(200, 100, 5), new Coord(2000, 1000, 50));
    if (table == null || cube == null || leg1 == null || leg2 == null || leg3 == null || leg4 == null) exit();
    
    table.addChild(cube);
    cube.rotateY(PI/6);
    cube.translate(0, -75, 0);
    table.addChild(leg1);
    table.addChild(leg2);
    table.addChild(leg3);
    table.addChild(leg4);
    leg1.rotateY(0);
    leg1.translate(-960, 525, 460);
    leg2.rotateY(PI/2);
    leg2.translate(960, 525, 460);
    leg3.rotateY(PI);
    leg3.translate(960, 525, -460);
    leg4.rotateY(3*PI/2);
    leg4.translate(-960, 525, -460);
    table.translate(0, -1025, 0);
    door.rotateZ(-PI/2);
    door.translate(0, 0, -5000);
  }
  
  public void Update() {
    background(127);
    
    //Input gathering
    InputEvent ie = Input.getInputEvent();
    if (ie != null) {
      if (ie.eventCodeIs(InputEvent.KEYPRESS)) {
        if (ie.keyIs('a')) {
          moveLeft = true;
          moveRight = false;
        }
        else if (ie.keyIs('d')) {
          moveRight = true;
          moveLeft = false;
        }
        
        if (ie.keyIs('w')) {
          moveForward = true;
          moveBack = false;
        }
        else if (ie.keyIs('s')) {
          moveBack = true;
          moveForward = false;
        }
        
        if (ie.keyIs(TAB)) {
          lockMouse = !lockMouse;
          if (lockMouse) {
            mouseRobot.mouseMove(Dev.middleX, Dev.middleY);
            locking = true;
          }
          else cursor();
        }
        if (ie.keyIs(ESC)) exit();
      }
      else if (ie.eventCodeIs(InputEvent.KEYRELEASE)) {
        if (ie.keyIs('a')) {
          moveLeft = false;
        }
        else if (ie.keyIs('d')) {
          moveRight = false;
        }
        
        if (ie.keyIs('w')) {
          moveForward = false;
        }
        else if (ie.keyIs('s')) {
          moveBack = false;
        }
      }
    }

    PVector l = getWindowLocation();
    middleX = (int)l.x+(width/2);
    middleY = (int)l.y+(height/2);
    
    //Keep mouse movement from affecting camera until securely locked in center.
    if (locking && mouseX == width/2 && mouseY == height/2) {
      locking = false;
      noCursor();
    }
    
    if (!locking && lockMouse) {
      mouseVect = new Coord(mouseY-(height/2), mouseX-(width/2), 0f);
      mouseRobot.mouseMove(middleX, middleY);
    }
    
    moveVect.constant(0f);
    turnVect.constant(0f);
    
    if (moveLeft)       moveVect.add(new Coord(-1f,  0f,  0f));
    else if (moveRight) moveVect.add(new Coord( 1f,  0f,  0f));
    if (moveForward)    moveVect.add(new Coord( 0f,  0f, -1f));
    else if (moveBack)  moveVect.add(new Coord( 0f,  0f,  1f));
    
    moveVect.normalize();
    cam.move(moveVect.times(moveSpeed));
  
    turnVect.add(mouseVect);
    mouseVect.constant(0f);
    cam.rotate(turnVect.times(turnSpeed*PI/180));
    
    cam.update();
    
    shape(table);
    shape(door);
  }
  
  /* Built from source code located at:
   * https://forum.processing.org/two/discussion/17675/#Comment_72991
   */
  PVector getWindowLocation() {
    PVector l = new PVector();
    com.jogamp.nativewindow.util.Point p = new com.jogamp.nativewindow.util.Point();
    ((com.jogamp.newt.opengl.GLWindow)surface.getNative()).getLocationOnScreen(p);
    l.x = p.getX();
    l.y = p.getY();
    return l;
  }
}
