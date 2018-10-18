Shader "Dave/BumpDifuse"{
	Properties{
		_myDiffuse("Example Texture",2D) = "white" {}
		_myBump("Bump Texture",2D) = "bump" {}
		_bumpAmount("Bump Amount", Range(0,10)) = 1

	}
	
	SubShader{
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _myDiffuse;
		sampler2D _myBump;
		half _bumpAmount;

		struct Input{
			float2 uv_myDiffuse;
			float2 uv_myBump;
	};


	void surf(Input IN, inout SurfaceOutput o){
		//get uv value and put textures on it 
		o.Albedo = (tex2D(_myDiffuse, IN.uv_myDiffuse)).rgb;
		o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
		o.Normal *= float3(_bumpAmount, _bumpAmount, 1);
	}
	ENDCG
	}
		FallBack "Diffuse"
}