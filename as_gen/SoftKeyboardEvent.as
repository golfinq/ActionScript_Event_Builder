package flash.events
{
    
    import flash.display.InteractiveObject;
    
    public class SoftKeyboardEvent extends Event
    {
        public static const SOFT_KEYBOARD_ACTIVATE:String = "softKeyboardActivate"; // [static] The SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE constant defines the value of the type property SoftKeyboardEvent object when a soft keyboard is displayed.
        public static const SOFT_KEYBOARD_ACTIVATING:String = "softKeyboardActivating"; // [static] The SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATING constant defines the value of the type property SoftKeyboardEvent object immediately before a soft keyboard is displayed.
        public static const SOFT_KEYBOARD_DEACTIVATE:String = "softKeyboardDeactivate"; // [static] The SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE constant defines the value of the type property SoftKeyboardEvent object when a soft keyboard is lowered or hidden.

        public var relatedObject: InteractiveObject; // A reference to a display list object that is related to the event.
        public var _triggerType: String; // [read-only] Indicates whether the change in keyboard status has been triggered by an application (such as programmatic use of requestSoftKeyboard()) or by the user (such as selecting a text field).

        public function SoftKeyboardEvent(type:String, bubbles:Boolean, cancelable:Boolean, relatedObjectVal:InteractiveObject, triggerTypeVal:String)
        {
            super(type,bubbles,cancelable);
            this.relatedObject = relatedObjectVal;
            this._triggerType = triggerTypeVal;
        }
        

        // [override] Creates a copy of a SoftKeyboardEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new SoftKeyboardEvent(this.type, this.bubbles, this.cancelable, this.relatedObject, this.triggerType);
        }

        // [override] Returns a string that contains all the properties of the SoftKeyboardEvent object.
        override public function toString():String
        {
            return this.formatToString("SoftKeyboardEvent","type","bubbles","cancelable","eventPhase","relatedObjectVal","triggerTypeVal", "activating");
        }

        public function get triggerType() : String
        {
            return this._triggerType;
        }
        
    }
}

