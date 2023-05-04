#pragma header

void main() {
	//Values
	const float stepCount = 128.0;
	// Define some options
	float barWidth = openfl_TextureSize.x / stepCount;
	
	// Set background color
	vec3 color = vec3(0.1, 0.1, 0.1);
	float isInsideBar = step(texture2D(bitmap, vec2(floor(openfl_TextureSize.x / barWidth) / stepCount, 0.25) ).x, 0.5);
	color = vec3(1.0) * isInsideBar;
	color *= vec3((1.0 / stepCount) * floor(openfl_TextureSize.x / barWidth), 1.0 - (1.0 / stepCount) * floor(openfl_TextureSize.x / barWidth), 0.5);
	color = color * 0.90 + 0.1;
	
	// Set the final fragment color
	gl_FragColor = vec4(color, 1.0);
}
