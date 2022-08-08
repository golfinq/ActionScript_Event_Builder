package flash.events
{
    
    import flash.net.NetStream;
    
    public class NetMonitorEvent extends Event
    {
        public static const NET_STREAM_CREATE:String = "netStreamCreate"; // [static] The NetMonitorEvent.NET_STREAM_CREATE constant defines the value of the type property of an netStreamCreate event object.

        public var _netStream: NetStream; // [read-only] The new NetStream object.

        public function NetMonitorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, netStream:NetStream = null)
        {
            super(type,bubbles,cancelable);
            this._netStream = netStream;
        }
        

        // [override] Creates a copy of an NetMonitorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new NetMonitorEvent(this.type, this.bubbles, this.cancelable, this.netStream);
        }

        // [override] Returns a string that contains all the properties of the NetMonitorEvent object.
        override public function toString():String
        {
            return this.formatToString("NetMonitorEvent","type","bubbles","cancelable","eventPhase","netStream");
        }

        public function get netStream() : NetStream
        {
            return this._netStream;
        }
        
    }
}

