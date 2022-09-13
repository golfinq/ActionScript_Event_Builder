package flash.events
{
    
    public class VideoEvent extends Event
    {
        public const codecInfo:String; // 
        public static const RENDER_STATE:String = "renderState"; // [static] Defines the value of the type property of a renderState event object.
        public static const RENDER_STATUS_ACCELERATED:String = "accelerated"; // [static] For internal use only.
        public static const RENDER_STATUS_SOFTWARE:String = "software"; // [static] For internal use only.
        public static const RENDER_STATUS_UNAVAILABLE:String = "unavailable"; // [static] For internal use only.

        private var _status: String; // [read-only] Returns the rendering status of the VideoEvent object.

        public function VideoEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:String = null)
        {
            super(type,bubbles,cancelable);
            this._status = status;
        }
        

        public function get status() : String
        {
            return this._status;
        }
        
    }
}