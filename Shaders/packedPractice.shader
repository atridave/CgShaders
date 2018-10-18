Shader "Dave/PackedParctice"{
	Properties	{
		_myColour("Example Color",Color) =  (1,1,1,1)
		
	}

	SubShader{
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input{
		float2 uvMainTex;
		};

		fixed4 _myColour;
		
		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo.r= _myColour.r;
		}
		ENDCG

	}
	FallBack "Diffuse"
}