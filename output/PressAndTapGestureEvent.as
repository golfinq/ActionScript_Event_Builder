package flash.events
{
    
    public class PressAndTapGestureEvent extends GestureEvent
    {
        public static const GESTURE_PRESS_AND_TAP:String = "gesturePressAndTap"; // [static] Defines the value of the type property of a GESTURE_PRESS_AND_TAP touch event object.

        public var tapLocalX: Number; // The horizontal coordinate at which the event occurred relative to the containing interactive object.
        public var tapLocalY: Number; // The vertical coordinate at which the event occurred relative to the containing interactive object.
        private var _tapStageX: Number; // [read-only] The horizontal coordinate at which the tap touch occurred in global Stage coordinates.
        private var _tapStageY: Number; // [read-only] The vertical coordinate at which the tap touch occurred in global Stage coordinates.

        public function PressAndTapGestureEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, phase:String = null, localX:Number = 0, localY:Number = 0, tapLocalX:Number = 0, tapLocalY:Number = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, commandKey:Boolean = false, controlKey:Boolean = false)
        {
            super(type,bubbles,cancelable,phase,localX,localY,ctrlKey,altKey,shiftKey,commandKey,controlKey);
            this.tapLocalX = tapLocalX;
            this.tapLocalY = tapLocalY;
        }
        

        // [override] Creates a copy of the PressAndTapGestureEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new PressAndTapGestureEvent(this.localX,this.localY,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.tapLocalX,this.tapLocalY);
        }

        // [override] Returns a string that contains all the properties of the PressAndTapGestureEvent object.
        override public function toString():String
        {
            return this.formatToString("PressAndTapGestureEvent","localX","localY","ctrlKey","altKey","shiftKey","buttonDown","tapLocalX","tapLocalY","tapStageX","tapStageY");
        }

        public function get tapStageX() : Number
        {
            return this._tapStageX;
        }
        

        public function get tapStageY() : Number
        {
            return this._tapStageY;
        }
        
    }
}