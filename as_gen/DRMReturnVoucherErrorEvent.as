package flash.events
{
    
    public class DRMReturnVoucherErrorEvent extends ErrorEvent
    {
        public static const RETURN_VOUCHER_ERROR:String = "returnVoucherError"; // [static] The string constant to use for the return voucher error event in the type parameter when adding and removing event listeners.

        public var subErrorID: int; // A more detailed error code.
        public var serverURL: String; // The URL of the media rights server for this return Voucher attempt.
        public var licenseID: String; // The license ID that was passed into the returnVoucher() call that resulted in this error.
        public var policyID: String; // The policy ID that was passed into the returnVoucher() call that resulted in this error.

        public function DRMReturnVoucherErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inDetail:String = "", inErrorID:int = 0, inSubErrorID:int = 0, inServerURL:String = null, inLicenseID:String = null, inPolicyID:String = null)
        {
            super(type,bubbles,cancelable,inDetail,inErrorID);
            this.subErrorID = inSubErrorID;
            this.serverURL = inServerURL;
            this.licenseID = inLicenseID;
            this.policyID = inPolicyID;
        }
        

        // [override] Creates a copy of the ErrorEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new DRMReturnVoucherErrorEvent(this.type, this.bubbles, this.cancelable, this.text, this.errorID, this.subErrorID, this.serverURL, this.licenseID, this.policyID);
        }
    }
}

