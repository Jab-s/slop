shader_type canvas_item;

uniform sampler2D noise_img;
uniform sampler2D gradient_tex;
uniform float speed = 1.0;
uniform vec4 smoke_color : source_color;

void fragment(){
	vec2 uv1 = vec2(UV.x + TIME*speed, UV.y + TIME*speed);
	vec2 uv2 = vec2(UV.x - TIME*speed, UV.y + TIME*speed);
	vec2 uv3 = vec2(UV.x, UV.y + TIME*speed);
	
	float gradient = texture( gradient_tex, vec2(UV.y, UV.x) ).r;
	float noise_r = texture( noise_img, uv1 ).r;
	float noise_g = texture( noise_img, uv1 ).g;
	float noise_b = texture( noise_img, uv1 ).b;
	
	vec3 new_color = vec3(noise_r, noise_g, noise_b);
	
	float new_alpha = noise_r * noise_g * noise_b;
	
	COLOR.rgb = smoke_color.rgb;
	COLOR.a = clamp (new_alpha * 5.0 * gradient + gradient*0.5, 0.0, 1.0);
}