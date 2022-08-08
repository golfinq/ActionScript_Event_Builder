package flash.events
{
    
    public class ErrorEvent extends TextEvent
    {
        public static const ERROR:String = "error"; // [static] Defines the value of the type property of an error event object.

        public var _errorID: int; // [read-only] Contains the reference number associated with the specific error.

        public function ErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0)
        {
            super(type,bubbles,cancelable,text);
            this._errorID = id;
        }
        

        // [override] Creates a copy of the ErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new ErrorEvent(this.type, this.bubbles, this.cancelable, this.text, );
        }

        // [override] Returns a string that contains all the properties of the ErrorEvent object.
        override public function toString():String
        {
            return this.formatToString("ErrorEvent","type","bubbles","cancelable","eventPhase","text","errorID");
        }

        public function get errorID() : int
        {
            return this._errorID;
        }
        
    }
}

