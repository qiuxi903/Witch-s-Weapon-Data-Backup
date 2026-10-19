//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/Rim Light VF" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_TintColor ("Main Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_RimWidth ("Rim Width", Float) = 0.9
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  GpuProgramID 18204
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _RimColor;
uniform highp float _RimWidth;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp float edge0_4;
  edge0_4 = (1.0 - _RimWidth);
  highp float tmpvar_5;
  tmpvar_5 = clamp (((
    (1.0 - dot (_glesNormal, normalize((
      (unity_WorldToObject * tmpvar_3)
    .xyz - _glesVertex.xyz))))
   - edge0_4) / (1.0 - edge0_4)), 0.0, 1.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = vec3((tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  ))));
  tmpvar_1 = tmpvar_6;
  tmpvar_1 = (tmpvar_1 * _RimColor.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor);
  texcol_1.xyz = (texcol_1.xyz + xlv_COLOR);
  gl_FragData[0] = texcol_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _RimColor;
uniform highp float _RimWidth;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp float edge0_4;
  edge0_4 = (1.0 - _RimWidth);
  highp float tmpvar_5;
  tmpvar_5 = clamp (((
    (1.0 - dot (_glesNormal, normalize((
      (unity_WorldToObject * tmpvar_3)
    .xyz - _glesVertex.xyz))))
   - edge0_4) / (1.0 - edge0_4)), 0.0, 1.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = vec3((tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  ))));
  tmpvar_1 = tmpvar_6;
  tmpvar_1 = (tmpvar_1 * _RimColor.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor);
  texcol_1.xyz = (texcol_1.xyz + xlv_COLOR);
  gl_FragData[0] = texcol_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _RimColor;
uniform highp float _RimWidth;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp float edge0_4;
  edge0_4 = (1.0 - _RimWidth);
  highp float tmpvar_5;
  tmpvar_5 = clamp (((
    (1.0 - dot (_glesNormal, normalize((
      (unity_WorldToObject * tmpvar_3)
    .xyz - _glesVertex.xyz))))
   - edge0_4) / (1.0 - edge0_4)), 0.0, 1.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = vec3((tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  ))));
  tmpvar_1 = tmpvar_6;
  tmpvar_1 = (tmpvar_1 * _RimColor.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor);
  texcol_1.xyz = (texcol_1.xyz + xlv_COLOR);
  gl_FragData[0] = texcol_1;
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
}