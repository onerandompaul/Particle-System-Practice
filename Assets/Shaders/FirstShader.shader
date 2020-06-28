﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/ShaderTests/FirstShader Shader"{
    // Variables
    Properties{
        _MainTexture("Main Color (RBG) Hello!", 2D) = "white" {}
        _Color("Kleur", Color) = (1,1,1,1)

        _DissolveTexture("Cheese", 2D) = "white" {}
        _DissolveAmount("Cheese Cut Amount", float) = 1

        _ExtrudeAmount("Extrude Factor", float) = 0
    }

    SubShader{
        Pass{
            CGPROGRAM

            #pragma vertex vertexFunction
            #pragma fragment fragmentFunction

            #include "UnityCG.cginc"
            // Vertex

            struct appdata {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
                float3 normal: NORMAL;
            };

            struct v2f {
                float4 position: SV_POSITION;
                float2 uv: TEXCOORD0;
            };

            float4 _Color;
            sampler2D _MainTexture;

            sampler2D _DissolveTexture;
            float _DissolveAmount;

            float _ExtrudeAmount;

            v2f vertexFunction(appdata IN) {
                v2f OUT;

                IN.vertex.xyz += IN.normal.xyz * _ExtrudeAmount;

                OUT.position = UnityObjectToClipPos(IN.vertex);
                OUT.uv = IN.uv;



                return OUT;
            }

            

            // Fragment

            fixed4 fragmentFunction(v2f IN) : SV_Target{

                float4 textureColor = tex2D(_MainTexture, IN.uv);

                float4 dissolveColor = tex2D(_DissolveTexture, IN.uv);

                return textureColor;
            }

            ENDCG
        }
    }
}