package flash.events
{
    
    public class GestureEvent extends Event
    {
        public static const GESTURE_TWO_FINGER_TAP:String = "gestureTwoFingerTap"; // [static] Defines the value of the type property of a GESTURE_TWO_FINGER_TAP gesture event object.

        public var phase: String; // A value from the GesturePhase class indicating the progress of the touch gesture.
        public var localX: Number; // The horizontal coordinate at which the event occurred relative to the containing sprite.
        public var localY: Number; // The vertical coordinate at which the event occurred relative to the containing sprite.
        public var ctrlKey: Boolean; // On Windows or Linux, indicates whether the Ctrl key is active (true) or inactive (false).
        public var altKey: Boolean; // Indicates whether the Alt key is active (true) or inactive (false).
        public var shiftKey: Boolean; // Indicates whether the Shift key is active (true) or inactive (false).
        public var commandKey: Boolean; // Indicates whether the command key is activated (Mac only).
        public var controlKey: Boolean; // Indicates whether the Control key is activated on Mac and whether the Ctrl key is activated on Windows or Linux.
        private var _stageX: Number; // [read-only] The horizontal coordinate at which the event occurred in global Stage coordinates.
        private var _stageY: Number; // [read-only] The vertical coordinate at which the event occurred in global Stage coordinates.

        public function GestureEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, phase:String = null, localX:Number = 0, localY:Number = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, commandKey:Boolean = false, controlKey:Boolean = false)
        {
            super(type,bubbles,cancelable);
            this.phase = phase;
            this.localX = localX;
            this.localY = localY;
            this.ctrlKey = ctrlKey;
            this.altKey = altKey;
            this.shiftKey = shiftKey;
            this.commandKey = commandKey;
            this.controlKey = controlKey;
        }
        

        // [override] Creates a copy of the GestureEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new GestureEvent(this.type,this.bubbles,this.cancelable,this.phase,this.localX,this.localY,this.ctrlKey,this.altKey,this.shiftKey,this.commandKey,this.controlKey);
        }

        // [override] Returns a string that contains all the properties of the GestureEvent object.
        override public function toString():String
        {
            return this.formatToString("GestureEvent","type","bubbles","cancelable","eventPhase","phase","localX","localY","ctrlKey","altKey","shiftKey","commandKey","controlKey","stageX","stageY");
        }

        // Refreshes the Flash runtime display after processing the gesture event, in case the display list has been modified by the event handler.
        public function updateAfterEvent():void
        {
            // Unknown Implementation
        }

        public function get stageX() : Number
        {
            return this._stageX;
        }
        

        public function get stageY() : Number
        {
            return this._stageY;
        }
        
    }
}