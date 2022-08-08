package flash.events
{
    
    public class StageVideoAvailabilityEvent extends Event
    {
        public const driver:String; // 
        public const reason:String; // 
        public static const STAGE_VIDEO_AVAILABILITY:String = "stageVideoAvailability"; // [static] Defines the value of the type property of a stageVideoAvailability event object.

        public var _availability: String; // [read-only] Reports the current availability of stage video using a constant of the flash.media.StageVideoAvailability class.

        public function StageVideoAvailabilityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, availability:String = null)
        {
            super(type,bubbles,cancelable);
            this._availability = availability;
        }
        

        public function get availability() : String
        {
            return this._availability;
        }
        
    }
}

