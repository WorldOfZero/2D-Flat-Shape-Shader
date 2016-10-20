Shader "Flat/Absolute Circle" {
	Properties{
		_ForegroundColor("Foreground Color", Color) = (1,1,1,1)
		_BackgroundColor("Background Color", Color) = (0,0,0,1)
		_ForegroundMask("Foreground Mask", 2D) = "white" {}
		_ForegroundCutoff("Foreground Cutoff", Range(0,1)) = 0.5
		_BackgroundCutoff("Background Cutoff", Range(0,1)) = 0.5
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

		sampler2D _ForegroundMask;

	struct Input {
		float2 uv_ForegroundMask;
	};

	fixed4 _ForegroundColor;
	fixed4 _BackgroundColor;
	half _ForegroundCutoff;
	half _BackgroundCutoff;

	void surf(Input IN, inout SurfaceOutputStandard o) {

		fixed x = (-0.5 + IN.uv_ForegroundMask.x) * 2;
		fixed y = (-0.5 + IN.uv_ForegroundMask.y) * 2;

		// Albedo comes from a texture tinted by color
		fixed radius = 1 - sqrt(x*x + y*y);
		clip(radius - _BackgroundCutoff);
		o.Albedo = _BackgroundColor;
		if (radius > _ForegroundCutoff) {
			o.Albedo = _ForegroundColor;
		}
		o.Alpha = 1;
	}
	ENDCG
	}
	FallBack "Diffuse"
}