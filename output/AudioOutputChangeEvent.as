package flash.events
{
    
    public class AudioOutputChangeEvent extends Event
    {
        public static const AUDIO_OUTPUT_CHANGE:String = "audioOutputChange"; // [static] Defines the value of the type property of a AudioOutputchangeEvent event object.

        private var _reason: String; // [read-only] Reports the reason that triggers this AudioOutputchangeEvent.

        public function AudioOutputChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, reason:String = null)
        {
            super(type,bubbles,cancelable);
            this._reason = reason;
        }
        

        public function get reason() : String
        {
            return this._reason;
        }
        
    }
}