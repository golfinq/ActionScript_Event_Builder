package flash.events
{
    
    public class NativeWindowBoundsEvent extends Event
    {
        public static const MOVE:String = "move"; // [static] Defines the value of the type property of a move event object.
        public static const MOVING:String = "moving"; // [static] Defines the value of the type property of a moving event object.
        public static const RESIZE:String = "resize"; // [static] Defines the value of the type property of a resize event object.
        public static const RESIZING:String = "resizing"; // [static] Defines the value of the type property of a resizing event object.

        public var _beforeBounds: Rectangle; // [read-only] The bounds of the window before the change.
        public var _afterBounds: Rectangle; // [read-only] The bounds of the window after the change.

        public function NativeWindowBoundsEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, beforeBounds:Rectangle = null, afterBounds:Rectangle = null)
        {
            super(type,bubbles,cancelable);
            this._beforeBounds = beforeBounds;
            this._afterBounds = afterBounds;
        }
        

        // [override] Creates a copy of the NativeWindowBoundsEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new NativeWindowBoundsEvent(this.type, this.bubbles, this.cancelable, this.beforeBounds, this.afterBounds);
        }

        // [override] Returns a string that contains all the properties of the NativeWindowBoundsEvent object.
        override public function toString():String
        {
            return this.formatToString("NativeWindowBoundsEvent","type","bubbles","cancelable","eventPhase","previousDisplayState","currentDisplayState");
        }

        public function get beforeBounds() : Rectangle
        {
            return this._beforeBounds;
        }
        

        public function get afterBounds() : Rectangle
        {
            return this._afterBounds;
        }
        
    }
}

