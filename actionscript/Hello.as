package {
  import flash.display.*;
  import flash.text.*;

  [SWF(width=240,height=240, backgroundColor=0xFFFFFF)]

  public class Hello extends Sprite {
    public function Hello(){
      var label:TextField = new TextField();
      label.text = "String sample"
      label.x = 10;
      label.y = 10;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.selectable = false;

      var format:TextFormat = new TextFormat();
      format.color = 0xFF0000;
      format.font = "_sans";
      format.size = 24;
      label.setTextFormat(format);
      addChild(label);
    }
  }
}
