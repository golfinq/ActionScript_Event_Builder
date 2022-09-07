package flash.events
{
    
    public class AVPauseAtPeriodEndEvent extends Event
    {
        public static const AV_PAUSE_AT_PERIOD_END:String = "avPauseAtPeriodEnd"; // [static]

        private var _userData: int; // [read-only]

        public function AVPauseAtPeriodEndEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, userData:int = 0)
        {
            super(type,bubbles,cancelable);
            this._userData = userData;
        }
        

        public function get userData() : int
        {
            return this._userData;
        }
        
    }
}