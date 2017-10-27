Shader "Custom/UVMove" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Cloud("Cloud", 2D) = "white" {}
		_ScrollXSpeed("ScrollXSpeed", Range(0,10)) = 2
		_ScrollYSpeed("ScrollYSpeed", Range(0,10)) = 2
	}
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// 漫反射
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _Cloud;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Cloud;
		};

		fixed4 _Color;
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;

		void surf (Input IN, inout SurfaceOutput o) {
			// 移动地球UV纹理
			fixed2 scrolledUV = IN.uv_MainTex;
			fixed scrolledX = _ScrollXSpeed * _Time;
			scrolledUV += fixed2(scrolledX, 0);

			// tex2D提取纹理颜色
			fixed4 c = tex2D (_MainTex, scrolledUV) * _Color;

			// 移动云层UV纹理 云转动比地球略快一点
			fixed2 scrolledUV_C = IN.uv_Cloud;
			fixed scrolledY = _ScrollYSpeed * _Time;
			scrolledUV_C += fixed2(scrolledY, 0);

			fixed4 texcolorCloud = tex2D(_Cloud, scrolledUV_C);
			fixed4 cloud_color = fixed4(1, 1, 1, 0) * (texcolorCloud.x);
			
			// 混合云层和地球表面层
			fixed4 mixed_color = lerp(c, cloud_color, 0.5f);
			o.Albedo = mixed_color.rgb;
			o.Alpha = mixed_color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
