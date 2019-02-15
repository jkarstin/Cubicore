/* Cubicore.pde
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
