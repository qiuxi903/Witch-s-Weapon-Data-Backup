//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "FX/Water (Basic)" {
Properties {
_horizonColor ("Horizon color", Color) = (0.172,0.463,0.435,0)
_WaveScale ("Wave scale", Range(0.02, 0.15)) = 0.07
_ColorControl ("Reflective color (RGB) fresnel (A) ", 2D) = "" { }
_BumpMap ("Waves Normalmap ", 2D) = "" { }
WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 11082
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_3.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_3.xyz)).xzy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_3.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_3.xyz)).xzy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_3.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_3.xyz)).xzy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = exp2(-((unity_FogParams.y * tmpvar_2.z)));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = exp2(-((unity_FogParams.y * tmpvar_2.z)));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = exp2(-((unity_FogParams.y * tmpvar_2.z)));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  highp float tmpvar_5;
  tmpvar_5 = (unity_FogParams.x * tmpvar_2.z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = exp2((-(tmpvar_5) * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  highp float tmpvar_5;
  tmpvar_5 = (unity_FogParams.x * tmpvar_2.z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = exp2((-(tmpvar_5) * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  temp_1 = ((tmpvar_4.xzxz * _WaveScale) + _WaveOffset);
  highp float tmpvar_5;
  tmpvar_5 = (unity_FogParams.x * tmpvar_2.z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (temp_1.xy * vec2(0.4, 0.45));
  xlv_TEXCOORD0_1 = temp_1.wz;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_4.xyz)).xzy;
  xlv_TEXCOORD3 = exp2((-(tmpvar_5) * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform highp vec4 _horizonColor;
uniform sampler2D _BumpMap;
uniform sampler2D _ColorControl;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 water_2;
  mediump float fresnel_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0_1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD2, tmpvar_8);
  fresnel_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ColorControl, vec2(fresnel_3));
  water_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_2.xyz, _horizonColor.xyz, water_2.www);
  col_1.xyz = tmpvar_11;
  col_1.w = _horizonColor.w;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(tmpvar_12));
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
}