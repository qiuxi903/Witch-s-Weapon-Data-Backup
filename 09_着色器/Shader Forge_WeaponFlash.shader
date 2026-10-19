//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shader Forge/WeaponFlash" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_Light ("Light", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 53810
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TimeEditor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _Light;
uniform highp vec4 _Light_ST;
uniform highp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 _Light_var_1;
  highp vec4 _MainTex_var_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = texture2D (_MainTex, P_4);
  _MainTex_var_2 = tmpvar_3;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (vec2(-0.4, 0.0) * (_Time + _TimeEditor).y)
  ) * _Light_ST.xy) + _Light_ST.zw);
  tmpvar_5 = texture2D (_Light, P_6);
  _Light_var_1 = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = ((_MainTex_var_2.xyz + _Light_var_1.xyz) * _Color.xyz);
  tmpvar_7.w = _MainTex_var_2.w;
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
""
}
}
}
}
Fallback "Unlit/Texture"
CustomEditor "ShaderForgeMaterialInspector"
}