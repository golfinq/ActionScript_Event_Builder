package flash.events
{
    
    public class IOErrorEvent extends ErrorEvent
    {
        public static const STANDARD_OUTPUT_IO_ERROR:String = "standardOutputIoError"; // [static] Defines the value of the type property of an ioError event object.
        public static const STANDARD_ERROR_IO_ERROR:String = "standardErrorIoError"; // [static] The standardErrorIoError event is dispatched when an error occurs while reading data from the standardError stream of a NativeProcess object.
        public static const STANDARD_INPUT_IO_ERROR:String = "standardInputIoError"; // [static] The standardInputIoError event is dispatched when an error occurs while writing data to the standardInput of a NativeProcess object.
        public static const STANDARD_OUTPUT_IO_ERROR:String = "standardOutputIoError"; // [static] The standardOutputIoError event is dispatched when an error occurs while reading data from the standardOutput stream of a NativeProcess object.

        

        public function IOErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0)
        {
            super(type,bubbles,cancelable,text,id);
            
        }
        

        // [override] Creates a copy of the IOErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new IOErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.errorID);
        }

        // [override] Returns a string that contains all the properties of the IOErrorEvent object.
        override public function toString():String
        {
            return this.formatToString("IOErrorEvent","type","bubbles","cancelable","eventPhase","text", "errorID");
        }
    }
}

