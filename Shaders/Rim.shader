Shader "Dave/Rim"{
	Properties	{
		_RimColor("Example Color",Color) =  (0,0.5,0.5,0)
		_RimPower("Rim Power",range(0.5,8)) = 3
	}

	SubShader{
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input{
		float3 viewDir;
		};

		fixed4 _RimColor;
		float _RimPower;
		

		void surf(Input IN, inout SurfaceOutput o)
		{
			half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb*pow(rim, _RimPower);
		}
		ENDCG

	}
	FallBack "Diffuse"
}