package flash.events
{
    
    import flash.net.drm.DRMContentData;
    import flash.utils.ByteArray;
    
    public class DRMMetadataEvent extends Event
    {
        public static const DRM_METADATA:String = "drmMetadata"; // [static] The DRMMetadataEvent.DRM_METADATA constant defines the value of the type property of a DRMMetadataEvent event object.

        private var _timestamp: Number; // [read-only] The timestamp associated with the metadata
        private var _drmMetadata: DRMContentData; // [read-only] The raw metadata bytes

        public function DRMMetadataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inMetadata:ByteArray = null, inTimestamp:Number = 0)
        {
            super(type,bubbles,cancelable,inMetadata);
            this._timestamp = inTimestamp;
        }
        

        public function get timestamp() : Number
        {
            return this._timestamp;
        }
        

        public function get drmMetadata() : DRMContentData
        {
            return this._drmMetadata;
        }
        
    }
}