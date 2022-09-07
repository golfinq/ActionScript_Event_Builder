package flash.events
{
    
    public class StatusEvent extends Event
    {
        public static const STATUS:String = "status"; // [static] Defines the value of the type property of a status event object.

        public var code: String; // A description of the object's status.
        public var level: String; // The category of the message, such as "status", "warning" or "error".

        public function StatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, code:String = "", level:String = "")
        {
            super(type,bubbles,cancelable);
            this.code = code;
            this.level = level;
        }
        

        // [override] Creates a copy of the StatusEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new StatusEvent(this.type,this.bubbles,this.cancelable,this.code,this.level);
        }

        // [override] Returns a string that contains all the properties of the StatusEvent object.
        override public function toString():String
        {
            return this.formatToString("StatusEvent","type","bubbles","cancelable","eventPhase",code,level);
        }
    }
}