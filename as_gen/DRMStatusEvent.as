package flash.events
{
    
    import flash.net.drm.DRMVoucher;
    import flash.net.drm.DRMContentData;
    
    public class DRMStatusEvent extends Event
    {
        public static const DRM_STATUS:String = "drmStatus"; // [static] The DRMStatusEvent.DRM_STATUS constant defines the value of the type property of a drmStatus event object.

        public var voucher: DRMVoucher; // A DRMVoucher object for the content.
        public var contentData: DRMContentData; // A DRMContentData object containing the information necessary to obtain a voucher for viewing the DRM-protected content.
        public var _detail: String; // [read-only] A string explaining the context of the status event.
        public var _isAnonymous: Boolean; // [read-only] Indicates whether the content, protected with digital rights management (DRM) encryption, is available without requiring a user to provide authentication credentials.
        public var _isAvailableOffline: Boolean; // [read-only] Indicates whether the content, protected with digital rights management (DRM) encryption, is available offline.
        public var isLocal: Boolean; // Indicates whether the voucher is cached in the local voucher store.
        public var _offlineLeasePeriod: uint; // [read-only] The remaining number of days that content can be viewed offline.
        public var _policies: Object; // [read-only] A custom object of the DRM status event.
        public var _voucherEndDate: Date; // [read-only] The absolute date on which the voucher expires and the content can no longer be viewed by users.

        public function DRMStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inMetadata:DRMContentData = null, inVoucher:DRMVoucher = null, inLocal:Boolean = false)
        {
            super(type,bubbles,cancelable);
            this.contentData = inMetadata;
            this.voucher = inVoucher;
            this.isLocal = inLocal;
        }
        

        // [override] Creates a copy of the DRMStatusEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DRMStatusEvent(this.type, this.bubbles, this.cancelable, this.voucher);
        }

        // [override] Returns a string that contains all the properties of the DRMStatusEvent object.
        override public function toString():String
        {
            return this.formatToString("DRMStatusEvent","type","bubbles","cancelable","eventPhase","voucher","contentData","detail","isAnonymous","isAvailableOffline","isLocal","offlineLeasePeriod","policies","voucherEndDate");
        }

        public function get detail() : String
        {
            return this._detail; // Unimplemented
        }
        

        public function get isAnonymous() : Boolean
        {
            return this._isAnonymous; // Unimplemented
        }
        

        public function get isAvailableOffline() : Boolean
        {
            return this._isAvailableOffline; // Unimplemented
        }
        

        public function get offlineLeasePeriod() : uint
        {
            return this._offlineLeasePeriod; // Unimplemented
        }
        

        public function get policies() : Object
        {
            return this._policies; // Unimplemented
        }
        

        public function get voucherEndDate() : Date
        {
            return this._voucherEndDate; // Unimplemented
        }
        
    }
}

