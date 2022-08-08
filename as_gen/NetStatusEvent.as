package flash.events
{
    
    public class NetStatusEvent extends Event
    {
        public static const NET_STATUS:String = "netStatus"; // [static] Defines the value of the type property of a netStatus event object.

        public var info: Object; // An object with properties that describe the object's status or error condition.

        public function NetStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null)
        {
            super(type,bubbles,cancelable);
            this.info = info;
        }
        

        // [override] Creates a copy of the NetStatusEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new NetStatusEvent(this.type, this.bubbles, this.cancelable, this.info);
        }

        // [override] Returns a string that contains all the properties of the NetStatusEvent object.
        override public function toString():String
        {
            return this.formatToString("NetStatusEvent","type","bubbles","cancelable","eventPhase","info");
        }
    }
}

