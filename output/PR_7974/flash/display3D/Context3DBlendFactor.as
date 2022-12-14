// The initial version of this file was autogenerated from the official AS3 reference at
// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display3D/Context3DBlendFactor.html
// by https://github.com/golfinq/ActionScript_Event_Builder
// It won't be regenerated in the future, so feel free to edit and/or fix

package flash.display3D
{
    
    
    public final class Context3DBlendFactor
    {
        // The blend factor is (Da,Da,Da,Da), where Da is the alpha component of the fragment color computed by the pixel program.
        public static const DESTINATION_ALPHA:String = "destinationAlpha";
        
        // The blend factor is (Dr,Dg,Db,Da), where Dr/g/b/a is the corresponding component of the current color in the color buffer.
        public static const DESTINATION_COLOR:String = "destinationColor";
        
        // The blend factor is (1,1,1,1).
        public static const ONE:String = "one";
        
        // The blend factor is (1-Da,1-Da,1-Da,1-Da), where Da is the alpha component of the current color in the color buffer.
        public static const ONE_MINUS_DESTINATION_ALPHA:String = "oneMinusDestinationAlpha";
        
        // The blend factor is (1-Dr,1-Dg,1-Db,1-Da), where Dr/g/b/a is the corresponding component of the current color in the color buffer.
        public static const ONE_MINUS_DESTINATION_COLOR:String = "oneMinusDestinationColor";
        
        // The blend factor is (1-Sa,1-Sa,1-Sa,1-Sa), where Sa is the alpha component of the fragment color computed by the pixel program.
        public static const ONE_MINUS_SOURCE_ALPHA:String = "oneMinusSourceAlpha";
        
        // The blend factor is (1-Sr,1-Sg,1-Sb,1-Sa), where Sr/g/b/a is the corresponding component of the fragment color computed by the pixel program.
        public static const ONE_MINUS_SOURCE_COLOR:String = "oneMinusSourceColor";
        
        // The blend factor is (Sa,Sa,Sa,Sa), where Sa is the alpha component of the fragment color computed by the pixel program.
        public static const SOURCE_ALPHA:String = "sourceAlpha";
        
        // The blend factor is (Sr,Sg,Sb,Sa), where Sr/g/b/a is the corresponding component of the fragment color computed by the pixel program.
        public static const SOURCE_COLOR:String = "sourceColor";
        
        // The blend factor is (0,0,0,0).
        public static const ZERO:String = "zero";
        
        
    }
}
