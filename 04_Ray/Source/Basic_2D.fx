// ---------------------------------------------------------
// Basic_2D.fx
// Simple2D着色器
// ---------------------------------------------------------


// 纹理
Texture2D Tex2D : register( t0 );		// 纹理

// 纹理采样
SamplerState MeshTextureSampler : register( s0 )
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};

// 常数缓冲
cbuffer cbNeverChanges : register( b0 )
{
    matrix View;
};


// VertexShader入力形式
struct VS_INPUT {
    float4 v4Position	: POSITION;		// 位置
    float4 v4Color		: COLOR;		// 颜色
    float2 v2Tex		: TEXTURE;		// 纹理坐标
};

// VertexShader输出形式
struct VS_OUTPUT {
    float4 v4Position	: SV_POSITION;	// 位置
    float4 v4Color		: COLOR;		// 颜色
    float2 v2Tex		: TEXTURE;		// 纹理坐标
};

// 顶点着色器
VS_OUTPUT VS( VS_INPUT Input )
{
    VS_OUTPUT	Output;

    Output.v4Position = mul( Input.v4Position, View );
    Output.v4Color = Input.v4Color;
    Output.v2Tex = Input.v2Tex;

    return Output;
}

// 像素着色器
float4 PS( VS_OUTPUT Input ) : SV_TARGET {
    return Tex2D.Sample( MeshTextureSampler, Input.v2Tex ) * Input.v4Color;
}
