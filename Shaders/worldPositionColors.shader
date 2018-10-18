Shader "Dave/worldPostionColors"{
	Properties	{
		_upperColor("Upper Color",Color) =  (1,0,0,0)
		_bottomColor("Bottom Color",Color) = (0,1,0,0)
	}

	SubShader{
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input{
		float3 viewDir;
		float3 worldPos;
		};

		fixed4 _upperColor;
		fixed4 _bottomColor;		

		void surf(Input IN, inout SurfaceOutput o)
		{
			half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission =  IN.worldPos.y > 1 ? float3(_upperColor.r, _upperColor.g, _upperColor.b): float3(_bottomColor.r, _bottomColor.g, _bottomColor.b);
		}
		ENDCG

	}
	FallBack "Diffuse"
}