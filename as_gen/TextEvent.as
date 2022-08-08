package flash.events
{
    
    public class TextEvent extends Event
    {
        public static const LINK:String = "link"; // [static] Defines the value of the type property of a link event object.
        public static const TEXT_INPUT:String = "textInput"; // [static] Defines the value of the type property of a textInput event object.

        public var text: String; // For a textInput event, the character or sequence of characters entered by the user.

        public function TextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "")
        {
            super(type,bubbles,cancelable);
            this.text = text;
        }
        

        // [override] Creates a copy of the TextEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new TextEvent(this.type, this.bubbles, this.cancelable, this.text);
        }

        // [override] Returns a string that contains all the properties of the TextEvent object.
        override public function toString():String
        {
            return this.formatToString("TextEvent","type","bubbles","cancelable","eventPhase","text");
        }
    }
}

