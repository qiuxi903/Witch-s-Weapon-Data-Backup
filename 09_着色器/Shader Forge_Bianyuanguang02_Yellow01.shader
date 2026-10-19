//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Shader Forge/Bianyuanguang02_Yellow01" {
Properties {
_node_2701 ("node_2701", 2D) = "white" { }
_node_9431 ("node_9431", 2D) = "white" { }
_node_6379 ("node_6379", 2D) = "white" { }
_node_8248 ("node_8248", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend One One, One One
  ZWrite Off
  Cull Off
  GpuProgramID 5463
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp mat3 tmpvar_1;
  tmpvar_1[0] = unity_WorldToObject[0].xyz;
  tmpvar_1[1] = unity_WorldToObject[1].xyz;
  tmpvar_1[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _node_2701;
uniform highp vec4 _node_2701_ST;
uniform sampler2D _node_9431;
uniform highp vec4 _node_9431_ST;
uniform sampler2D _node_6379;
uniform highp vec4 _node_6379_ST;
uniform sampler2D _node_8248;
uniform highp vec4 _node_8248_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 _node_8248_var_1;
  highp vec4 _node_6379_var_2;
  highp vec4 _node_9431_var_3;
  highp vec4 _node_2701_var_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_7;
  tmpvar_7 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.0, 0.03))
  ) * _node_2701_ST.xy) + _node_2701_ST.zw);
  tmpvar_8 = texture2D (_node_2701, P_9);
  _node_2701_var_4 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.02))
  ) * _node_9431_ST.xy) + _node_9431_ST.zw);
  tmpvar_10 = texture2D (_node_9431, P_11);
  _node_9431_var_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(0.05, 0.1))
  ) * _node_6379_ST.xy) + _node_6379_ST.zw);
  tmpvar_12 = texture2D (_node_6379, P_13);
  _node_6379_var_2 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((xlv_TEXCOORD0 + 
    (tmpvar_7.y * vec2(-0.05, 0.25))
  ) * _node_8248_ST.xy) + _node_8248_ST.zw);
  tmpvar_14 = texture2D (_node_8248, P_15);
  _node_8248_var_1 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (((
    ((_node_2701_var_4.x * _node_9431_var_3.x) * vec3(1.0, 0.8896552, 0.0))
   + 
    ((_node_6379_var_2.x * _node_8248_var_1.x) * vec3(1.0, 0.9310346, 0.0))
  ) * pow (
    (1.0 - max (0.0, dot ((tmpvar_5 * 
      sign(dot (tmpvar_6, tmpvar_5))
    ), tmpvar_6)))
  , 1.2)) * xlv_COLOR.xyz);
  tmpvar_16.w = xlv_COLOR.w;
  gl_FragData[0] = tmpvar_16;
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
Fallback "Diffuse"
CustomEditor "ShaderForgeMaterialInspector"
}