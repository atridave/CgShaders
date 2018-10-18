Shader "Dave/albedoFullGreen"{
	Properties	{
		_myColour("Example Color",Color) =  (1,1,1,1)
		
	}

	SubShader{
		CGPROGRAM
		#pragma surface surf Lambert

		fixed4 _myColour;

		struct Input{
		float2 uvMainTex;
		};

		
		

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _myColour.rgb;
			o.Albedo.g = 1;
			
		}
		ENDCG

	}
	FallBack "Diffuse"
}