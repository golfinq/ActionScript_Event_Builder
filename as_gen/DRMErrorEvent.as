package flash.events
{
    
    import flash.net.drm.DRMContentData;
    
    public class DRMErrorEvent extends ErrorEvent
    {
        public static const DRM_ERROR:String = "drmError"; // [static] The DRMErrorEvent.DRM_ERROR constant defines the value of the type property of a drmError event object.
        public static const DRM_LOAD_DEVICEID_ERROR:String = "drmLoadDeviceIdError"; // [static]

        public var _subErrorID: int; // [read-only] An error ID that indicates more detailed information about the underlying problem.
        public var _systemUpdateNeeded: Boolean; // [read-only] Indicates whether a system update is needed to play the DRM-protected content.
        public var _drmUpdateNeeded: Boolean; // [read-only] Indicates whether a DRM update is needed to play the DRM-protected content.
        public var contentData: DRMContentData; // The DRMContentData for the media file.

        public function DRMErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inErrorDetail:String = "", inErrorCode:int = 0, insubErrorID:int = 0, inMetadata:DRMContentData = null, inSystemUpdateNeeded:Boolean = false, inDrmUpdateNeeded:Boolean = false)
        {
            super(type,bubbles,cancelable,inErrorDetail,inErrorCode);
            this._subErrorID = insubErrorID;
            this.contentData = inMetadata;
            this._systemUpdateNeeded = inSystemUpdateNeeded;
            this._drmUpdateNeeded = inDrmUpdateNeeded;
        }
        

        // [override] Creates a copy of the DRMErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DRMErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.errorID, this.subErrorID, this.contentData, this.systemUpdateNeeded, this.drmUpdateNeeded);
        }

        // [override] Returns a string that contains all the properties of the DRMErrorEvent object.
        override public function toString():String
        {
            return this.formatToString("DRMErrorEvent","type","bubbles","cancelable","eventPhase","errorID","subErrorID","text");
        }

        public function get subErrorID() : int
        {
            return this._subErrorID;
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

