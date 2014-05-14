package;

import lime.gl.GL;
import lime.Lime;


class Main {
 private var lime:Lime;
 public function new () {}
 public function ready (lime:Lime):Void {
   this.lime = lime;
 }
 
 
 private function render ():Void {
   GL.viewport (0, 0, lime.config.width, lime.config.height);
   GL.clearColor (0.0, 0.0, 0.0, 1.0);
   GL.clear (GL.COLOR_BUFFER_BIT);
 }
}