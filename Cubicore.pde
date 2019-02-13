/* Cubicore.pde
 */

final int CROSS = 0;
final int SHELL = 1;

PShape table;
PShape leg1, leg2, leg3, leg4;
PShape cube;

boolean moveLeft=false, moveRight=false, moveForward=false, moveBack=false, turnLeft=false, turnRight=false;

float camPosX = 0, camPosZ = 30;
float camPosY = 0;
float angleY = 0;
float angleX = 0;
final float moveSpeed = 100;
final float turnSpeed = 2;
final float focalDepth = 3000;

void setup() {
  size(1280, 720, P3D);
  
  camera(0, -750, 3000, 0, 0, 0, 0, 1.0, 0);
  
  table = wrapBox("WoodenTable.png", 700, 50, 400);
  cube = wrapCube("bitCubeTexture.png", 80, 100);
  leg1 = wrapBox("TableLeg.png", 40, 500, 40, SHELL);
  leg2 = wrapBox("TableLeg.png", 40, 500, 40, SHELL);
  leg3 = wrapBox("TableLeg.png", 40, 500, 40, SHELL);
  leg4 = wrapBox("TableLeg.png", 40, 500, 40, SHELL);
  if (table == null || cube == null || leg1 == null) exit();
  
  table.addChild(cube);
  cube.rotateY(PI/6);
  cube.translate(0, -75, 0);
  table.addChild(leg1);
  table.addChild(leg2);
  table.addChild(leg3);
  table.addChild(leg4);
  leg1.rotateY(0);
  leg1.translate(-310, 275, 160);
  leg2.rotateY(PI/2);
  leg2.translate(310, 275, 160);
  leg3.rotateY(PI);
  leg3.translate(310, 275, -160);
  leg4.rotateY(3*PI/2);
  leg4.translate(-310, 275, -160);
}


void keyPressed() {
  if (key == 'a') {
    moveLeft = true;
    moveRight = false;
  }
  else if (key == 'd') {
    moveRight = true;
    moveLeft = false;
  }
  
  if (key == 'w') {
    moveForward = true;
    moveBack = false;
  }
  else if (key == 's') {
    moveBack = true;
    moveForward = false;
  }
  
  if (key == 'q') {
    turnLeft = true;
    turnRight = false;
  }
  else if (key == 'e') {
    turnRight = true;
    turnLeft = false;
  }
}

void keyReleased() {
  if (key == 'a') {
    moveLeft = false;
  }
  else if (key == 'd') {
    moveRight = false;
  }
  
  if (key == 'w') {
    moveForward = false;
  }
  else if (key == 's') {
    moveBack = false;
  }
  
  if (key == 'q') {
    turnLeft = false;
  }
  else if (key == 'e') {
    turnRight = false;
  }
}


void draw() {
  background(127);
  
  if (moveLeft) camPosX--;
  else if (moveRight) camPosX++;
  if (moveForward) camPosZ--;
  else if (moveBack) camPosZ++;
  if (turnLeft) angleY--;
  else if (turnRight) angleY++;
  
  camera(moveSpeed*camPosX, moveSpeed*camPosY, moveSpeed*camPosZ, moveSpeed*camPosX + focalDepth*sin(turnSpeed*angleY*PI/180), moveSpeed*camPosY + focalDepth*sin(turnSpeed*angleX*PI/180), moveSpeed*camPosZ - focalDepth*(cos(turnSpeed*angleY*PI/180)), 0, 1.0, 0);
  
  shape(table);
}

PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex) {
  return wrapBox(texImgPath, xTex, yTex, zTex, CROSS);
}

PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex, int layout) {
  return wrapBox(texImgPath, xTex, yTex, zTex, xTex, yTex, zTex, layout);
}

PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex, float xBox, float yBox, float zBox) {
  return wrapBox(texImgPath, xTex, yTex, zTex, xBox, yBox, zBox, CROSS);
}

