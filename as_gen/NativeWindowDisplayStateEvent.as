package flash.events
{
    
    public class NativeWindowDisplayStateEvent extends Event
    {
        public static const DISPLAY_STATE_CHANGE:String = "displayStateChange"; // [static] Defines the value of the type property of a displayStateChange event object.
        public static const DISPLAY_STATE_CHANGING:String = "displayStateChanging"; // [static] Defines the value of the type property of a displayStateChanging event object.

        public var _beforeDisplayState: String; // [read-only] The display state of the NativeWindow before the change.
        public var _afterDisplayState: String; // [read-only] The display state of the NativeWindow after the change.

        public function NativeWindowDisplayStateEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, beforeDisplayState:String = "", afterDisplayState:String = "")
        {
            super(type,bubbles,cancelable);
            this._beforeDisplayState = beforeDisplayState;
            this._afterDisplayState = afterDisplayState;
        }
        

        // [override] Creates a copy of the NativeWindowDisplayStateEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new NativeWindowDisplayStateEvent(this.type, this.bubbles, this.cancelable, this.beforeDisplayState, this.afterDisplayState);
        }

        // [override] Returns a string that contains all the properties of the NativeWindowDisplayStateEvent object.
        override public function toString():String
        {
            return this.formatToString("NativeWindowDisplayStateEvent","type","bubbles","cancelable","eventPhase","beforeDisplayState","afterDisplayState");
        }

        public function get beforeDisplayState() : String
        {
            return this._beforeDisplayState;
        }
        

        public function get afterDisplayState() : String
        {
            return this._afterDisplayState;
        }
        
    }
}

