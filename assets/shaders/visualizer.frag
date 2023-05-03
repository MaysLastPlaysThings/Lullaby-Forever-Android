precision mediump float;

uniform sampler2D song;
varying vec2 vTextureCoord;

void main() {
    // Define some options
    const float stepCount = 128.0;
    float barWidth = gl_MaxViewportWidth / stepCount;

    // Set background color
    vec3 color = vec3(0.1, 0.1, 0.1);
    float isInsideBar = step(texture2D(song, vec2(floor(gl_FragCoord.x / barWidth)/stepCount,0.25) ).x, 0.0));
    color = vec3(1.0) * isInsideBar;
    color *= vec3((1.0/stepCount) * floor(gl_FragCoord.x / barWidth),1.0-(1.0/stepCount)*floor(gl_FragCoord.x / barWidth),0.5);
    color = color * 0.90 + 0.1;

    // Set the final fragment color
    gl_FragColor = vec4(color, 1.0);
}
