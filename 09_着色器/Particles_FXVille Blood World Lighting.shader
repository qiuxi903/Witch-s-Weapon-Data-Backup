//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Particles/FXVille Blood World Lighting" {
Properties {
_Columns ("Flipbook Columns", Float) = 1
_Rows ("Flipbook Rows", Float) = 1
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_ChannelMask ("Channel Mask Color", Color) = (0,0,0,1)
_MainTex ("Particle Texture", 2D) = "white" { }
_EdgeMin ("SmoothStep Edge Min", Float) = 0.05
_EdgeSoft ("SmoothStep Softness", Float) = 0.05
_NormalMap ("Normal Map", 2D) = "bump" { }
_NormalStr ("Normal Strength", Float) = 1
_HighlightColor ("Highlight Color", Color) = (1,1,1,0)
_Shininess ("Shininess", Float) = 64
_Detail ("Detail Tex", 2D) = "gray" { }
_DetailTile ("Detail Tiling", Float) = 6
_DetailPan ("Detail Alpha Pan", Float) = 0.1
_DetailAlphaAffect ("Detail Alpha Affect", Float) = 1
_DetailBrightAffect ("Detail Brightness Affect", Float) = 0.5
_UVOff ("UV Offset Map", 2D) = "bump" { }
_OffPow ("UV Offset Power", Float) = 0.1
_OffTile ("UV Offset Tiling", Float) = 1
_Overbright ("Overbright", Float) = 0
_Ambience ("Lighting Ambience", Float) = 0.5
_InvFade ("Soft Particles Factor", Range(0.01, 8)) = 3
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 36312
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_30;
  tmpvar_30.z = 1.0;
  tmpvar_30.x = _NormalStr;
  tmpvar_30.y = _NormalStr;
  lowp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_20 * tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_NORMAL + tmpvar_31));
  highp float tmpvar_33;
  tmpvar_33 = ((dot (tmpvar_32, tmpvar_29) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_34;
  tmpvar_34 = clamp (mix (tmpvar_33, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_34 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_35;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_32, normalize(
        (tmpvar_29 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_33) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_36.w = col_4.w;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_30;
  tmpvar_30.z = 1.0;
  tmpvar_30.x = _NormalStr;
  tmpvar_30.y = _NormalStr;
  lowp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_20 * tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_NORMAL + tmpvar_31));
  highp float tmpvar_33;
  tmpvar_33 = ((dot (tmpvar_32, tmpvar_29) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_34;
  tmpvar_34 = clamp (mix (tmpvar_33, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_34 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_35;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_32, normalize(
        (tmpvar_29 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_33) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_36.w = col_4.w;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_29;
  tmpvar_29 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_30;
  tmpvar_30.z = 1.0;
  tmpvar_30.x = _NormalStr;
  tmpvar_30.y = _NormalStr;
  lowp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_20 * tmpvar_30));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((xlv_NORMAL + tmpvar_31));
  highp float tmpvar_33;
  tmpvar_33 = ((dot (tmpvar_32, tmpvar_29) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_34;
  tmpvar_34 = clamp (mix (tmpvar_33, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_34 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_35;
  highp vec4 tmpvar_36;
  tmpvar_36.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_32, normalize(
        (tmpvar_29 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_33) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_36.w = col_4.w;
  tmpvar_1 = tmpvar_36;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_31;
  tmpvar_31 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_32;
  tmpvar_32.z = 1.0;
  tmpvar_32.x = _NormalStr;
  tmpvar_32.y = _NormalStr;
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_22 * tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((xlv_NORMAL + tmpvar_33));
  highp float tmpvar_35;
  tmpvar_35 = ((dot (tmpvar_34, tmpvar_31) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_36;
  tmpvar_36 = clamp (mix (tmpvar_35, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_34, normalize(
        (tmpvar_31 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_35) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_38.w = col_5.w;
  tmpvar_1 = tmpvar_38;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_31;
  tmpvar_31 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_32;
  tmpvar_32.z = 1.0;
  tmpvar_32.x = _NormalStr;
  tmpvar_32.y = _NormalStr;
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_22 * tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((xlv_NORMAL + tmpvar_33));
  highp float tmpvar_35;
  tmpvar_35 = ((dot (tmpvar_34, tmpvar_31) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_36;
  tmpvar_36 = clamp (mix (tmpvar_35, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_34, normalize(
        (tmpvar_31 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_35) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_38.w = col_5.w;
  tmpvar_1 = tmpvar_38;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_31;
  tmpvar_31 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_32;
  tmpvar_32.z = 1.0;
  tmpvar_32.x = _NormalStr;
  tmpvar_32.y = _NormalStr;
  lowp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_22 * tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((xlv_NORMAL + tmpvar_33));
  highp float tmpvar_35;
  tmpvar_35 = ((dot (tmpvar_34, tmpvar_31) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_36;
  tmpvar_36 = clamp (mix (tmpvar_35, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_36 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_34, normalize(
        (tmpvar_31 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_35) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_38.w = col_5.w;
  tmpvar_1 = tmpvar_38;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_1.z);
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2((-(tmpvar_3) * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_1.z);
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2((-(tmpvar_3) * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_1.z);
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2((-(tmpvar_3) * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 diffuseReflection_2;
  highp float NdotV_3;
  lowp vec4 col_4;
  lowp vec4 tex_5;
  lowp vec4 detail_6;
  lowp float edgeMask_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_7 = (tmpvar_9 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_7 = (edgeMask_7 * tmpvar_13);
  lowp vec2 tmpvar_14;
  tmpvar_14.x = (xlv_COLOR.y * 154.6);
  tmpvar_14.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_15;
  P_15 = ((xlv_TEXCOORD0 + tmpvar_14) * _OffTile);
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_UVOff, P_15) * 2.0) - 1.0);
  lowp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.y * _OffPow);
  tmpvar_17.y = (tmpvar_16.w * _OffPow);
  lowp vec2 tmpvar_18;
  tmpvar_18 = ((0.1 * tmpvar_17) * edgeMask_7);
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 + tmpvar_18);
  lowp vec3 tmpvar_20;
  tmpvar_20 = ((texture2D (_NormalMap, P_19).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_21) + tmpvar_18);
  tmpvar_22 = texture2D (_Detail, P_23);
  detail_6.xyz = tmpvar_22.xyz;
  detail_6.w = mix (1.0, tmpvar_22.w, _DetailAlphaAffect);
  detail_6.w = (detail_6.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_22.xyz, vec3(_DetailAlphaAffect)).x);
  detail_6.xyz = mix ((1.0 - tmpvar_22.xyz), tmpvar_22.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 + tmpvar_18);
  tmpvar_24 = texture2D (_MainTex, P_25);
  tex_5.xyz = tmpvar_24.xyz;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _TintColor.xyz;
  col_4.xyz = tmpvar_26.xyz;
  lowp vec4 x_27;
  x_27 = (tmpvar_24 * _ChannelMask);
  tex_5.w = sqrt(dot (x_27, x_27));
  col_4.w = (tex_5.w * (xlv_COLOR.w * detail_6.w));
  lowp float tmpvar_28;
  tmpvar_28 = clamp (((col_4.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_4.w = (tmpvar_28 * (tmpvar_28 * (3.0 - 
    (2.0 * tmpvar_28)
  )));
  col_4.xyz = (((_TintColor.xyz * detail_6.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_29;
  tmpvar_29 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_4.xyz = mix (unity_FogColor.xyz, col_4.xyz, vec3(tmpvar_29));
  highp vec3 tmpvar_30;
  tmpvar_30 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_31;
  tmpvar_31.z = 1.0;
  tmpvar_31.x = _NormalStr;
  tmpvar_31.y = _NormalStr;
  lowp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_20 * tmpvar_31));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((xlv_NORMAL + tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = ((dot (tmpvar_33, tmpvar_30) * 0.5) + 0.5);
  NdotV_3 = (((tmpvar_20.x + tmpvar_20.y) + 1.0) - col_4.w);
  highp float tmpvar_35;
  tmpvar_35 = clamp (mix (tmpvar_34, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_35 + tmpvar_8.xyz);
  diffuseReflection_2 = tmpvar_36;
  highp vec4 tmpvar_37;
  tmpvar_37.xyz = ((col_4.xyz * diffuseReflection_2) + ((
    ((((
      pow (clamp (dot (tmpvar_33, normalize(
        (tmpvar_30 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_34) * 4.0) * _LightColor0.xyz) + (tmpvar_8.xyz * NdotV_3))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_37.w = col_4.w;
  tmpvar_1 = tmpvar_37;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  highp float tmpvar_9;
  tmpvar_9 = (unity_FogParams.x * tmpvar_3.z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2((-(tmpvar_9) * tmpvar_9));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  highp float tmpvar_9;
  tmpvar_9 = (unity_FogParams.x * tmpvar_3.z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2((-(tmpvar_9) * tmpvar_9));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  highp float tmpvar_9;
  tmpvar_9 = (unity_FogParams.x * tmpvar_3.z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_NORMAL = _glesNormal;
  xlv_TEXCOORD1 = exp2((-(tmpvar_9) * tmpvar_9));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _NormalMap;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp vec4 _HighlightColor;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _Shininess;
uniform lowp float _NormalStr;
uniform lowp float _Ambience;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  highp vec3 diffuseReflection_3;
  highp float NdotV_4;
  lowp vec4 col_5;
  lowp vec4 tex_6;
  lowp vec4 detail_7;
  lowp float edgeMask_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_9);
  lowp vec4 tmpvar_10;
  tmpvar_10 = (glstate_lightmodel_ambient * 2.0);
  lowp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_8 = (tmpvar_11 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_8 = (edgeMask_8 * tmpvar_15);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (xlv_COLOR.y * 154.6);
  tmpvar_16.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD0 + tmpvar_16) * _OffTile);
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_UVOff, P_17) * 2.0) - 1.0);
  lowp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.y * _OffPow);
  tmpvar_19.y = (tmpvar_18.w * _OffPow);
  lowp vec2 tmpvar_20;
  tmpvar_20 = ((0.1 * tmpvar_19) * edgeMask_8);
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 + tmpvar_20);
  lowp vec3 tmpvar_22;
  tmpvar_22 = ((texture2D (_NormalMap, P_21).xyz * 2.0) - 1.0);
  lowp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_23) + tmpvar_20);
  tmpvar_24 = texture2D (_Detail, P_25);
  detail_7.xyz = tmpvar_24.xyz;
  detail_7.w = mix (1.0, tmpvar_24.w, _DetailAlphaAffect);
  detail_7.w = (detail_7.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_24.xyz, vec3(_DetailAlphaAffect)).x);
  detail_7.xyz = mix ((1.0 - tmpvar_24.xyz), tmpvar_24.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 + tmpvar_20);
  tmpvar_26 = texture2D (_MainTex, P_27);
  tex_6.xyz = tmpvar_26.xyz;
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = _TintColor.xyz;
  col_5.xyz = tmpvar_28.xyz;
  lowp vec4 x_29;
  x_29 = (tmpvar_26 * _ChannelMask);
  tex_6.w = sqrt(dot (x_29, x_29));
  col_5.w = (tex_6.w * (tmpvar_2.w * detail_7.w));
  lowp float tmpvar_30;
  tmpvar_30 = clamp (((col_5.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_5.w = (tmpvar_30 * (tmpvar_30 * (3.0 - 
    (2.0 * tmpvar_30)
  )));
  col_5.xyz = (((_TintColor.xyz * detail_7.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp float tmpvar_31;
  tmpvar_31 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  col_5.xyz = mix (unity_FogColor.xyz, col_5.xyz, vec3(tmpvar_31));
  highp vec3 tmpvar_32;
  tmpvar_32 = ((normalize(
    (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz)
  ) * _WorldSpaceLightPos0.w) + (normalize(_WorldSpaceLightPos0.xyz) * (1.0 - _WorldSpaceLightPos0.w)));
  lowp vec3 tmpvar_33;
  tmpvar_33.z = 1.0;
  tmpvar_33.x = _NormalStr;
  tmpvar_33.y = _NormalStr;
  lowp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_22 * tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((xlv_NORMAL + tmpvar_34));
  highp float tmpvar_36;
  tmpvar_36 = ((dot (tmpvar_35, tmpvar_32) * 0.5) + 0.5);
  NdotV_4 = (((tmpvar_22.x + tmpvar_22.y) + 1.0) - col_5.w);
  highp float tmpvar_37;
  tmpvar_37 = clamp (mix (tmpvar_36, 1.0, _Ambience), 0.0, 1.0);
  lowp vec3 tmpvar_38;
  tmpvar_38 = (tmpvar_37 + tmpvar_10.xyz);
  diffuseReflection_3 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39.xyz = ((col_5.xyz * diffuseReflection_3) + ((
    ((((
      pow (clamp (dot (tmpvar_35, normalize(
        (tmpvar_32 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2.xyz)))
      )), 0.0, 1.0), _Shininess)
     * tmpvar_36) * 4.0) * _LightColor0.xyz) + (tmpvar_10.xyz * NdotV_4))
   * _HighlightColor.xyz) * xlv_COLOR.z));
  tmpvar_39.w = col_5.w;
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
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
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
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
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
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
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
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
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One One, One One
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 109205
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_1.z);
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2((-(tmpvar_3) * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_1.z);
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2((-(tmpvar_3) * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_1.z);
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2((-(tmpvar_3) * tmpvar_3));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 col_2;
  lowp vec4 tex_3;
  lowp vec4 detail_4;
  lowp float edgeMask_5;
  highp vec3 lightColor_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lightColor_6 = tmpvar_7;
  lowp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_5 = (tmpvar_8 * tmpvar_10);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_11);
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_5 = (edgeMask_5 * tmpvar_12);
  lowp vec2 tmpvar_13;
  tmpvar_13.x = (xlv_COLOR.y * 154.6);
  tmpvar_13.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_13) * _OffTile);
  lowp vec4 tmpvar_15;
  tmpvar_15 = ((texture2D (_UVOff, P_14) * 2.0) - 1.0);
  lowp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.y * _OffPow);
  tmpvar_16.y = (tmpvar_15.w * _OffPow);
  lowp vec2 tmpvar_17;
  tmpvar_17 = ((0.1 * tmpvar_16) * edgeMask_5);
  lowp vec2 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = ((xlv_COLOR.y * 1.32) + (xlv_COLOR.w * _DetailPan));
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_18) + tmpvar_17);
  tmpvar_19 = texture2D (_Detail, P_20);
  detail_4.xyz = tmpvar_19.xyz;
  detail_4.w = mix (1.0, tmpvar_19.w, _DetailAlphaAffect);
  detail_4.w = (detail_4.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_19.xyz, vec3(_DetailAlphaAffect)).x);
  detail_4.xyz = mix ((1.0 - tmpvar_19.xyz), tmpvar_19.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 + tmpvar_17);
  tmpvar_21 = texture2D (_MainTex, P_22);
  tex_3.xyz = tmpvar_21.xyz;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _TintColor.xyz;
  col_2.xyz = tmpvar_23.xyz;
  lowp vec4 x_24;
  x_24 = (tmpvar_21 * _ChannelMask);
  tex_3.w = sqrt(dot (x_24, x_24));
  col_2.w = (tex_3.w * (xlv_COLOR.w * detail_4.w));
  lowp float tmpvar_25;
  tmpvar_25 = clamp (((col_2.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_2.w = (tmpvar_25 * (tmpvar_25 * (3.0 - 
    (2.0 * tmpvar_25)
  )));
  col_2.xyz = (((_TintColor.xyz * detail_4.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = ((col_2.xyz * (lightColor_6 * 
    (((exp2(
      ((-0.1 * tmpvar_27) * (tmpvar_27 * tmpvar_27))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_2.w);
  tmpvar_28.w = col_2.w;
  tmpvar_1 = tmpvar_28;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  highp float tmpvar_9;
  tmpvar_9 = (unity_FogParams.x * tmpvar_3.z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2((-(tmpvar_9) * tmpvar_9));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  highp float tmpvar_9;
  tmpvar_9 = (unity_FogParams.x * tmpvar_3.z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2((-(tmpvar_9) * tmpvar_9));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  highp float tmpvar_9;
  tmpvar_9 = (unity_FogParams.x * tmpvar_3.z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = exp2((-(tmpvar_9) * tmpvar_9));
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _Detail;
uniform sampler2D _UVOff;
uniform lowp vec4 _TintColor;
uniform lowp vec4 _ChannelMask;
uniform lowp float _EdgeMin;
uniform lowp float _EdgeSoft;
uniform lowp float _Overbright;
uniform lowp float _DetailTile;
uniform lowp float _DetailPan;
uniform lowp float _OffPow;
uniform lowp float _OffTile;
uniform lowp float _DetailBrightAffect;
uniform lowp float _DetailAlphaAffect;
uniform lowp float _Columns;
uniform lowp float _Rows;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 col_3;
  lowp vec4 tex_4;
  lowp vec4 detail_5;
  lowp float edgeMask_6;
  highp vec3 lightColor_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.z)), 0.0, 1.0);
  tmpvar_2.w = (xlv_COLOR.w * tmpvar_8);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  lightColor_7 = tmpvar_9;
  lowp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((2.0 * fract(
    (_Rows * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp ((2.0 * fract(
    (-(_Rows) * xlv_TEXCOORD0.x)
  )), 0.0, 1.0);
  edgeMask_6 = (tmpvar_10 * tmpvar_12);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((2.0 * fract(
    (_Columns * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_13);
  highp float tmpvar_14;
  tmpvar_14 = clamp ((2.0 * fract(
    (-(_Columns) * xlv_TEXCOORD0.y)
  )), 0.0, 1.0);
  edgeMask_6 = (edgeMask_6 * tmpvar_14);
  lowp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_COLOR.y * 154.6);
  tmpvar_15.y = (xlv_COLOR.y * 798.3);
  highp vec2 P_16;
  P_16 = ((xlv_TEXCOORD0 + tmpvar_15) * _OffTile);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((texture2D (_UVOff, P_16) * 2.0) - 1.0);
  lowp vec2 tmpvar_18;
  tmpvar_18.x = (tmpvar_17.y * _OffPow);
  tmpvar_18.y = (tmpvar_17.w * _OffPow);
  lowp vec2 tmpvar_19;
  tmpvar_19 = ((0.1 * tmpvar_18) * edgeMask_6);
  lowp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = ((xlv_COLOR.y * 1.32) + (tmpvar_2.w * _DetailPan));
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (((_DetailTile * xlv_TEXCOORD0) + tmpvar_20) + tmpvar_19);
  tmpvar_21 = texture2D (_Detail, P_22);
  detail_5.xyz = tmpvar_21.xyz;
  detail_5.w = mix (1.0, tmpvar_21.w, _DetailAlphaAffect);
  detail_5.w = (detail_5.w * mix (vec3(1.0, 1.0, 1.0), tmpvar_21.xyz, vec3(_DetailAlphaAffect)).x);
  detail_5.xyz = mix ((1.0 - tmpvar_21.xyz), tmpvar_21.xyz, vec3((_DetailBrightAffect + 0.5)));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (xlv_TEXCOORD0 + tmpvar_19);
  tmpvar_23 = texture2D (_MainTex, P_24);
  tex_4.xyz = tmpvar_23.xyz;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _TintColor.xyz;
  col_3.xyz = tmpvar_25.xyz;
  lowp vec4 x_26;
  x_26 = (tmpvar_23 * _ChannelMask);
  tex_4.w = sqrt(dot (x_26, x_26));
  col_3.w = (tex_4.w * (tmpvar_2.w * detail_5.w));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (((col_3.w - _EdgeMin) / (
    (_EdgeMin + _EdgeSoft)
   - _EdgeMin)), 0.0, 1.0);
  col_3.w = (tmpvar_27 * (tmpvar_27 * (3.0 - 
    (2.0 * tmpvar_27)
  )));
  col_3.xyz = (((_TintColor.xyz * detail_5.xyz) * xlv_COLOR.x) * (_Overbright + 1.0));
  highp vec3 tmpvar_28;
  tmpvar_28 = (_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2.xyz);
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = ((col_3.xyz * (lightColor_7 * 
    (((exp2(
      ((-0.1 * tmpvar_29) * (tmpvar_29 * tmpvar_29))
    ) * _WorldSpaceLightPos0.w) + 1.0) - _WorldSpaceLightPos0.w)
  )) * col_3.w);
  tmpvar_30.w = col_3.w;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
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
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
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
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
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
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
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
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" "SOFTPARTICLES_ON" }
""
}
}
}
}
Fallback "Paricles/Alpha Blended"
}