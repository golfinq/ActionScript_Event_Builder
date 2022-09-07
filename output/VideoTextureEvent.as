package flash.events
{
    
    public class VideoTextureEvent extends Event
    {
        public static const RENDER_STATE:String = "renderState"; // [static] The VideoTextureEvent.RENDER_STATE constant defines the value of the type property of a renderState event object.

        private var _status: String; // [read-only] The status of the VideoTexture object.
        private var _colorSpace: String; // [read-only] The color space used by the video being displayed in the VideoTexture object.

        public function VideoTextureEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:String = null, colorSpace:String = null)
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