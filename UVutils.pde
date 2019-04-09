/* UVutils.pde
 * 
 * Executes texture wrapping around defined cube shapes.
 * 
 * J Karstin Neill    02.15.2019
 */

public class UVUtils {
  public static final int CROSS = 0;
  public static final int SHELL = 1;
  
  PShape wrapBox(String texImgPath, Coord texDim) {
    return wrapBox(texImgPath, texDim, texDim);
  }
  
  PShape wrapBox(String texImgPath, Coord texDim, int layout) {
    return wrapBox(texImgPath, texDim, texDim, layout);
  }
  
  PShape wrapBox(String texImgPath, Coord texDim, Coord boxDim) {
    return wrapBox(texImgPath, texDim, boxDim, CROSS);
  }
  
  
  
  PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex) {
    return wrapBox(texImgPath, new Coord(xTex, yTex, zTex));
  }
  
  PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex, int layout) {
    return wrapBox(texImgPath, new Coord(xTex, yTex, zTex), layout);
  }
  
  PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex, float xBox, float yBox, float zBox) {
    return wrapBox(texImgPath, new Coord(xTex, yTex, zTex), new Coord(xBox, yBox, zBox));
  }
  
  PShape wrapBox(String texImgPath, float xTex, float yTex, float zTex, float xBox, float yBox, float zBox, int layout) {
    return wrapBox(texImgPath, new Coord(xTex, yTex, zTex), new Coord(xBox, yBox, zBox), layout);
  }
  
  PShape wrapCube(String texImgPath, int eDim, float cDiam) {
    return wrapBox(texImgPath, new Coord(eDim, eDim, eDim), new Coord(cDiam, cDiam, cDiam), SHELL);
  }
  
  PShape wrapBox(String texImgPath, Coord texDim, Coord boxDim, int layout) {
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
    case CROSS:
      //CROSS LAYOUT
      q1.beginShape();
      q1.noStroke();
      q1.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+0*texDim.z(), 0*texDim.y()+1*texDim.z());
      q1.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.y()+1*texDim.z());
      q1.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 1*texDim.y()+1*texDim.z());
      q1.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+0*texDim.z(), 1*texDim.y()+1*texDim.z());
      q1.endShape();
      
      q2.beginShape();
      q2.noStroke();
      q2.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.y()+1*texDim.z());
      q2.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.y()+1*texDim.z());
      q2.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 1*texDim.y()+1*texDim.z());
      q2.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 1*texDim.y()+1*texDim.z());
      q2.endShape();
      
      q3.beginShape();
      q3.noStroke();
      q3.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.y()+1*texDim.z());
      q3.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 0*texDim.y()+1*texDim.z());
      q3.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 1*texDim.y()+1*texDim.z());
      q3.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 1*texDim.y()+1*texDim.z());
      q3.endShape();
      
      q4.beginShape();
      q4.noStroke();
      q4.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.y()+0*texDim.z());
      q4.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.y()+0*texDim.z());
      q4.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.y()+1*texDim.z());
      q4.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.y()+1*texDim.z());
      q4.endShape();
      
      q5.beginShape();
      q5.noStroke();
      q5.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 1*texDim.y()+1*texDim.z());
      q5.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 1*texDim.y()+1*texDim.z());
      q5.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 1*texDim.y()+2*texDim.z());
      q5.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 1*texDim.y()+2*texDim.z());
      q5.endShape();
      
      q6.beginShape();
      q6.noStroke();
      q6.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 1*texDim.y()+2*texDim.z());
      q6.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 1*texDim.y()+2*texDim.z());
      q6.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 2*texDim.y()+2*texDim.z());
      q6.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 2*texDim.y()+2*texDim.z());
      q6.endShape();
      break;
    default:
    case SHELL:
      //SHELL LAYOUT
      q1.beginShape();
      q1.noStroke();
      q1.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+0*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q1.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q1.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q1.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+0*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q1.endShape();
      
      q2.beginShape();
      q2.noStroke();
      q2.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q2.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q2.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q2.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q2.endShape();
      
      q3.beginShape();
      q3.noStroke();
      q3.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q3.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q3.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q3.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q3.endShape();
      
      q4.beginShape();
      q4.noStroke();
      q4.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q4.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 2*texDim.x()+2*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q4.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 2*texDim.x()+2*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q4.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q4.endShape();
      
      q5.beginShape();
      q5.noStroke();
      q5.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q5.vertex(-0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 0*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+0*texDim.z());
      q5.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+0*texDim.z());
      q5.vertex( 0.5*boxDim.x(), -0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.x()+0*texDim.y()+1*texDim.z());
      q5.endShape();
      
      q6.beginShape();
      q6.noStroke();
      q6.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
      q6.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(), -0.5*boxDim.z(), 1*texDim.x()+2*texDim.z(), 1*texDim.x()+1*texDim.y()+1*texDim.z());
      q6.vertex(-0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 1*texDim.x()+1*texDim.y()+1*texDim.z());
      q6.vertex( 0.5*boxDim.x(),  0.5*boxDim.y(),  0.5*boxDim.z(), 1*texDim.x()+1*texDim.z(), 0*texDim.x()+1*texDim.y()+1*texDim.z());
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
}
