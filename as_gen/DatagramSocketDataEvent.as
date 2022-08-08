package flash.events
{
    
    import flash.utils.ByteArray;
    
    public class DatagramSocketDataEvent extends Event
    {
        public static const DATA:String = "data"; // [static] Defines the value of the type property of a data event object.

        public var srcAddress: String; // The IP address of the machine that sent the packet.
        public var srcPort: int; // The port on the machine that sent the packet.
        public var dstAddress: String; // The IP address of the DatagramSocket object that dispatched this event.
        public var dstPort: int; // The port of the DatagramSocket object that dispatched this event.
        public var data: ByteArray; // The datagram packet data.

        public function DatagramSocketDataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, srcAddress:String = "", srcPort:int = 0, dstAddress:String = "", dstPort:int = 0, data:ByteArray = null)
        {
            super(type,bubbles,cancelable);
            this.srcAddress = srcAddress;
            this.srcPort = srcPort;
            this.dstAddress = dstAddress;
            this.dstPort = dstPort;
            this.data = data;
        }
        

        // [override] Creates a copy of the DatagramSocketDataEvent object and sets each property's value to match that of the original.
        override public function clone():Event
        {
            return new DatagramSocketDataEvent(this.type, this.bubbles, this.cancelable, this.srcAddress, this.srcPort, this.dstAddress, this.dstPort, this.data);
        }

        // [override] Returns a string that contains all the properties of the DatagramSocketDataEvent object.
        override public function toString():String
        {
            return this.formatToString("DatagramSocketDataEvent","type","bubbles","cancelable","eventPhase","srcAddress","srcPort","dstAddress","dstPort","data");
        }
    }
}

