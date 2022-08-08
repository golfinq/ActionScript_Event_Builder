package flash.events
{
    
    public class SQLEvent extends Event
    {
        public static const DEANALYZE:String = "deanalyze"; // [static] The SQLEvent.ANALYZE constant defines the value of the type property of an analyze event object.
        public static const ATTACH:String = "attach"; // [static] The SQLEvent.ATTACH constant defines the value of the type property of an attach event object.
        public static const BEGIN:String = "begin"; // [static] The SQLEvent.BEGIN constant defines the value of the type property of a begin event object.
        public static const CANCEL:String = "cancel"; // [static] The SQLEvent.CANCEL constant defines the value of the type property of a cancel event object.
        public static const CLOSE:String = "close"; // [static] The SQLEvent.CLOSE constant defines the value of the type property of a close event object.
        public static const COMMIT:String = "commit"; // [static] The SQLEvent.COMMIT constant defines the value of the type property of a commit event object.
        public static const COMPACT:String = "compact"; // [static] The SQLEvent.COMPACT constant defines the value of the type property of a compact event object.
        public static const DEANALYZE:String = "deanalyze"; // [static] The SQLEvent.DEANALYZE constant defines the value of the type property of a deanalyze event object.
        public static const DETACH:String = "detach"; // [static] The SQLEvent.DETACH constant defines the value of the type property of a detach event object.
        public static const OPEN:String = "open"; // [static] The SQLEvent.OPEN constant defines the value of the type property of a open event object.
        public static const REENCRYPT:String = "reencrypt"; // [static] The SQLEvent.REENCRYPT constant defines the value of the type property of a reencrypt event object.
        public static const RELEASE_SAVEPOINT:String = "releaseSavepoint"; // [static] The SQLEvent.RELEASE_SAVEPOINT constant defines the value of the type property of a releaseSavepoint event object.
        public static const RESULT:String = "result"; // [static] The SQLEvent.RESULT constant defines the value of the type property of a result event object.
        public static const ROLLBACK_TO_SAVEPOINT:String = "rollbackToSavepoint"; // [static] The SQLEvent.ROLLBACK constant defines the value of the type property of a rollback event object.
        public static const ROLLBACK_TO_SAVEPOINT:String = "rollbackToSavepoint"; // [static] The SQLEvent.ROLLBACK_TO_SAVEPOINT constant defines the value of the type property of a rollbackToSavepoint event object.
        public static const SCHEMA:String = "schema"; // [static] The SQLEvent.SCHEMA constant defines the value of the type property of a schema event object.
        public static const SET_SAVEPOINT:String = "setSavepoint"; // [static] The SQLEvent.SET_SAVEPOINT constant defines the value of the type property of a setSavepoint event object.

        

        public function SQLEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type,bubbles,cancelable);
            
        }
        

        // [override] Creates a copy of the SQLEvent object and sets the value of each property to match that of the original.
        override public function clone():Event
        {
            return new SQLEvent(this.type, this.bubbles, this.cancelable);
        }
    }
}

