Shader "Dave/stripeLine"{
	Properties	{
		_upperColor("Upper Color",Color) = (1,0,0,0)
		_bottomColor("Bottom Color",Color) = (0,1,0,0)
		_StripLineSize("Stripe line size ",range(1,20)) = 10
		_myTex("Pick your Texture",2D) = "white" {}
		_StripIntencity("_StripIntencity",range(0,1)) = 0.5
	}

	SubShader{
		CGPROGRAM
		
		#pragma surface surf Lambert

		sampler2D _myTex;
		fixed4 _RimColor;
		float _RimPower;
		int _StripLineSize;
		half _StripIntencity;
		fixed4 _upperColor;
		fixed4 _bottomColor;

		struct Input{
		float3 viewDir;
		float3 worldPos;
		float2 uv_myTex;
		
		};
		
		void surf(Input IN, inout SurfaceOutput o)
		{
			half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Albedo = (tex2D(_myTex, IN.uv_myTex)).rgb;
			o.Emission = (frac(IN.worldPos.y * _StripLineSize * 0.5) > 0.4 ? float3(_upperColor.r, _upperColor.g, _upperColor.b) : float3(_bottomColor.r, _bottomColor.g, _bottomColor.b))*_StripIntencity;
		}
		ENDCG

	}
	FallBack "Diffuse"
}