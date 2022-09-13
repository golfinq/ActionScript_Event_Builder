package flash.events
{
    
    import flash.net.drm.DRMVoucher;
    import flash.net.drm.DRMContentData;
    
    public class DRMStatusEvent extends Event
    {
        public static const DRM_STATUS:String = "drmStatus"; // [static] The DRMStatusEvent.DRM_STATUS constant defines the value of the type property of a drmStatus event object.

        public var voucher: DRMVoucher; // A DRMVoucher object for the content.
        public var isLocal: Boolean; // Indicates whether the voucher is cached in the local voucher store.
        public var contentData: DRMContentData; // A DRMContentData object containing the information necessary to obtain a voucher for viewing the DRM-protected content.
        private var _detail: String; // [read-only] A string explaining the context of the status event.
        private var _offlineLeasePeriod: uint; // [read-only] The remaining number of days that content can be viewed offline.
        private var _policies: Object; // [read-only] A custom object of the DRM status event.
        private var _voucherEndDate: Date; // [read-only] The absolute date on which the voucher expires and the content can no longer be viewed by users.

        public function DRMStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inMetadata:DRMContentData = null, inVoucher:DRMVoucher = null, inLocal:Boolean = false)
        {
            super(type,bubbles,cancelable,inMetadata);
            this.voucher = inVoucher;
            this.isLocal = inLocal;
        }
        

        // [override] Creates a copy of the DRMStatusEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DRMStatusEvent(this.type,this.bubbles,this.cancelable,this.voucher,this.isLocal);
        }

        // [override] Returns a string that contains all the properties of the DRMStatusEvent object.
        override public function toString():String
        {
            return this.formatToString("DRMStatusEvent","type","bubbles","cancelable","eventPhase","voucher","isLocal","contentData","detail","offlineLeasePeriod","policies","voucherEndDate");
        }

        public function get detail() : String
        {
            return this._detail;
        }
        

        public function get offlineLeasePeriod() : uint
        {
            return this._offlineLeasePeriod;
        }
        

        public function get policies() : Object
        {
            return this._policies;
        }
        

        public function get voucherEndDate() : Date
        {
            return this._voucherEndDate;
        }
        
    }
}