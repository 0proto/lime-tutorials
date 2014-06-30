package;

import lime.gl.GL;
import lime.Lime;
import lime.utils.Assets;
import lime.utils.Float32Array;

class Main {

    private var lime: Lime;
    var vertexShaderText = Assets.getText("assets/shaders/vert.glsl");
    var fragmentShaderText = Assets.getText("assets/shaders/frag.glsl");

    public function new() {}
    var vertices = [
		1, 1, 0,
    	800, 1, 0,
    	1,  600, 0,
    	0.1, 1, 0,
    	0, 0, 1,
    	1, 0, 0.1
    ];

    public function ready(lime: Lime): Void {
        this.lime = lime;
    }

    private function getVertexShader() {
        var vertexShader = GL.createShader(GL.VERTEX_SHADER);
        GL.shaderSource(vertexShader, vertexShaderText);
        GL.compileShader(vertexShader);
        if (GL.getShaderParameter(vertexShader, GL.COMPILE_STATUS) == 0) {
        	throw "Error compiling vertex shader: " + GL.getShaderInfoLog(vertexShader);
        }
        return vertexShader;
    }

    private function getFragmentShader() {
        var fragmentShader = GL.createShader(GL.FRAGMENT_SHADER);
        GL.shaderSource(fragmentShader, fragmentShaderText);
        GL.compileShader(fragmentShader);
        if (GL.getShaderParameter(fragmentShader, GL.COMPILE_STATUS) == 0) {
            throw "Error compiling fragment shader: " + GL.getShaderInfoLog(fragmentShader);
        }
        return fragmentShader;
    }

    private function render(): Void {
        GL.viewport(0, 0, lime.config.width, lime.config.height);
        GL.clearColor(0.0, 0.0, 0.0, 1.0);
        GL.clear(GL.COLOR_BUFFER_BIT);

        var program = GL.createProgram();
        GL.attachShader(program,getVertexShader());
        GL.attachShader(program,getFragmentShader());
        GL.linkProgram(program);
        GL.useProgram(program);

        var positionLocation = GL.getAttribLocation(program,"a_position");
        var colorLocation = GL.getAttribLocation(program,"a_color");

        var resolutionLocation = GL.getUniformLocation(program,"u_resolution");

        GL.uniform2f(resolutionLocation,lime.config.width,lime.config.height);

        var buffer = GL.createBuffer();
        GL.bindBuffer(GL.ARRAY_BUFFER,buffer);

        GL.bufferData(GL.ARRAY_BUFFER,new Float32Array(vertices),GL.STATIC_DRAW);
        GL.enableVertexAttribArray(positionLocation);
        GL.vertexAttribPointer(positionLocation,3,GL.FLOAT,false,0,0);

        GL.enableVertexAttribArray(colorLocation);
        GL.vertexAttribPointer(colorLocation,3,GL.FLOAT,false,0,36);

        GL.drawArrays(GL.TRIANGLES,0,3);

        GL.disableVertexAttribArray(colorLocation);
        GL.disableVertexAttribArray(positionLocation);
        GL.useProgram(null);
    }
}