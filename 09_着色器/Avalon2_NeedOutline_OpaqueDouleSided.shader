//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Avalon2/NeedOutline/OpaqueDouleSided" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_Outline ("Outline", Range(0, 1)) = 0.015
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 56912
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixV[0].xyz;
  tmpvar_3[1] = unity_MatrixV[1].xyz;
  tmpvar_3[2] = unity_MatrixV[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((tmpvar_3 * 
    normalize((_glesNormal * tmpvar_2))
  ).xy * 0.5) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MatCap, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  lowp vec4 capCol_4;
  capCol_4 = tmpvar_2;
  lowp float ratio_5;
  lowp float tmpvar_6;
  tmpvar_6 = ((tmpvar_1.x + tmpvar_1.y) + tmpvar_1.z);
  lowp float tmpvar_7;
  tmpvar_7 = ((tmpvar_2.x + tmpvar_2.y) + tmpvar_2.z);
  if ((((tmpvar_6 - 2.0) > 0.0) && ((tmpvar_7 - 2.0) > 0.0))) {
    ratio_5 = (tmpvar_6 - 2.0);
    capCol_4.xyz = ((vec3(0.5, 0.5, 0.5) * ratio_5) + (tmpvar_2 * (1.0 - ratio_5)).xyz);
  };
  tmpvar_3 = ((tmpvar_1 * capCol_4) * 2.0);
  lowp vec4 origCol_8;
  origCol_8 = tmpvar_3;
  if ((_TintColor.x > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9.yzw = tmpvar_3.yzw;
    tmpvar_9.x = (tmpvar_3.x + ((
      (1.0 - tmpvar_3.x)
     * 
      (_TintColor.x - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    tmpvar_10.yzw = origCol_8.yzw;
    tmpvar_10.x = (origCol_8.x - ((origCol_8.x * 
      (0.5 - _TintColor.x)
    ) * 2.0));
    origCol_8 = tmpvar_10;
  };
  if ((_TintColor.y > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11.xzw = origCol_8.xzw;
    tmpvar_11.y = (origCol_8.y + ((
      (1.0 - origCol_8.y)
     * 
      (_TintColor.y - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_11;
  } else {
    lowp vec4 tmpvar_12;
    tmpvar_12.xzw = origCol_8.xzw;
    tmpvar_12.y = (origCol_8.y - ((origCol_8.y * 
      (0.5 - _TintColor.y)
    ) * 2.0));
    origCol_8 = tmpvar_12;
  };
  if ((_TintColor.z > 0.5)) {
    lowp vec4 tmpvar_13;
    tmpvar_13.xyw = origCol_8.xyw;
    tmpvar_13.z = (origCol_8.z + ((
      (1.0 - origCol_8.z)
     * 
      (_TintColor.z - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_13;
  } else {
    lowp vec4 tmpvar_14;
    tmpvar_14.xyw = origCol_8.xyw;
    tmpvar_14.z = (origCol_8.z - ((origCol_8.z * 
      (0.5 - _TintColor.z)
    ) * 2.0));
    origCol_8 = tmpvar_14;
  };
  if ((_TintColor.w > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15.xyz = origCol_8.xyz;
    tmpvar_15.w = (origCol_8.w + ((
      (1.0 - origCol_8.w)
     * 
      (_TintColor.w - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_15;
  } else {
    lowp vec4 tmpvar_16;
    tmpvar_16.xyz = origCol_8.xyz;
    tmpvar_16.w = (origCol_8.w - ((origCol_8.w * 
      (0.5 - _TintColor.w)
    ) * 2.0));
    origCol_8 = tmpvar_16;
  };
  gl_FragData[0] = origCol_8;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixV[0].xyz;
  tmpvar_3[1] = unity_MatrixV[1].xyz;
  tmpvar_3[2] = unity_MatrixV[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((tmpvar_3 * 
    normalize((_glesNormal * tmpvar_2))
  ).xy * 0.5) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MatCap, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  lowp vec4 capCol_4;
  capCol_4 = tmpvar_2;
  lowp float ratio_5;
  lowp float tmpvar_6;
  tmpvar_6 = ((tmpvar_1.x + tmpvar_1.y) + tmpvar_1.z);
  lowp float tmpvar_7;
  tmpvar_7 = ((tmpvar_2.x + tmpvar_2.y) + tmpvar_2.z);
  if ((((tmpvar_6 - 2.0) > 0.0) && ((tmpvar_7 - 2.0) > 0.0))) {
    ratio_5 = (tmpvar_6 - 2.0);
    capCol_4.xyz = ((vec3(0.5, 0.5, 0.5) * ratio_5) + (tmpvar_2 * (1.0 - ratio_5)).xyz);
  };
  tmpvar_3 = ((tmpvar_1 * capCol_4) * 2.0);
  lowp vec4 origCol_8;
  origCol_8 = tmpvar_3;
  if ((_TintColor.x > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9.yzw = tmpvar_3.yzw;
    tmpvar_9.x = (tmpvar_3.x + ((
      (1.0 - tmpvar_3.x)
     * 
      (_TintColor.x - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    tmpvar_10.yzw = origCol_8.yzw;
    tmpvar_10.x = (origCol_8.x - ((origCol_8.x * 
      (0.5 - _TintColor.x)
    ) * 2.0));
    origCol_8 = tmpvar_10;
  };
  if ((_TintColor.y > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11.xzw = origCol_8.xzw;
    tmpvar_11.y = (origCol_8.y + ((
      (1.0 - origCol_8.y)
     * 
      (_TintColor.y - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_11;
  } else {
    lowp vec4 tmpvar_12;
    tmpvar_12.xzw = origCol_8.xzw;
    tmpvar_12.y = (origCol_8.y - ((origCol_8.y * 
      (0.5 - _TintColor.y)
    ) * 2.0));
    origCol_8 = tmpvar_12;
  };
  if ((_TintColor.z > 0.5)) {
    lowp vec4 tmpvar_13;
    tmpvar_13.xyw = origCol_8.xyw;
    tmpvar_13.z = (origCol_8.z + ((
      (1.0 - origCol_8.z)
     * 
      (_TintColor.z - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_13;
  } else {
    lowp vec4 tmpvar_14;
    tmpvar_14.xyw = origCol_8.xyw;
    tmpvar_14.z = (origCol_8.z - ((origCol_8.z * 
      (0.5 - _TintColor.z)
    ) * 2.0));
    origCol_8 = tmpvar_14;
  };
  if ((_TintColor.w > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15.xyz = origCol_8.xyz;
    tmpvar_15.w = (origCol_8.w + ((
      (1.0 - origCol_8.w)
     * 
      (_TintColor.w - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_15;
  } else {
    lowp vec4 tmpvar_16;
    tmpvar_16.xyz = origCol_8.xyz;
    tmpvar_16.w = (origCol_8.w - ((origCol_8.w * 
      (0.5 - _TintColor.w)
    ) * 2.0));
    origCol_8 = tmpvar_16;
  };
  gl_FragData[0] = origCol_8;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_MatrixV[0].xyz;
  tmpvar_3[1] = unity_MatrixV[1].xyz;
  tmpvar_3[2] = unity_MatrixV[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((tmpvar_3 * 
    normalize((_glesNormal * tmpvar_2))
  ).xy * 0.5) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MatCap, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  lowp vec4 capCol_4;
  capCol_4 = tmpvar_2;
  lowp float ratio_5;
  lowp float tmpvar_6;
  tmpvar_6 = ((tmpvar_1.x + tmpvar_1.y) + tmpvar_1.z);
  lowp float tmpvar_7;
  tmpvar_7 = ((tmpvar_2.x + tmpvar_2.y) + tmpvar_2.z);
  if ((((tmpvar_6 - 2.0) > 0.0) && ((tmpvar_7 - 2.0) > 0.0))) {
    ratio_5 = (tmpvar_6 - 2.0);
    capCol_4.xyz = ((vec3(0.5, 0.5, 0.5) * ratio_5) + (tmpvar_2 * (1.0 - ratio_5)).xyz);
  };
  tmpvar_3 = ((tmpvar_1 * capCol_4) * 2.0);
  lowp vec4 origCol_8;
  origCol_8 = tmpvar_3;
  if ((_TintColor.x > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9.yzw = tmpvar_3.yzw;
    tmpvar_9.x = (tmpvar_3.x + ((
      (1.0 - tmpvar_3.x)
     * 
      (_TintColor.x - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    tmpvar_10.yzw = origCol_8.yzw;
    tmpvar_10.x = (origCol_8.x - ((origCol_8.x * 
      (0.5 - _TintColor.x)
    ) * 2.0));
    origCol_8 = tmpvar_10;
  };
  if ((_TintColor.y > 0.5)) {
    lowp vec4 tmpvar_11;
    tmpvar_11.xzw = origCol_8.xzw;
    tmpvar_11.y = (origCol_8.y + ((
      (1.0 - origCol_8.y)
     * 
      (_TintColor.y - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_11;
  } else {
    lowp vec4 tmpvar_12;
    tmpvar_12.xzw = origCol_8.xzw;
    tmpvar_12.y = (origCol_8.y - ((origCol_8.y * 
      (0.5 - _TintColor.y)
    ) * 2.0));
    origCol_8 = tmpvar_12;
  };
  if ((_TintColor.z > 0.5)) {
    lowp vec4 tmpvar_13;
    tmpvar_13.xyw = origCol_8.xyw;
    tmpvar_13.z = (origCol_8.z + ((
      (1.0 - origCol_8.z)
     * 
      (_TintColor.z - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_13;
  } else {
    lowp vec4 tmpvar_14;
    tmpvar_14.xyw = origCol_8.xyw;
    tmpvar_14.z = (origCol_8.z - ((origCol_8.z * 
      (0.5 - _TintColor.z)
    ) * 2.0));
    origCol_8 = tmpvar_14;
  };
  if ((_TintColor.w > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15.xyz = origCol_8.xyz;
    tmpvar_15.w = (origCol_8.w + ((
      (1.0 - origCol_8.w)
     * 
      (_TintColor.w - 0.5)
    ) * 2.0));
    origCol_8 = tmpvar_15;
  } else {
    lowp vec4 tmpvar_16;
    tmpvar_16.xyz = origCol_8.xyz;
    tmpvar_16.w = (origCol_8.w - ((origCol_8.w * 
      (0.5 - _TintColor.w)
    ) * 2.0));
    origCol_8 = tmpvar_16;
  };
  gl_FragData[0] = origCol_8;
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
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 129287
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp float _Outline;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 normal_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = tmpvar_2.xyz;
  tmpvar_7[1] = tmpvar_3.xyz;
  tmpvar_7[2] = tmpvar_4.xyz;
  normal_6.xy = (tmpvar_7 * _glesNormal).xy;
  normal_6.z = -1.0;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = normalize(normal_6);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * _glesVertex) + (tmpvar_8 * _Outline)));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform highp float _Outline;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Outline != 0.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  };
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp float _Outline;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 normal_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = tmpvar_2.xyz;
  tmpvar_7[1] = tmpvar_3.xyz;
  tmpvar_7[2] = tmpvar_4.xyz;
  normal_6.xy = (tmpvar_7 * _glesNormal).xy;
  normal_6.z = -1.0;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = normalize(normal_6);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * _glesVertex) + (tmpvar_8 * _Outline)));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform highp float _Outline;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Outline != 0.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  };
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp float _Outline;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 normal_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = tmpvar_2.xyz;
  tmpvar_7[1] = tmpvar_3.xyz;
  tmpvar_7[2] = tmpvar_4.xyz;
  normal_6.xy = (tmpvar_7 * _glesNormal).xy;
  normal_6.z = -1.0;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = normalize(normal_6);
  gl_Position = (glstate_matrix_projection * ((
    (unity_MatrixV * unity_ObjectToWorld)
   * _glesVertex) + (tmpvar_8 * _Outline)));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
}


#endif
#ifdef FRAGMENT
uniform highp float _Outline;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Outline != 0.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  };
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
}
}
}
Fallback "Avalon2/Basic"
}