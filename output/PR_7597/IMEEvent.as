package flash.events
{
    
    import flash.text.ime.IIMEClient;
    
    public class IMEEvent extends TextEvent
    {
        public static const IME_COMPOSITION:String = "imeComposition"; // [static] Defines the value of the type property of an imeComposition event object.
        public static const IME_START_COMPOSITION:String = "imeStartComposition"; // [static] To handle IME text input, the receiver must set the imeClient field of the event to an object that implements the IIMEClient interface.

        public var imeClient: IIMEClient; // Specifies an object that implements the IMEClient interface.

        public function IMEEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", imeClient:IIMEClient = null)
        {
            super(type,bubbles,cancelable,text);
            this.imeClient = imeClient;
        }
        

        // [override] Creates a copy of the IMEEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new IMEEvent(this.type,this.bubbles,this.cancelable,this.eventPhase,this.text,this.imeClient);
        }

        // [override] Returns a string that contains all the properties of the IMEEvent object.
        override public function toString():String
        {
            return this.formatToString("IMEEvent","type","bubbles","cancelable","eventPhase","activating");
        }
    }
}