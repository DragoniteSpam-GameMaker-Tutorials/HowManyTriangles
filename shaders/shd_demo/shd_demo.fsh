varying vec4 v_vColour;
varying vec3 v_vWorldNormal;
varying vec2 v_vTexcoord;

#define MAX_LIGHTS_DIRECTION 2

uniform vec3 u_DirectionalLights[MAX_LIGHTS_DIRECTION];
uniform vec3 u_DirectionalLightColors[MAX_LIGHTS_DIRECTION];

uniform vec3 u_LightAmbient;

void main() {
    vec3 lightValue = vec3(u_LightAmbient);
    
    for (int i = 0; i < MAX_LIGHTS_DIRECTION; i++) {
        float NdotL = dot(-v_vWorldNormal, u_DirectionalLights[i]);
        NdotL = max(0.0, NdotL);
        lightValue += NdotL * u_DirectionalLightColors[i];
    }
    
    lightValue = min(vec3(1), lightValue);
    
    vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    color.rgb *= lightValue;
    
    gl_FragColor = color;
}