package flash.events
{
    
    public class KeyboardEvent extends Event
    {
        public static const KEY_DOWN:String = "keyDown"; // [static] The KeyboardEvent.KEY_DOWN constant defines the value of the type property of a keyDown event object.
        public static const KEY_UP:String = "keyUp"; // [static] The KeyboardEvent.KEY_UP constant defines the value of the type property of a keyUp event object.

        public var charCode: uint; // Contains the character code value of the key pressed or released.
        public var keyCode: uint; // The key code value of the key pressed or released.
        public var keyLocation: uint; // Indicates the location of the key on the keyboard.
        public var ctrlKey: Boolean; // On Windows and Linux, indicates whether the Ctrl key is active (true) or inactive (false); On Mac OS, indicates whether either the Ctrl key or the Command key is active.
        public var altKey: Boolean; // Indicates whether the Alt key is active (true) or inactive (false) on Windows; indicates whether the Option key is active on Mac OS.
        public var shiftKey: Boolean; // Indicates whether the Shift key modifier is active (true) or inactive (false).
        public var controlKey: Boolean; // Indicates whether the Control key is active (true) or inactive (false).
        public var commandKey: Boolean; // Indicates whether the Command key is active (true) or inactive (false).

        public function KeyboardEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, charCodeValue:uint = 0, keyCodeValue:uint = 0, keyLocationValue:uint = 0, ctrlKeyValue:Boolean = false, altKeyValue:Boolean = false, shiftKeyValue:Boolean = false, controlKeyValue:Boolean = false, commandKeyValue:Boolean = false)
        {
            super(type,bubbles,cancelable);
            this.charCode = charCodeValue;
            this.keyCode = keyCodeValue;
            this.keyLocation = keyLocationValue;
            this.ctrlKey = ctrlKeyValue;
            this.altKey = altKeyValue;
            this.shiftKey = shiftKeyValue;
            this.controlKey = controlKeyValue;
            this.commandKey = commandKeyValue;
        }
        

        // [override] Creates a copy of the KeyboardEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new KeyboardEvent(this.type, this.bubbles, this.cancelable, this.charCode, this.keyCode, this.keyLocation, this.ctrlKey, this.altKey, this.shiftKey, this.controlKey, this.commandKey);
        }

        // [override] Returns a string that contains all the properties of the KeyboardEvent object.
        override public function toString():String
        {
            return this.formatToString("KeyboardEvent","type","bubbles","cancelable","eventPhase","charCode","keyCode","keyLocation","ctrlKey","altKey","shiftKey","controlKey","commandKey");
        }

        // Indicates that the display should be rendered after processing of this event completes, if the display list has been modified
        public function updateAfterEvent():void
        {
            // Unknown Implementation
        }
    }
}

