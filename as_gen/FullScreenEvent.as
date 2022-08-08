package flash.events
{
    
    public class FullScreenEvent extends ActivityEvent
    {
        public static const FULL_SCREEN_INTERACTIVE_ACCEPTED:String = "fullScreenInteractiveAccepted"; // [static] The FullScreenEvent.FULL_SCREEN constant defines the value of the type property of a fullScreen event object.
        public static const FULL_SCREEN_INTERACTIVE_ACCEPTED:String = "fullScreenInteractiveAccepted"; // [static] The FULL_SCREEN_INTERACTIVE_ACCEPTED:String constant defines the value of the type property of a fullScreenInteractiveAccepted event object.

        public var _fullScreen: Boolean; // [read-only] Indicates whether the Stage object is in full-screen mode (true) or not (false).
        public var _interactive: Boolean; // [read-only] Indicates whether the Stage object is in full-screen interactive mode (true) or not (false).

        public function FullScreenEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, fullScreen:Boolean = false, interactive:Boolean = false)
        {
            super(type,bubbles,cancelable);
            this._fullScreen = fullScreen;
            this._interactive = interactive;
        }
        

        // [override] Creates a copy of a FullScreenEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new FullScreenEvent(this.type, this.bubbles, this.cancelable, this.	activatingthis.fullScreen, this.interactive);
        }

        // [override] Returns a string that contains all the properties of the FullScreenEvent object.
        override public function toString():String
        {
            return this.formatToString("FullScreenEvent","type","bubbles","cancelable","eventPhase","activating");
        }

        public function get fullScreen() : Boolean
        {
            return this._fullScreen;
        }
        

        public function get interactive() : Boolean
        {
            return this._interactive;
        }
        
    }
}

