/* Cubicore.pde
 * 
 * Basic 3D game engine designed to make creating 3D games from scratch in Processing a bit easier to manage.
 * 
 * Built using Processing 3.5.3
 * 
 * J Karstin Neill    02.15.2019
 */

final Developer Dev = new Developer();

void setup() {
  size(1280, 720, P3D);
  Input.init();
  Dev.Start();
}

void keyPressed() {
  Input.queueInputEvent(new InputEvent(InputEvent.KEYPRESS, key, keyCode));
}

void keyReleased() {
  Input.queueInputEvent(new InputEvent(InputEvent.KEYRELEASE, key, keyCode));
}

void draw() {
  Dev.Update();  
}
