Shader "Dave/alb_emi_tex"
{
	Properties
	{
		
		_myTex("Example Texture",2D) = "white" {}
		_myEmiss("Example Emiss Texture",2D) = "white" {}
		_myEmissRange("Emiss Range", Range(0,5)) = 1
		
	}

	SubShader
		{

			CGPROGRAM
			#pragma surface surf Lambert
			
			
			sampler2D _myTex;
			sampler2D _myEmiss;
			half _myEmissRange;
			

			struct Input
				{
				float2 uv_myTex;
				float3 worldRelf;
				};

		
		

		void surf(Input IN, inout SurfaceOutput o)
		{
			//get uv value and put textures on it 
			o.Albedo = (tex2D(_myTex, IN.uv_myTex)).rgb;			
			o.Emission = (tex2D(_myEmiss, IN.uv_myTex)*_myEmissRange).rgb;;
		}
		ENDCG

	}
	FallBack "Diffuse"
}