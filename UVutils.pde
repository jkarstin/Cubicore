/* UVutils.pde
 * 
 * Executes texture wrapping around defined cube shapes.
 * 
 * J Karstin Neill    02.15.2019
 */




/* Model file definition: (.mdl)
 * <img_file_location>
 * <img_width> <img_height>
 * <num_tris>
 * <model_a_x_0> <model_a_y_0> <model_a_z_0> <img_u_0> <img_v_0>
 * <model_b_x_0> <model_b_y_0> <model_b_z_0> <img_u_0> <img_v_0>
 * <model_c_x_0> <model_c_y_0> <model_c_z_0> <img_u_0> <img_v_0>
 * ...
 * <model_a_x_n-1> <model_a_y_n-1> <model_a_z_n-1> <img_u_n-1> <img_v_n-1>
 * <model_b_x_n-1> <model_b_y_n-1> <model_b_z_n-1> <img_u_n-1> <img_v_n-1>
 * <model_c_x_n-1> <model_c_y_n-1> <model_c_z_n-1> <img_u_n-1> <img_v_n-1>
 */




public class UVUtils {
  public static final int CROSS = 0;
  public static final int SHELL = 1;
  
  PShape importModel(String modelPath) {
    String[] lines = loadStrings(modelPath);
    if (lines == null) {
      println("ERROR: Model file '" + modelPath + "' not found!");
      return null;
    }
    
    String texImgPath = lines[0];    
    int numTris = Integer.parseInt(lines[2]);
    
    int texMaxU = -1, texMaxV = -1;
    String texDim = "";
    for (int i=0; i < lines[1].length(); i++) {
      if (lines[1].charAt(i) != ' ')
        texDim += lines[1].charAt(i);
      else if (texDim.length() > 0) {
        if (texMaxU < 0) {
          texMaxU = Integer.parseInt(texDim);
          texDim = "";
        }  
        else texMaxV = Integer.parseInt(texDim);
      }
    }
    if (texDim.length() > 0 && texMaxV < 0)
      texMaxV = Integer.parseInt(texDim);
    
    if (texMaxU < 0 || texMaxV < 0) {
      println("ERROR: Texture image dimensions in model file not formatted correctly!");
      println(lines[1]);
      return null;
    }
    
    //Load in texture image
    PImage tex = loadImage(texImgPath);
    if (tex == null) {
      println("ERROR: Image file '"+ texImgPath +"' not found!");
      return null;
    }
    
    PShape model = createShape(GROUP);
    PShape tri;
    String loc;
    int locIndex;
    for (int t=0; t < numTris; t++) {
      Coord modelCoord = new Coord(), texUV = new Coord();
      tri = createShape();
      tri.setTexture(tex);
      tri.beginShape();
      tri.noStroke();
      for (int p=0; p < 3; p++) {
        loc = "";
        locIndex = 0;
        //<model_p_x_t> <model_p_y_t> <model_p_z_t> <img_u_t> <img_v_t>
        for (int i=0; i < lines[3+3*t+p].length(); i++) {
          if (lines[3+3*t+p].charAt(i) != ' ') {
            loc += lines[3+3*t+p].charAt(i);
          }
          else if (loc.length() > 0) {
            switch (locIndex) {
            case 0:
              modelCoord.setX(Float.parseFloat(loc));
              locIndex++;
              break;
            case 1:
              modelCoord.setY(Float.parseFloat(loc));
              locIndex++;
              break;
            case 2:
              modelCoord.setZ(Float.parseFloat(loc));
              locIndex++;
              break;
            case 3:
              texUV.setX(Float.parseFloat(loc));
              locIndex++;
              break;
            case 4:
              texUV.setY(Float.parseFloat(loc));
              locIndex++;
              break;
            default:
              println("ERROR: Model file tri definition not formatted correctly!");
              println(3+3*t+p + ": " + lines[3+3*t+p]);
              return null;
            };
            loc = "";
          }
        }
        if (loc.length() > 0 && locIndex == 4) {
          texUV.setY(Float.parseFloat(loc));
        }
        tri.vertex(modelCoord.x(), modelCoord.y(), modelCoord.z(), texUV.x(), texUV.y());
      }
      tri.endShape();
      model.addChild(tri);
    }
    
    return model;
  }
  
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
