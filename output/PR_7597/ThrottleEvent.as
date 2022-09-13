package flash.events
{
    
    public class ThrottleEvent extends Event
    {
        public static const THROTTLE:String = "throttle"; // [static] Defines the value of the type property of a ThrottleEvent event object.

        private var _state: String; // [read-only] Describes the state that the player is entering: ThrottleType.THROTTLE, ThrottleType.PAUSE, or ThrottleType.RESUME.
        private var _targetFrameRate: Number; // [read-only] The frame rate that Flash Player or AIR targets after the ThrottleEvent is dispatched.

        public function ThrottleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, state:String = null, targetFrameRate:Number = 0)
        {
            super(type,bubbles,cancelable);
            this._state = state;
            this._targetFrameRate = targetFrameRate;
        }
        

        // [override] Creates a copy of the ThrottleEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new ThrottleEvent(this.type,this.bubbles,this.cancelable,this.state,this.targetFrameRate);
        }

        // [override] Returns a string that contains all the properties of the ThrottleEvent object.
        override public function toString():String
        {
            return this.formatToString("ThrottleEvent","type","bubbles","cancelable","eventPhase",state,targetFrameRate);
        }

        public function get state() : String
        {
            return this._state;
        }
        

        public function get targetFrameRate() : Number
        {
            return this._targetFrameRate;
        }
        
    }
}