//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/NewUnlitShader" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Angle ("Angle", Range(0, 6.283185)) = 0
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 25408
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_EXP2" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _Angle;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float y_1;
  lowp float x_2;
  lowp vec4 col_3;
  col_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp float tmpvar_4;
  tmpvar_4 = (sin(_Angle) / cos(_Angle));
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.x - 0.75);
  x_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0.y - 0.75);
  y_1 = tmpvar_6;
  if ((_Angle < 1.570796)) {
    if (((y_1 < (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
      col_3.w = 0.0;
    };
  } else {
    if ((_Angle < 3.141593)) {
      if (((y_1 > (tmpvar_4 * x_2)) || (y_1 > 0.0))) {
        col_3.w = 0.0;
      };
    } else {
      if ((_Angle < 4.712389)) {
        if (((y_1 > (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      } else {
        if (((y_1 < (tmpvar_4 * x_2)) && (y_1 > 0.0))) {
          col_3.w = 0.0;
        };
      };
    };
  };
  gl_FragData[0] = col_3;
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