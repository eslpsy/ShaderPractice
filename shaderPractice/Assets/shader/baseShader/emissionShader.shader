Shader "Custom/emissionShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Cube("Cube", Cube) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Lambert


		sampler2D _MainTex;
		samplerCUBE _Cube;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;

			o.Emission = texCUBE(_Cube, IN.worldRefl);
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
