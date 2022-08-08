package flash.events
{
    
    import flash.media.MediaPromise;
    
    public class MediaEvent extends Event
    {
        public static const COMPLETE:String = "complete"; // [static] A constant for the complete MediaEvent.
        public static const SELECT:String = "select"; // [static] A constant for the select MediaEvent.

        public var _data: MediaPromise; // [read-only] The MediaPromise object for the available media file.

        public function MediaEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:MediaPromise = null)
        {
            super(type,bubbles,cancelable);
            this._data = data;
        }
        

        // [override] Creates a copy of an MediaEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new MediaEvent(this.type, this.bubbles, this.cancelable, this.data);
        }

        // [override] Returns a string that contains all the properties of MediaEvent object.
        override public function toString():String
        {
            return this.formatToString("MediaEvent","type","bubbles","cancelable","eventPhase","data");
        }

        public function get data() : MediaPromise
        {
            return this._data;
        }
        
    }
}

