package flash.events
{
    
    public class ServerSocketConnectEvent extends Event
    {
        public static const CONNECT:String = "connect"; // [static] Defines the value of the type property of a ServerSocketConnectEvent event object.

        public var socket: Socket; // The socket for the new connection.

        public function ServerSocketConnectEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, socket:Socket = null)
        {
            super(type,bubbles,cancelable);
            this.socket = socket;
        }
        

        // [override] Creates a copy of the ServerSocketConnectEvent object and sets each property's value to match that of the original.
        override public function clone():Event
        {
            return new ServerSocketConnectEvent(this.type,this.bubbles,this.cancelable,this.socket);
        }

        // [override] Returns a string that contains all the properties of the ServerSocketConnectEvent object.
        override public function toString():String
        {
            return this.formatToString("ServerSocketConnectEvent","type","bubbles","cancelable","eventPhase",socket);
        }
    }
}