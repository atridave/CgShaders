﻿Shader "Dave/packedTextures" {
	Properties {
		_MainTint ("Disffuse Tint", Color) = (1,1,1,1)
		//for all textures

		_ColorA ("Terrain Color A", Color) = (1,1,1,1)
		_ColorB ("Terrain Color B", Color) = (1,1,1,1)

		_RTexture("Red channel Texture", 2D) = ""{}
		_GTexture("Green channel Texture", 2D) = ""{}
		_BTexture("Blue channel Texture", 2D) = ""{}
		_ATexture("Alpha channel Texture", 2D) = ""{}
		_BlendTex("Blend Texture" , 2D) = ""{}
	
	}
	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		#pragma target 3.0

	
		float4 _MainTint;
		float4 _ColorA;
		float4 _ColorB;

		sampler2D _RTexture;
		sampler2D _GTexture;
		sampler2D _BTexture;
		sampler2D _ATexture;
		sampler2D _BlendTex;


		struct Input {
					float2 uv_RTexture;
					float2 uv_GTexture;
					float2 uv_BTexture;
					float2 uv_ATexture;
					float2 uv_BlendTex;

		};




		void surf (Input IN, inout SurfaceOutput o) {

		float4 blendData =  tex2D(_BlendTex,IN.uv_BlendTex);
		float4 rTexData =  tex2D(_RTexture,IN.uv_RTexture);
		float4 gTexData =  tex2D(_GTexture,IN.uv_GTexture);
		float4 bTexData =  tex2D(_BTexture,IN.uv_BTexture);
		float4 aTexData =  tex2D(_ATexture,IN.uv_ATexture);

		float4 finalColor;
		finalColor =  lerp(rTexData,gTexData,blendData.g);
		finalColor =  lerp(finalColor,bTexData,blendData.b);
		finalColor =  lerp(finalColor,aTexData,blendData.a);
		finalColor.a =  1;

		float4 terrainLayers =  lerp(_ColorA,_ColorB,blendData.r);
		finalColor *= terrainLayers;
		finalColor = saturate(finalColor);

		o.Albedo = finalColor.rgb*_MainTint.rgb;
		o.Alpha = finalColor.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
