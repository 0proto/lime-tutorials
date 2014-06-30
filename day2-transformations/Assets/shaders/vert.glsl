attribute vec2 a_position;
attribute vec3 a_color;

uniform vec2 u_resolution;

varying vec3 u_color;

void main() {
	vec2 zeroToOne = a_position/u_resolution;
	vec2 zeroToTwo = zeroToOne * 2.0;
	vec2 clipSpace = zeroToTwo - 1.0;

	gl_Position = vec4(clipSpace * vec2(1,-1),0,1);
	u_color = a_color;
}