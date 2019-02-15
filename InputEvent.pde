public class InputEvent {
  public static final int KEYPRESS = 0;
  public static final int KEYRELEASE = 1;
  
  private int mEventCode;
  private int mKey;
  private int mKeyCode;
  
  public InputEvent(int eCode, int k, int kCode) {
    this.setEventCode(eCode);
    this.setKey(k);
    this.setKeyCode(kCode);
  }
  
  public boolean eventCodeIs(int eCode) {
    return this.mEventCode == eCode;
  }
  
  public boolean keyIs(int k) {
    return this.mKey == k;
  }
  
  public boolean keyCodeIs(int kCode) {
    if (!this.isCoded()) return false;
    else return this.mKeyCode == kCode;
  }
  
  public boolean isCoded() {
    return this.mKey == CODED;
  }
  
  public boolean equals(InputEvent ie) {
    return ie.eventCodeIs(this.mEventCode) && ie.keyCodeIs(this.mKeyCode);
  }
  
  public void setEventCode(int eCode) {
    this.mEventCode = eCode;
  }
  
  public void setKey(int k) {
    this.mKey = k;
  }
  
  public void setKeyCode(int kCode) {
    this.mKeyCode = kCode;
  }
}
