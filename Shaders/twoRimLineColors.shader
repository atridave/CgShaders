Shader "Dave/twoRimLineColors"{
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
			o.Emission = rim > 0.5 ? float3(1,0,0): rim >0.3 ? float3(0,1,0) : 0;
		}
		ENDCG

	}
	FallBack "Diffuse"
}