//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Avalon2/AdditiveUV" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_ScrollXSpeed ("X Scroll Speed", Range(-100, 100)) = 50
_ScrollYSpeed ("Y Scroll Speed", Range(-100, 100)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 61320
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _ScrollXSpeed;
uniform lowp float _ScrollYSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  lowp float yScrollValue_2;
  lowp float xScrollValue_3;
  highp float tmpvar_4;
  tmpvar_4 = (_ScrollXSpeed * _Time).x;
  xScrollValue_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_ScrollYSpeed * _Time).x;
  yScrollValue_2 = tmpvar_5;
  lowp vec2 tmpvar_6;
  tmpvar_6.x = xScrollValue_3;
  tmpvar_6.y = yScrollValue_2;
  tmpvar_1 = (xlv_TEXCOORD0 + tmpvar_6);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, tmpvar_1)));
  gl_FragData[0] = tmpvar_7;
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _ScrollXSpeed;
uniform lowp float _ScrollYSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  lowp float yScrollValue_2;
  lowp float xScrollValue_3;
  highp float tmpvar_4;
  tmpvar_4 = (_ScrollXSpeed * _Time).x;
  xScrollValue_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_ScrollYSpeed * _Time).x;
  yScrollValue_2 = tmpvar_5;
  lowp vec2 tmpvar_6;
  tmpvar_6.x = xScrollValue_3;
  tmpvar_6.y = yScrollValue_2;
  tmpvar_1 = (xlv_TEXCOORD0 + tmpvar_6);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, tmpvar_1)));
  gl_FragData[0] = tmpvar_7;
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _ScrollXSpeed;
uniform lowp float _ScrollYSpeed;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  lowp float yScrollValue_2;
  lowp float xScrollValue_3;
  highp float tmpvar_4;
  tmpvar_4 = (_ScrollXSpeed * _Time).x;
  xScrollValue_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_ScrollYSpeed * _Time).x;
  yScrollValue_2 = tmpvar_5;
  lowp vec2 tmpvar_6;
  tmpvar_6.x = xScrollValue_3;
  tmpvar_6.y = yScrollValue_2;
  tmpvar_1 = (xlv_TEXCOORD0 + tmpvar_6);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((2.0 * xlv_COLOR) * (_TintColor * texture2D (_MainTex, tmpvar_1)));
  gl_FragData[0] = tmpvar_7;
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
varying highp vec4 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _ScrollXSpeed;
uniform lowp float _ScrollYSpeed;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  lowp float yScrollValue_3;
  lowp float xScrollValue_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_6;
  z_6 = tmpvar_5.x;
  highp float tmpvar_7;
  tmpvar_7 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_6) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_7);
  highp float tmpvar_8;
  tmpvar_8 = (_ScrollXSpeed * _Time).x;
  xScrollValue_4 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_ScrollYSpeed * _Time).x;
  yScrollValue_3 = tmpvar_9;
  lowp vec2 tmpvar_10;
  tmpvar_10.x = xScrollValue_4;
  tmpvar_10.y = yScrollValue_3;
  tmpvar_2 = (xlv_TEXCOORD0 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, tmpvar_2)));
  gl_FragData[0] = tmpvar_11;
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
varying highp vec4 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _ScrollXSpeed;
uniform lowp float _ScrollYSpeed;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  lowp float yScrollValue_3;
  lowp float xScrollValue_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_6;
  z_6 = tmpvar_5.x;
  highp float tmpvar_7;
  tmpvar_7 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_6) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_7);
  highp float tmpvar_8;
  tmpvar_8 = (_ScrollXSpeed * _Time).x;
  xScrollValue_4 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_ScrollYSpeed * _Time).x;
  yScrollValue_3 = tmpvar_9;
  lowp vec2 tmpvar_10;
  tmpvar_10.x = xScrollValue_4;
  tmpvar_10.y = yScrollValue_3;
  tmpvar_2 = (xlv_TEXCOORD0 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, tmpvar_2)));
  gl_FragData[0] = tmpvar_11;
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
varying highp vec4 xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _ScrollXSpeed;
uniform lowp float _ScrollYSpeed;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  lowp float yScrollValue_3;
  lowp float xScrollValue_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_6;
  z_6 = tmpvar_5.x;
  highp float tmpvar_7;
  tmpvar_7 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_6) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_7);
  highp float tmpvar_8;
  tmpvar_8 = (_ScrollXSpeed * _Time).x;
  xScrollValue_4 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_ScrollYSpeed * _Time).x;
  yScrollValue_3 = tmpvar_9;
  lowp vec2 tmpvar_10;
  tmpvar_10.x = xScrollValue_4;
  tmpvar_10.y = yScrollValue_3;
  tmpvar_2 = (xlv_TEXCOORD0 + tmpvar_10);
  lowp vec4 tmpvar_11;
  tmpvar_11 = ((2.0 * tmpvar_1) * (_TintColor * texture2D (_MainTex, tmpvar_2)));
  gl_FragData[0] = tmpvar_11;
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
}
}
}
}