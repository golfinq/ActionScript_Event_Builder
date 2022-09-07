package flash.events
{
    
    import flash.net.drm.DRMDeviceGroup;
    
    public class DRMDeviceGroupErrorEvent extends ErrorEvent
    {
        public static const ADD_TO_DEVICE_GROUP_ERROR:String = "addToDeviceGroupError"; // [static]
        public static const REMOVE_FROM_DEVICE_GROUP_ERROR:String = "removeFromDeviceGroupError"; // [static]

        public var subErrorID: int; // 
        public var deviceGroup: DRMDeviceGroup; // The DRMDeviceGroup object for this error event.
        private var _systemUpdateNeeded: Boolean; // [read-only]
        private var _drmUpdateNeeded: Boolean; // [read-only]

        public function DRMDeviceGroupErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, errorDetail:String = "", errorCode:int = 0, subErrorID:int = 0, deviceGroup:DRMDeviceGroup = null, systemUpdateNeeded:Boolean = false, drmUpdateNeeded:Boolean = false)
        {
            super(type,bubbles,cancelable,errorDetail,errorCode);
            this.subErrorID = subErrorID;
            this.deviceGroup = deviceGroup;
            this._systemUpdateNeeded = systemUpdateNeeded;
            this._drmUpdateNeeded = drmUpdateNeeded;
        }
        

        // [override]
        override public function clone():Event
        {
            return new DRMDeviceGroupErrorEvent(this.type,this.bubbles,this.cancelable,this.eventPhase,this.text,this.errorID,this.subErrorID,this.deviceGroup,this.systemUpdateNeeded,this.drmUpdateNeeded);
        }

        // [override]
        override public function toString():String
        {
            return this.formatToString("DRMDeviceGroupErrorEvent","type","bubbles","cancelable","eventPhase","text","subErrorID","deviceGroup","systemUpdateNeeded","drmUpdateNeeded");
        }

        public function get systemUpdateNeeded() : Boolean
        {
            return this._systemUpdateNeeded;
        }
        

        public function get drmUpdateNeeded() : Boolean
        {
            return this._drmUpdateNeeded;
        }
        
    }
}