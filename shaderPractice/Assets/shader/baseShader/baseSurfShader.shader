Shader "Custom/baseSurfShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_ScrollXSpeed("ScrollXSpeed", Range(0,10)) = 2
		_ScrollYSpeed("ScrollYSpeed", Range(0,10)) = 2
	}
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		
		//#pragma surface surf Lambert	//unity 4.x 非物理光照，低端设备上渲染更快
		#pragma surface surf Standard
		#pragma enable_d3d11_debug_symbols

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// 移动UV纹理
			fixed2 scrolledUV = IN.uv_MainTex;
			fixed scrolledX = _ScrollXSpeed * _Time;
			fixed scrolledY = _ScrollYSpeed * _Time;
			scrolledUV += fixed2(scrolledX, scrolledY);

			// tex2D提取纹理颜色
			fixed4 c = tex2D (_MainTex, scrolledUV) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
