//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Avalon2/Model/TransparentDoubleSided" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Alpha ("Alpha", Range(0, 1)) = 1
_EffectAmount ("Effect Amount", Range(0, 1)) = 0
_Brightness ("Brightness", Range(0, 1)) = 1
_TintColor ("Tint Color", Color) = (0.25,0.25,0.25,0.25)
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 9561
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
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
uniform lowp float _Alpha;
uniform lowp vec4 _TintColor;
uniform highp float _Brightness;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  col_1.xyz = ((tmpvar_2.xyz * _TintColor.xyz) * 2.0);
  if ((_EffectAmount > 0.01)) {
    lowp float tmpvar_3;
    tmpvar_3 = dot (col_1.xyz, vec3(0.3, 0.59, 0.11));
    highp vec3 tmpvar_4;
    tmpvar_4 = mix (col_1.xyz, vec3(tmpvar_3), vec3(_EffectAmount));
    col_1.xyz = tmpvar_4;
  };
  if (((_Brightness < 0.99) || (_Brightness > 1.01))) {
    col_1.xyz = (col_1.xyz * _Brightness);
  };
  col_1.w = ((tmpvar_2.w - 1.0) + _Alpha);
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = col_1.xyz;
  tmpvar_5.w = col_1.w;
  gl_FragData[0] = tmpvar_5;
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
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
uniform lowp float _Alpha;
uniform lowp vec4 _TintColor;
uniform highp float _Brightness;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  col_1.xyz = ((tmpvar_2.xyz * _TintColor.xyz) * 2.0);
  if ((_EffectAmount > 0.01)) {
    lowp float tmpvar_3;
    tmpvar_3 = dot (col_1.xyz, vec3(0.3, 0.59, 0.11));
    highp vec3 tmpvar_4;
    tmpvar_4 = mix (col_1.xyz, vec3(tmpvar_3), vec3(_EffectAmount));
    col_1.xyz = tmpvar_4;
  };
  if (((_Brightness < 0.99) || (_Brightness > 1.01))) {
    col_1.xyz = (col_1.xyz * _Brightness);
  };
  col_1.w = ((tmpvar_2.w - 1.0) + _Alpha);
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = col_1.xyz;
  tmpvar_5.w = col_1.w;
  gl_FragData[0] = tmpvar_5;
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
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
uniform lowp float _Alpha;
uniform lowp vec4 _TintColor;
uniform highp float _Brightness;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  col_1.xyz = ((tmpvar_2.xyz * _TintColor.xyz) * 2.0);
  if ((_EffectAmount > 0.01)) {
    lowp float tmpvar_3;
    tmpvar_3 = dot (col_1.xyz, vec3(0.3, 0.59, 0.11));
    highp vec3 tmpvar_4;
    tmpvar_4 = mix (col_1.xyz, vec3(tmpvar_3), vec3(_EffectAmount));
    col_1.xyz = tmpvar_4;
  };
  if (((_Brightness < 0.99) || (_Brightness > 1.01))) {
    col_1.xyz = (col_1.xyz * _Brightness);
  };
  col_1.w = ((tmpvar_2.w - 1.0) + _Alpha);
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = col_1.xyz;
  tmpvar_5.w = col_1.w;
  gl_FragData[0] = tmpvar_5;
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
}
}
}
Fallback "Avalon2/Basic"
}