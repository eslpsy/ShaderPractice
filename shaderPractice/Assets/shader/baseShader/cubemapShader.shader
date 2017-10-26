Shader "Custom/cubemapShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Cubemap("Cube", CUBE) = "" {}
		_ReflAmount("Reflection Amount", Range(0.01, 1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		
		#pragma surface surf Lambert

		sampler2D _MainTex;
		samplerCUBE _Cubemap;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		fixed4 _Color;
		float _ReflAmount;

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Emission = texCUBE(_Cubemap, IN.worldRefl).rgb * _ReflAmount;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
