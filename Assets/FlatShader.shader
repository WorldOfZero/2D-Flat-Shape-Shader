Shader "Custom/FlatShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Mask", 2D) = "white" {}
		_Cutoff ("Cutoff", Range(0,1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		half _Cutoff;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			clip(c.r - _Cutoff);
			o.Albedo = _Color;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
