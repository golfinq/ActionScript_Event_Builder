package flash.events
{
    
    public class ScreenMouseEvent extends MouseEvent
    {
        public static const RIGHT_CLICK:String = "rightClick"; // [static] The ScreenMouseEvent.CLICK constant defines the value of the type property of a click event object.
        public static const RIGHT_MOUSE_DOWN:String = "rightMouseDown"; // [static] The ScreenMouseEvent.MOUSE_DOWN constant defines the value of the type property of a mouseDown event object.
        public static const RIGHT_MOUSE_UP:String = "rightMouseUp"; // [static] The ScreenMouseEvent.MOUSE_UP constant defines the value of the type property of a mouseUp event object.
        public static const RIGHT_CLICK:String = "rightClick"; // [static] The ScreenMouseEvent.RIGHT_CLICK constant defines the value of the type property of a rightClick event object.
        public static const RIGHT_MOUSE_DOWN:String = "rightMouseDown"; // [static] The ScreenMouseEvent.RIGHT_MOUSE_DOWN constant defines the value of the type property of a rightMouseDown event object.
        public static const RIGHT_MOUSE_UP:String = "rightMouseUp"; // [static] The ScreenMouseEvent.RIGHT_MOUSE_UP constant defines the value of the type property of a rightMouseUp event object.

        private var _screenX: Number; // [read-only] The X position of the click in screen coordinates.
        private var _screenY: Number; // [read-only] The Y position of the click in screen coordinates.

        public function ScreenMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, screenX:Number = NaN, screenY:Number = NaN, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, commandKey:Boolean = false, controlKey:Boolean = false)
        {
            super(type,bubbles,cancelable,ctrlKey,altKey,shiftKey,buttonDown,commandKey,controlKey);
            this._screenX = screenX;
            this._screenY = screenY;
        }
        

        // [override] Creates a copy of the ScreenMouseEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new ScreenMouseEvent(this.localX,this.localY,this.relatedObject,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.screenX,this.screenY);
        }

        // [override] Returns a string that contains all the properties of the ScreenMouseEvent object.
        override public function toString():String
        {
            return this.formatToString("ScreenMouseEvent");
        }

        public function get screenX() : Number
        {
            return this._screenX;
        }
        

        public function get screenY() : Number
        {
            return this._screenY;
        }
        
    }
}