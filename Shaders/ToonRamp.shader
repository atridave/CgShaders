Shader "Dave/ToonRamp"{
	Properties{
		_Colour("Color",Color) = (1,1,1,1)
		_RampTex("Ramp Texture", 2D) = "White"{}
	}

		SubShader{
			Tags{
			"Queue" = "Geometry"
			}

			CGPROGRAM
			#pragma surface surf ToonRamp

			//Declare variables
			float4 _Colour;
			sampler2D _RampTex;

			half4 LightingToonRamp(SurfaceOutput s,half3 lightDir, half atten)
			{
				float diff = dot(s.Normal,lightDir);
				float h = diff * 0.5 + 0.5;
				float2 rh = h;
				float3 ramp = tex2D(_RampTex, rh).rgb;

				float4 c;
				c.rgb = s.Albedo * _LightColor0.rgb*(ramp);
				c.a = s.Alpha;
				return c;
			}
			
		
			

		struct Input{
			float2 uvMainTex;
		};		

		void surf(Input IN, inout SurfaceOutput o)
		{
			
			o.Albedo = _Colour.rgb;			
		}
		ENDCG
	}
	FallBack "Diffuse"
}