// The initial version of this file was autogenerated from the official AS3 reference at
// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/globalization/NumberFormatter.html
// by https://github.com/golfinq/ActionScript_Event_Builder
// It won't be regenerated in the future, so feel free to edit and/or fix

package flash.globalization
{
    
    
    public final class NumberFormatter
    {
        

        // [read-only] The name of the requested locale ID that was passed to the constructor of this NumberFormatter object.
        private var _requestedLocaleIDName: String;
        
        // [read-only] The name of the actual locale ID used by this NumberFormatter object.
        private var _actualLocaleIDName: String;
        
        // The decimal separator character used for formatting or parsing numbers that have a decimal part.
        public var decimalSeparator: String;
        
        // Defines the set of digit characters to be used when formatting numbers.
        public var digitsType: uint;
        
        // The maximum number of digits that can appear after the decimal separator.
        public var fractionalDigits: int;
        
        // Describes the placement of grouping separators within the formatted number string.
        public var groupingPattern: String;
        
        // The character or string used for the grouping separator.
        public var groupingSeparator: String;
        
        // [read-only] The status of previous operation that this NumberFormatter object performed.
        private var _lastOperationStatus: String;
        
        // Specifies whether a leading zero is included in a formatted number when there are no integer digits to the left of the decimal separator.
        public var leadingZero: Boolean;
        
        // A numeric value that indicates a formatting pattern for negative numbers.
        public var negativeNumberFormat: uint;
        
        // The negative symbol to be used when formatting negative values.
        public var negativeSymbol: String;
        
        // Specifies whether trailing zeros are included in a formatted number.
        public var trailingZeros: Boolean;
        
        // Enables the use of the grouping separator when formatting numbers.
        public var useGrouping: Boolean;
        

        
        public function NumberFormatter(requestedLocaleIDName:String)
        {
            super();
            this._requestedLocaleIDName = requestedLocaleIDName;
        }
        
        
        

        // Formats an int value.
        public function formatInt(value:int):String
        {
            // Unknown Implementation
        }

        // Formats a Number value.
        public function formatNumber(value:Number):String
        {
            // Unknown Implementation
        }

        // Formats a uint value.
        public function formatUint(value:uint):String
        {
            // Unknown Implementation
        }

        // [static] Lists all of the locale ID names supported by this class.
        public static function getAvailableLocaleIDNames():Vector.<String>
        {
            // Unknown Implementation
        }

        // Parses a string and returns a NumberParseResult object containing the parsed elements.
        public function parse(parseString:String):NumberParseResult
        {
            // Unknown Implementation
        }

        // Parses a string that contains only digits and optional whitespace characters and returns a Number.
        public function parseNumber(parseString:String):Number
        {
            // Unknown Implementation
        }

        public function get requestedLocaleIDName() : String
        {
            return this._requestedLocaleIDName;
        }
        

        public function get actualLocaleIDName() : String
        {
            return this._actualLocaleIDName;
        }
        

        public function get lastOperationStatus() : String
        {
            return this._lastOperationStatus;
        }
        
    }
}