shader_type canvas_item;

vec2 unity_voronoi_noise_randomVector (vec2 _UV, float offset)
{
    mat2 m = mat2(vec2(15.27, 47.63), vec2(99.41, 89.98));
    _UV = fract(sin(_UV * m) * 46839.32);
    return vec2(sin(_UV.y*+offset)*0.5+0.5, cos(_UV.x*offset)*0.5+0.5);
}

void Unity_Voronoi_float(vec2 _UV, float AngleOffset, float CellDensity, out float Out, out float Cells)
{
    vec2 g = floor(_UV * CellDensity);
    vec2 f = fract(_UV * CellDensity);
    float t = 8.0;
    vec3 res = vec3(8.0, 0.0, 0.0);

    for(float y=-1.0; y<=1.0; y++)
    {
        for(float x=-1.0; x<=1.0; x++)
        {
            vec2 lattice = vec2(x,y);
            vec2 offset = unity_voronoi_noise_randomVector(lattice + g, AngleOffset);
            float d = distance(lattice + offset, f);
            if(d < res.x)
            {
                res = vec3(d, offset.x, offset.y);
                Out = res.x;
                Cells = res.y;
            }
        }
    }
}

void Unity_RadialShear_float(vec2 _UV, vec2 Center, float Strength, vec2 Offset, out vec2 Out)
{
    vec2 delta = _UV - Center;
    float delta2 = dot(delta.xy, delta.xy);
    float delta_offset = delta2 * Strength; // should be vec2/float 2 check
    Out = _UV + vec2(delta.y, -delta.x) * delta_offset + Offset;
}

vec2 pixelUV(vec2 uv, float PixelateAmount) {
    return floor(uv * PixelateAmount) / PixelateAmount;
}
void fragment()
{
    // Normalized pixel coordinates (from 0 to 1)
    //vec2 uv = fragCoord/iResolution.xy;
    vec2 uv = pixelUV(UV, 64.0);
    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(TIME+uv.xyx+vec3(0,2,4));

    // Output to screen
    float v_color;
    float cells;
    Unity_Voronoi_float(uv, TIME, 3.0, v_color, cells);
    COLOR = vec4(0.0,0.0,1.0,1.0) + (vec4(0,0.9,1.0,1)*pow(v_color,2));
}
