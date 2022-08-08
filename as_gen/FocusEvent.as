package flash.events
{
    
    import flash.display.InteractiveObject;
    
    public class FocusEvent extends Event
    {
        public static const FOCUS_IN:String = "focusIn"; // [static] Defines the value of the type property of a focusIn event object.
        public static const FOCUS_OUT:String = "focusOut"; // [static] Defines the value of the type property of a focusOut event object.
        public static const KEY_FOCUS_CHANGE:String = "keyFocusChange"; // [static] Defines the value of the type property of a keyFocusChange event object.
        public static const MOUSE_FOCUS_CHANGE:String = "mouseFocusChange"; // [static] Defines the value of the type property of a mouseFocusChange event object.

        public var relatedObject: InteractiveObject; // A reference to the complementary InteractiveObject instance that is affected by the change in focus.
        public var shiftKey: Boolean; // Indicates whether the Shift key modifier is activated, in which case the value is true.
        public var keyCode: uint; // The key code value of the key pressed to trigger a keyFocusChange event.
        public var direction: String; // Specifies direction of focus for a focusIn event.
        public var isRelatedObjectInaccessible: Boolean; // If true, the relatedObject property is set to null for reasons related to security sandboxes.

        public function FocusEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, relatedObject:InteractiveObject = null, shiftKey:Boolean = false, keyCode:uint = 0, direction:String = "none")
        {
            super(type,bubbles,cancelable);
            this.relatedObject = relatedObject;
            this.shiftKey = shiftKey;
            this.keyCode = keyCode;
            this.direction = direction;
            this.isRelatedObjectInaccessible = false; // Unimplemented
        }
        

        // [override] Creates a copy of the FocusEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new FocusEvent(this.type, this.bubbles, this.cancelable, this.relatedObject, this.shiftKey, this.keyCode, this.direction);
        }

        // [override] Returns a string that contains all the properties of the FocusEvent object.
        override public function toString():String
        {
            return this.formatToString("FocusEvent","type","bubbles","cancelable","eventPhase","relatedObject","shiftKey","keyCode");
        }
    }
}

