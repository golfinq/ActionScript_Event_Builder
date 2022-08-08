package flash.events
{
    
    public class AsyncErrorEvent extends ErrorEvent
    {
        public static const ASYNC_ERROR:String = "asyncError"; // [static] The AsyncErrorEvent.ASYNC_ERROR constant defines the value of the type property of an asyncError event object.

        public var error: Error; // The exception that was thrown.

        public function AsyncErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", error:Error = null)
        {
            super(type,bubbles,cancelable,text);
            this.error = error;
        }
        

        // [override] Creates a copy of the AsyncErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new AsyncErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.error);
        }

        // [override] Returns a string that contains all the properties of the AsyncErrorEvent object.
        override public function toString():String
        {
            return this.formatToString("AsyncErrorEvent","type","bubbles","cancelable","eventPhase","text","error");
        }
    }
}

