package flash.events
{
    
    import flash.net.drm.DRMDeviceGroup;
    
    public class DRMDeviceGroupEvent extends Event
    {
        public static const ADD_TO_DEVICE_GROUP_COMPLETE:String = "addToDeviceGroupComplete"; // [static]
        public static const REMOVE_FROM_DEVICE_GROUP_COMPLETE:String = "removeFromDeviceGroupComplete"; // [static]

        public var deviceGroup: DRMDeviceGroup; // The DRMDeviceGroup object for this event.

        public function DRMDeviceGroupEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, deviceGroup:DRMDeviceGroup = null)
        {
            super(type,bubbles,cancelable);
            this.deviceGroup = deviceGroup;
        }
        

        // [override]
        override public function clone():Event
        {
            return new DRMDeviceGroupEvent(this.type, this.bubbles, this.cancelable, this.deviceGroup);
        }

        // [override]
        override public function toString():String
        {
            return this.formatToString("DRMDeviceGroupEvent","type","bubbles","cancelable","eventPhase","deviceGroup");
        }
    }
}

