package flash.events
{
    
    public class DataEvent extends TextEvent
    {
        public static const UPLOAD_COMPLETE_DATA:String = "uploadCompleteData"; // [static] Defines the value of the type property of a data event object.
        public static const UPLOAD_COMPLETE_DATA:String = "uploadCompleteData"; // [static] Defines the value of the type property of an uploadCompleteData event object.

        public var data: String; // The raw data loaded into Flash Player or Adobe AIR.

        public function DataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:String = "")
        {
            super(type,bubbles,cancelable, data);
            this.data = data;
        }
        

        // [override] Creates a copy of the DataEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DataEvent(this.type, this.bubbles, this.cancelable, this.text, this.data);
        }

        // [override] Returns a string that contains all the properties of the DataEvent object.
        override public function toString():String
        {
            return this.formatToString("DataEvent","type","bubbles","cancelable","eventPhase","data");
        }
    }
}

