Shader "Dave/Cutoff"{
	Properties	{
		_RimColor("Example Color",Color) =  (0,0.5,0.5,0)
		_RimPower("Rim Power",range(0.5,8)) = 3
	}

	SubShader{
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input{
		float3 viewDir;
		float3 worldPos;
		};

		fixed4 _RimColor;
		float _RimPower;
		

		void surf(Input IN, inout SurfaceOutput o)
		{
			half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.4 ? float3(0, 1, 0) : float3(1, 0, 0);
		}
		ENDCG

	}
	FallBack "Diffuse"
}