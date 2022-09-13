package flash.events
{
    
    public class DRMReturnVoucherCompleteEvent extends Event
    {
        public static const RETURN_VOUCHER_COMPLETE:String = "returnVoucherComplete"; // [static] The string constant to use for the return voucher complete event in the type parameter when adding and removing event listeners.

        public var serverURL: String; // The URL of the media rights server.
        public var licenseID: String; // The license ID that was passed into the DRMManager.returnVoucher() call.
        public var policyID: String; // The policyID that was passed into the DRMManager.returnVoucher() call.
        public var numberOfVouchersReturned: int; // The number of vouchers that matches the criterion passed into DRMManager.returnVoucher() and subsequently returned.

        public function DRMReturnVoucherCompleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inServerURL:String = null, inLicenseID:String = null, inPolicyID:String = null, inNumberOfVouchersReturned:int = 0)
        {
            super(type,bubbles,cancelable);
            this.serverURL = inServerURL;
            this.licenseID = inLicenseID;
            this.policyID = inPolicyID;
            this.numberOfVouchersReturned = inNumberOfVouchersReturned;
        }
        

        // [override] Duplicates an instance of an Event subclass.
        override public function clone():Event
        {
            return new DRMReturnVoucherCompleteEvent(this.type,this.bubbles,this.cancelable,this.serverURL,this.licenseID,this.policyID,this.numberOfVouchersReturned);
        }
    }
}