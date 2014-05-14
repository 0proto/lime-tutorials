package;

import lime.gl.GL;
import lime.Lime;
import lime.utils.Assets;
import lime.utils.Float32Array;

class Main {
 
 private var lime:Lime;
 public function new () {}
 var vertices = [ 
 0.0, 0.5, 0.0,
 -0.5, -0.5, 0.0,
 0.5, -0.5, 0.0];

public function ready (lime:Lime):Void {
 this.lime = lime;
}

private function getVertexShader() {
 var vertexShader = GL.createShader(GL.VERTEX_SHADER);
 GL.shaderSource(vertexShader,Assets.getText("assets/shaders/vert.glsl"));
 GL.compileShader(vertexShader);
 if (GL.getShaderParameter(vertexShader,GL.COMPILE_STATUS)==0) {
 trace("Error compiling vertex shader: "+GL.getShaderInfoLog(vertexShader));
 }
 return vertexShader;
 }

private function getFragmentShader() {
 var fragmentShader = GL.createShader(GL.FRAGMENT_SHADER);
 GL.shaderSource(fragmentShader,Assets.getText("assets/shaders/frag.glsl"));
 GL.compileShader(fragmentShader);
 if (GL.getShaderParameter(fragmentShader,GL.COMPILE_STATUS)==0) {
 trace("Error compiling fragment shader: "+GL.getShaderInfoLog(fragmentShader));
 }
 return fragmentShader;
 }

private function initialize() {
 var program = GL.createProgram();
 GL.attachShader(program,getVertexShader());
 GL.attachShader(program,getFragmentShader());
 GL.bindAttribLocation(program,0,"vPosition");
 GL.linkProgram(program);
 GL.useProgram(program);
 var buffer = GL.createBuffer();
 GL.bindBuffer(GL.ARRAY_BUFFER,buffer);
}

private function draw() {
 GL.bufferData(GL.ARRAY_BUFFER,new Float32Array(vertices),GL.STATIC_DRAW);
 GL.vertexAttribPointer(0,3,GL.FLOAT,false,0,0);
 GL.enableVertexAttribArray(0);
 GL.drawArrays(GL.TRIANGLES,0,3);
 GL.flush();
 }

private function render ():Void {
 GL.viewport (0, 0, lime.config.width, lime.config.height);
 GL.clearColor (0.0, 0.0, 0.0, 1.0);
 GL.clear (GL.COLOR_BUFFER_BIT);
 initialize();
 draw();
 }
 
 
}