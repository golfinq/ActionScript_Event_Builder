package flash.events
{
    
    public class StageVideoEvent extends Event
    {
        public const codecInfo:String; // 
        public static const RENDER_STATE:String = "renderState"; // [static] The StageVideoEvent.RENDER_STATE constant defines the value of the type property of a renderState event object.
        public static const RENDER_STATUS_ACCELERATED:String = "accelerated"; // Deprecated since Flash Player 10.2, AIR 3: Please Use flash.media.VideoStatus.ACCELERATED[static] Indicates that hardware is decoding and displaying the video.
        public static const RENDER_STATUS_SOFTWARE:String = "software"; // Deprecated since Flash Player 10.2, AIR 3: Please Use flash.media.VideoStatus.SOFTWARE[static] Indicates that software is decoding and displaying the video.
        public static const RENDER_STATUS_UNAVAILABLE:String = "unavailable"; // Deprecated since Flash Player 10.2, AIR 3: Please Use flash.media.VideoStatus.UNAVAILABLE[static] Indicates that displaying the video using the StageVideo object is not possible.

        public var _status: String; // [read-only] The status of the StageVideo object.
        public var _colorSpace: String; // [read-only] The color space used by the video being displayed in the StageVideo object.

        public function StageVideoEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:String = null, colorSpace:String = null)
        {
            super(type,bubbles,cancelable);
            this._status = status;
            this._colorSpace = colorSpace;
        }
        

        public function get status() : String
        {
            return this._status;
        }
        

        public function get colorSpace() : String
        {
            return this._colorSpace;
        }
        
    }
}

