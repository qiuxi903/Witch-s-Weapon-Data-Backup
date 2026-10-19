//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Avalon2/Default/TransparentVertexLit" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_SpecColor ("Spec Color", Color) = (1,1,1,0)
_Emission ("Emissive Color", Color) = (0,0,0,0)
_Shininess ("Shininess", Range(0.1, 1)) = 0.7
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Fog {
   Mode Off
  }
  GpuProgramID 53719
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    sqrt(dot (tmpvar_14, tmpvar_14))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    sqrt(dot (tmpvar_14, tmpvar_14))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    sqrt(dot (tmpvar_14, tmpvar_14))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_14, tmpvar_14)))
  )), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_14, tmpvar_14)))
  )), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_14, tmpvar_14)))
  )), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * sqrt(dot (tmpvar_14, tmpvar_14)));
  lowp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp2((
    -(tmpvar_27)
   * tmpvar_27)), 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * sqrt(dot (tmpvar_14, tmpvar_14)));
  lowp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp2((
    -(tmpvar_27)
   * tmpvar_27)), 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * sqrt(dot (tmpvar_14, tmpvar_14)));
  lowp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp2((
    -(tmpvar_27)
   * tmpvar_27)), 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp2((
    -(tmpvar_30)
   * tmpvar_30)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_33));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp2((
    -(tmpvar_30)
   * tmpvar_30)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_33));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp2((
    -(tmpvar_30)
   * tmpvar_30)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_33));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp2((
    -(tmpvar_32)
   * tmpvar_32)), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_33;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_35));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp2((
    -(tmpvar_32)
   * tmpvar_32)), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_33;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_35));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp2((
    -(tmpvar_32)
   * tmpvar_32)), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_33;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_35));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP2" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "VertexLM" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Fog {
   Mode Off
  }
  GpuProgramID 109557
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_3, tmpvar_3)))
  )), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_3, tmpvar_3)))
  )), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_3, tmpvar_3)))
  )), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * sqrt(dot (tmpvar_3, tmpvar_3)));
  lowp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (exp2((
    -(tmpvar_6)
   * tmpvar_6)), 0.0, 1.0);
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * sqrt(dot (tmpvar_3, tmpvar_3)));
  lowp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (exp2((
    -(tmpvar_6)
   * tmpvar_6)), 0.0, 1.0);
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * sqrt(dot (tmpvar_3, tmpvar_3)));
  lowp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (exp2((
    -(tmpvar_6)
   * tmpvar_6)), 0.0, 1.0);
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 2.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
  gl_FragData[0] = col_2;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "VertexLMRGBM" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Fog {
   Mode Off
  }
  GpuProgramID 189966
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_3, tmpvar_3)))
  )), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_3, tmpvar_3)))
  )), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  lowp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_3, tmpvar_3)))
  )), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * sqrt(dot (tmpvar_3, tmpvar_3)));
  lowp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (exp2((
    -(tmpvar_6)
   * tmpvar_6)), 0.0, 1.0);
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * sqrt(dot (tmpvar_3, tmpvar_3)));
  lowp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (exp2((
    -(tmpvar_6)
   * tmpvar_6)), 0.0, 1.0);
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
  lowp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * sqrt(dot (tmpvar_3, tmpvar_3)));
  lowp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (exp2((
    -(tmpvar_6)
   * tmpvar_6)), 0.0, 1.0);
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = tmpvar_7;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform mediump sampler2D unity_Lightmap;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying lowp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  col_2 = (tex_1 * tex_1.w);
  col_2 = (col_2 * 2.0);
  col_2 = (col_2 * _Color);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_4;
  col_2.xyz = (tmpvar_4 * col_2).xyz;
  col_2.xyz = (col_2 * 4.0).xyz;
  col_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  if ((col_2.w <= 0.0)) {
    discard;
  };
  col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD3));
  gl_FragData[0] = col_2;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
""
}
}
}
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Fog {
   Mode Off
  }
  GpuProgramID 250327
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    sqrt(dot (tmpvar_14, tmpvar_14))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    sqrt(dot (tmpvar_14, tmpvar_14))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (((
    sqrt(dot (tmpvar_14, tmpvar_14))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((
    sqrt(dot (tmpvar_15, tmpvar_15))
   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_14, tmpvar_14)))
  )), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_14, tmpvar_14)))
  )), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  lowp float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_14, tmpvar_14)))
  )), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_27;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_30;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  lowp float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (exp2(-(
    (unity_FogParams.y * sqrt(dot (tmpvar_15, tmpvar_15)))
  )), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_32;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * sqrt(dot (tmpvar_14, tmpvar_14)));
  lowp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp2((
    -(tmpvar_27)
   * tmpvar_27)), 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * sqrt(dot (tmpvar_14, tmpvar_14)));
  lowp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp2((
    -(tmpvar_27)
   * tmpvar_27)), 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = tmpvar_2.xyz;
  tmpvar_15[1] = tmpvar_3.xyz;
  tmpvar_15[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  eyeNormal_11 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_14);
  viewDir_10 = -(tmpvar_17);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_18;
    tmpvar_18 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_19;
    dirToLight_19 = tmpvar_18;
    mediump vec3 specColor_20;
    specColor_20 = specColor_8;
    mediump float tmpvar_21;
    tmpvar_21 = max (dot (eyeNormal_11, dirToLight_19), 0.0);
    mediump vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_21 > 0.0)) {
      specColor_20 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_19 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_20;
    lcolor_9 = (lcolor_9 + min ((tmpvar_22 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = clamp (color_12, 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * sqrt(dot (tmpvar_14, tmpvar_14)));
  lowp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (exp2((
    -(tmpvar_27)
   * tmpvar_27)), 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp2((
    -(tmpvar_30)
   * tmpvar_30)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_33));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp2((
    -(tmpvar_30)
   * tmpvar_30)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_33));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (exp2((
    -(tmpvar_30)
   * tmpvar_30)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_31;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_33));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp2((
    -(tmpvar_32)
   * tmpvar_32)), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_33;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_35));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp2((
    -(tmpvar_32)
   * tmpvar_32)), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_33;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_35));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (unity_FogParams.x * sqrt(dot (tmpvar_15, tmpvar_15)));
  lowp float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (exp2((
    -(tmpvar_32)
   * tmpvar_32)), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_33;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_35));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
varying lowp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * xlv_COLOR0.w);
  if ((col_1.w <= 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
  gl_FragData[0] = col_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP2" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP2" }
""
}
}
}
}
}