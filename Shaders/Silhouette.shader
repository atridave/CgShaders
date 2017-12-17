﻿Shader "Dave/Silhouette" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_DotProduct("Rim effect",Range(-1,1)) = 0.25

	}
	SubShader {
		Tags {
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		  }
		LOD 200

		cull off 
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert alpha:fade nolighting



		sampler2D _MainTex;
		fixed4 _Color;
		float _DotProduct;

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
		};




		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;

			float border =  1-(abs(dot(IN.viewDir,IN.worldNormal)));
			float alpha =  (border * (1-_DotProduct)+_DotProduct);
			o.Alpha = c.a*alpha;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
