package flash.events
{
    
    public class StageOrientationEvent extends Event
    {
        public static const ORIENTATION_CHANGE:String = "orientationChange"; // [static] The ORIENTATION_CHANGE constant defines the value of the type property of a orientationChange event object.
        public static const ORIENTATION_CHANGING:String = "orientationChanging"; // [static] The ORIENTATION_CHANGING constant defines the value of the type property of a orientationChanging event object.

        private var _beforeOrientation: String; // [read-only] The orientation of the stage before the change.
        private var _afterOrientation: String; // [read-only] The orientation of the stage after the change.

        public function StageOrientationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, beforeOrientation:String = null, afterOrientation:String = null)
        {
            super(type,bubbles,cancelable);
            this._beforeOrientation = beforeOrientation;
            this._afterOrientation = afterOrientation;
        }
        

        // [override] Creates a copy of the StageOrientationEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new StageOrientationEvent(this.type,this.bubbles,this.cancelable,this.beforeOrientation,this.afterOrientation);
        }

        // [override] Returns a string that contains all the properties of the StageOrientationEvent object.
        override public function toString():String
        {
            return this.formatToString("StageOrientationEvent","type","bubbles","cancelable","eventPhase");
        }

        public function get beforeOrientation() : String
        {
            return this._beforeOrientation;
        }
        

        public function get afterOrientation() : String
        {
            return this._afterOrientation;
        }
        
    }
}