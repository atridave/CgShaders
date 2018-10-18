Shader "Dave/Hologram"{
	Properties	{
		_color("Color",Color) =  (0,0.5,0.5,0)
		_MainTex("MainTex",2D) = "White" {}
		_RimPower("Rim Power",range(0.3,3)) = .75
		_HologramMap("HologramMap",2D) = "White" {}
		_HologramTilling("Hologram Tilling",Float) = 1
		_HologramOffset("Hologram Offset",Float) = 0
		[Toggle] _Dissolve ("Dissolve", Float) = 0
		_DissolveColor("Dissolve Color",Color) = (1,1,1,0)
		_DissolveTexture("Dissolve Texture",2D) = "White" {}
	}

	SubShader{
		Tags{"Queue" =  "Transparent"}

		Pass {
			ZWrite On
			ColorMask 0
		}
		
		CGPROGRAM
		#pragma surface surf Lambert alpha:fade

		struct Input{
		float3 viewDir;
		};

		fixed4 _color;
		float _RimPower;
		sampler2D _MainTex;
		sampler2D _HologramMap;
		float _ShowDecal;
		

		void surf(Input IN, inout SurfaceOutput o)
		{
			half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _color.rgb*pow(rim, _RimPower);
			o.Alpha = pow(rim, _RimPower);
		}
		ENDCG

	}
	FallBack "Diffuse"
}