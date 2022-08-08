package flash.events
{
    
    public class OutputProgressEvent extends Event
    {
        public static const OUTPUT_PROGRESS:String = "outputProgress"; // [static] Defines the value of the type property of an outputProgress event object.

        public var bytesPending: Number; // The number of bytes not yet written when the listener processes the event.
        public var bytesTotal: Number; // The total number of bytes written so far, plus the number of pending bytes to be written.

        public function OutputProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesPending:Number = 0, bytesTotal:Number = 0)
        {
            super(type,bubbles,cancelable);
            this.bytesPending = bytesPending;
            this.bytesTotal = bytesTotal;
        }
        

        // [override] Creates a copy of the OutputProgressEvent object and sets each property's value to match that of the original.
        override public function clone():Event
        {
            return new OutputProgressEvent(this.type, this.bubbles, this.cancelable, this.bytesPending, this.bytesTotal);
        }

        // [override] Returns a string that contains all the properties of the OutputProgressEvent object.
        override public function toString():String
        {
            return this.formatToString("OutputProgressEvent","type","bubbles","cancelable","eventPhase","bytesPending","bytesTotal");
        }
    }
}

