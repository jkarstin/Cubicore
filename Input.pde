public static class Input {
  private final static int sQUEUESIZE = 8;
  
  private static InputEvent[] sInputEventQueue;
  private static int sInputEventsQueued;
  
  public static void init() {
    sInputEventQueue = new InputEvent[sQUEUESIZE];
    sInputEventsQueued = 0;
  }
  
  public static void queueInputEvent(InputEvent ie) {
    if (sInputEventsQueued >= sQUEUESIZE) {
      sInputEventsQueued = sQUEUESIZE;
      for (int i=1; i < sQUEUESIZE; i++) {
        sInputEventQueue[i-1] = sInputEventQueue[i];
      }
    }
    sInputEventQueue[sInputEventsQueued++] = ie;
  }
  
  public static InputEvent getInputEvent() {
    if (sInputEventsQueued > 0) {
      return sInputEventQueue[(sInputEventsQueued--)-1];
    }
    else return null;
  }
}
