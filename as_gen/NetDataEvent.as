package flash.events
{
    
    public class NetDataEvent extends Event
    {
        public static const MEDIA_TYPE_DATA:String = "mediaTypeData"; // [static] The NetDataEvent.MEDIA_TYPE_DATA constant defines the value of the type property of the NetDataEvent object dispatched when a data message in the media stream is encountered by the NetStream object.

        public var _timestamp: Number; // [read-only] The timestamp of the data message in the media stream.
        public var _info: Object; // [read-only] A data object describing the message.

        public function NetDataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, timestamp:Number = 0, info:Object = null)
        {
            super(type,bubbles,cancelable);
            this._timestamp = timestamp;
            this._info = info;
        }
        

        // [override] Creates a copy of an NetDataEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new NetDataEvent(this.type, this.bubbles, this.cancelable, this.timestamp, this.info);
        }

        // [override] Returns a string that contains all the properties of the NetDataEvent object.
        override public function toString():String
        {
            return this.formatToString("NetDataEvent","type","bubbles","cancelable","eventPhase","timestamp");
        }

        public function get timestamp() : Number
        {
            return this._timestamp;
        }
        

        public function get info() : Object
        {
            return this._info;
        }
        
    }
}

