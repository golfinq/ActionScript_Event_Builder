package flash.events
{
    
    public class DNSResolverEvent extends Event
    {
        public static const LOOKUP:String = "lookup"; // [static] Defines the value of the type property of a lookup event object.

        public var host: String; // The query string, such as a host name, IP address, or service locator used in the call to the lookup() method of the DNSResolver class for which this event is a response.
        public var resourceRecords: Array; // An array containing the resource records returned by the DNS lookup operation.

        public function DNSResolverEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, host:String = "", resourceRecords:Array = null)
        {
            super(type,bubbles,cancelable);
            this.host = host;
            this.resourceRecords = resourceRecords;
        }
        

        // [override] Creates a copy of the DNSResolverEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DNSResolverEvent(this.type,this.bubbles,this.cancelable,this.host,this.resourceRecords);
        }

        // [override] Returns a string that contains all the properties of the DNSResolverEvent object.
        override public function toString():String
        {
            return this.formatToString("DNSResolverEvent","type","bubbles","cancelable","eventPhase",host,resourceRecords);
        }
    }
}