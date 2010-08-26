package {
  import flash.display.*;
  import flash.events.*;
  import flash.net.*;

  [SWF(width=320,height=240)]

  public class ImageCircle extends Sprite {
    private var l:Loader;
    private var b:BitmapData;

    public function ImageCircle() {
      l = new Loader();
      l.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
      l.load(new URLRequest("http://dl.dropbox.com/u/261861/img/flex.jpg"))
    }

    public function onImageLoad(e:Event):void {
      b = new BitmapData(l.width,l.height);
      b.draw(l);
      var bm:Bitmap = new Bitmap(b);
      addChild(l);
      //addChild(bm);
    }
  }
}