PShape wrapCube(String texImgPath, int eDim, float cDiam) {
  return wrapBox(texImgPath, eDim, eDim, eDim, cDiam, cDiam, cDiam, SHELL);
}

PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex, float xBox, float yBox, float zBox, int layout) {
  //Load in texture image
  PImage tex = loadImage(texImgPath);
  if (tex == null) {
    println("ERROR: Image file '"+ texImgPath +"' not found!");
    return null;
  }
  
  //Create base quad shapes
  PShape q1 = createShape();
  PShape q2 = createShape();
  PShape q3 = createShape();
  PShape q4 = createShape();
  PShape q5 = createShape();
  PShape q6 = createShape();
  
  //Set source texture for quads
  q1.setTexture(tex);
  q2.setTexture(tex);
  q3.setTexture(tex);
  q4.setTexture(tex);
  q5.setTexture(tex);
  q6.setTexture(tex);
  
  //Generate quad shapes mapped with texture based on given texture layout style
  switch (layout) {
  case 0:
    //CROSS LAYOUT
    q1.beginShape();
    q1.noStroke();
    q1.vertex(-0.5*xBox, -0.5*yBox, -0.5*zBox, 0*xTex+0*zTex, 0*yTex+1*zTex);
    q1.vertex(-0.5*xBox, -0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*yTex+1*zTex);
    q1.vertex(-0.5*xBox,  0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 1*yTex+1*zTex);
    q1.vertex(-0.5*xBox,  0.5*yBox, -0.5*zBox, 0*xTex+0*zTex, 1*yTex+1*zTex);
    q1.endShape();
    
    q2.beginShape();
    q2.noStroke();
    q2.vertex(-0.5*xBox, -0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*yTex+1*zTex);
    q2.vertex( 0.5*xBox, -0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*yTex+1*zTex);
    q2.vertex( 0.5*xBox,  0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 1*yTex+1*zTex);
    q2.vertex(-0.5*xBox,  0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 1*yTex+1*zTex);
    q2.endShape();
    
    q3.beginShape();
    q3.noStroke();
    q3.vertex( 0.5*xBox, -0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*yTex+1*zTex);
    q3.vertex( 0.5*xBox, -0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 0*yTex+1*zTex);
    q3.vertex( 0.5*xBox,  0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 1*yTex+1*zTex);
    q3.vertex( 0.5*xBox,  0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 1*yTex+1*zTex);
    q3.endShape();
    
    q4.beginShape();
    q4.noStroke();
    q4.vertex(-0.5*xBox, -0.5*yBox, -0.5*zBox, 0*xTex+1*zTex, 0*yTex+0*zTex);
    q4.vertex( 0.5*xBox, -0.5*yBox, -0.5*zBox, 1*xTex+1*zTex, 0*yTex+0*zTex);
    q4.vertex( 0.5*xBox, -0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*yTex+1*zTex);
    q4.vertex(-0.5*xBox, -0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*yTex+1*zTex);
    q4.endShape();
    
    q5.beginShape();
    q5.noStroke();
    q5.vertex(-0.5*xBox,  0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 1*yTex+1*zTex);
    q5.vertex( 0.5*xBox,  0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 1*yTex+1*zTex);
    q5.vertex( 0.5*xBox,  0.5*yBox, -0.5*zBox, 1*xTex+1*zTex, 1*yTex+2*zTex);
    q5.vertex(-0.5*xBox,  0.5*yBox, -0.5*zBox, 0*xTex+1*zTex, 1*yTex+2*zTex);
    q5.endShape();
    
    q6.beginShape();
    q6.noStroke();
    q6.vertex(-0.5*xBox,  0.5*yBox, -0.5*zBox, 0*xTex+1*zTex, 1*yTex+2*zTex);
    q6.vertex( 0.5*xBox,  0.5*yBox, -0.5*zBox, 1*xTex+1*zTex, 1*yTex+2*zTex);
    q6.vertex( 0.5*xBox, -0.5*yBox, -0.5*zBox, 1*xTex+1*zTex, 2*yTex+2*zTex);
    q6.vertex(-0.5*xBox, -0.5*yBox, -0.5*zBox, 0*xTex+1*zTex, 2*yTex+2*zTex);
    q6.endShape();
    break;
  default:
  case 1:
    //SHELL LAYOUT
    q1.beginShape();
    q1.noStroke();
    q1.vertex(-0.5*xBox, -0.5*yBox, -0.5*zBox, 0*xTex+0*zTex, 0*xTex+0*yTex+1*zTex);
    q1.vertex(-0.5*xBox, -0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*xTex+0*yTex+1*zTex);
    q1.vertex(-0.5*xBox,  0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*xTex+1*yTex+1*zTex);
    q1.vertex(-0.5*xBox,  0.5*yBox, -0.5*zBox, 0*xTex+0*zTex, 0*xTex+1*yTex+1*zTex);
    q1.endShape();
    
    q2.beginShape();
    q2.noStroke();
    q2.vertex(-0.5*xBox, -0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*xTex+0*yTex+1*zTex);
    q2.vertex( 0.5*xBox, -0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*xTex+0*yTex+1*zTex);
    q2.vertex( 0.5*xBox,  0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*xTex+1*yTex+1*zTex);
    q2.vertex(-0.5*xBox,  0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*xTex+1*yTex+1*zTex);
    q2.endShape();
    
    q3.beginShape();
    q3.noStroke();
    q3.vertex( 0.5*xBox, -0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*xTex+0*yTex+1*zTex);
    q3.vertex( 0.5*xBox, -0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 0*xTex+0*yTex+1*zTex);
    q3.vertex( 0.5*xBox,  0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 0*xTex+1*yTex+1*zTex);
    q3.vertex( 0.5*xBox,  0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*xTex+1*yTex+1*zTex);
    q3.endShape();
    
    q4.beginShape();
    q4.noStroke();
    q4.vertex( 0.5*xBox, -0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 0*xTex+0*yTex+1*zTex);
    q4.vertex(-0.5*xBox, -0.5*yBox, -0.5*zBox, 2*xTex+2*zTex, 0*xTex+0*yTex+1*zTex);
    q4.vertex(-0.5*xBox,  0.5*yBox, -0.5*zBox, 2*xTex+2*zTex, 0*xTex+1*yTex+1*zTex);
    q4.vertex( 0.5*xBox,  0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 0*xTex+1*yTex+1*zTex);
    q4.endShape();
    
    q5.beginShape();
    q5.noStroke();
    q5.vertex(-0.5*xBox, -0.5*yBox,  0.5*zBox, 0*xTex+1*zTex, 0*xTex+0*yTex+1*zTex);
    q5.vertex(-0.5*xBox, -0.5*yBox, -0.5*zBox, 0*xTex+1*zTex, 0*xTex+0*yTex+0*zTex);
    q5.vertex( 0.5*xBox, -0.5*yBox, -0.5*zBox, 1*xTex+1*zTex, 0*xTex+0*yTex+0*zTex);
    q5.vertex( 0.5*xBox, -0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*xTex+0*yTex+1*zTex);
    q5.endShape();
    
    q6.beginShape();
    q6.noStroke();
    q6.vertex( 0.5*xBox,  0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 0*xTex+1*yTex+1*zTex);
    q6.vertex(-0.5*xBox,  0.5*yBox, -0.5*zBox, 1*xTex+2*zTex, 1*xTex+1*yTex+1*zTex);
    q6.vertex(-0.5*xBox,  0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 1*xTex+1*yTex+1*zTex);
    q6.vertex( 0.5*xBox,  0.5*yBox,  0.5*zBox, 1*xTex+1*zTex, 0*xTex+1*yTex+1*zTex);
    q6.endShape();
    break;
  }
  
  //Create and populate final box shape
  PShape box = createShape(GROUP);
  box.addChild(q1);
  box.addChild(q2);
  box.addChild(q3);
  box.addChild(q4);
  box.addChild(q5);
  box.addChild(q6);
  
  //Return box
  return box;
}
