Shader "Unlit/Toon"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Brightness("Brightness", Range(0,1)) = 0.3
        _Strength("Strength", Range(0,1)) = 0.5
        _BringhtColor("BrightColor", COLOR) = (1,1,1,1)
        _DarkColor("DarkColor", COLOR) = (1,1,1,1)
        _Detail("Detail", Range(0,1)) = 0.3
         
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 100
 



       
        Pass
        {
            Cull Back
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal: Normal;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                half3 worldNormal:TEXCOORD1;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Brightness;
            float _Strength;
            float4 _BringhtColor;
            float4 _DarkColor;
            float _Detail;

            float Toon(float3 normal, float3 lightDir) {
                float NdotL = max(0.0, dot(normalize(normal), normalize(lightDir)));
                return floor(NdotL /_Detail);
            }
            v2f vert (appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.worldNormal= UnityObjectToWorldNormal(v.normal);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                 UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                 
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                col *= Toon(i.worldNormal, _WorldSpaceLightPos0.xyz) * _Strength * _BringhtColor + _Brightness;
                return col;
            }
            ENDCG
        }
 


    }
    FallBack "Diffuse"
}
