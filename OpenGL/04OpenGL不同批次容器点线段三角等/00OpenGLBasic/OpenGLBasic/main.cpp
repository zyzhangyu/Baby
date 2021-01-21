//
//  main.cpp
//  OpenGLBasic
//  04 图元
//  Created by zhangyu on 2021/1/20.
//  实现功能:
//      展示六中图形


/// 着色管理器
#include "GLShaderManager.h"
/// 矩阵堆栈
#include "GLMatrixStack.h"
#include "GLFrame.h"
/// 投影矩阵    立体锥
#include "GLFrustum.h"
#include "GLTools.h"
#include "GLBatch.h"
#include "GLGeometryTransform.h"

#include <math.h>
#include <GLUT/GLUT.h>


/*
    GLMatrixStack 变化管线会使用矩阵堆栈
    GLMatrixStack
        构造函数允许指定堆栈的最大深度, 默认的堆栈深度为64.
        这个矩阵堆在初始化时已经在堆栈中包含了单位矩阵.
    GLMatrixStack:: GLMatrixStack(init iStackDepth = 64);

    //通过调用顶部载入一个单位矩阵
    void GLMatrixStack::LoadIndentiy(void);
    //在堆栈顶部载入任何矩阵
    void GLMatrixStack::LoadMatrix(const M3DMatrix44f m);
*/

/// 着色管理器  shader 见名知意
GLShaderManager shaderManager;

/// 矩阵堆栈 - 模型
GLMatrixStack modelViewMatrix;
/// 矩阵堆栈 - 投影
GLMatrixStack projectionMatrix;

/// 一个观察者的 frame
GLFrame cameraFrame;

/// 一个对象的frame
GLFrame objectFrame;

/// 投影矩阵 观察者的视角与可视范围
GLFrustum viewFrustum;


/// 各种批次容器类  -点 -线
GLBatch pointBatch;
GLBatch lineBatch;
GLBatch lineStripBatch; /// ???
GLBatch lineLoopBatch;  /// ???
GLBatch triangleBatch; /// ???
GLBatch triangleStripBatch; /// ???
GLBatch triangleFanBatch; /// ???

/// 几何变换的管道
GLGeometryTransform transformPipeline;
M3DMatrix44f shadowMatrix;

/// 绿色
GLfloat vGreen[] = {0.0f, 1.0f, 0.0f, 1.0f};
/// 黑色
GLfloat vBlack[] = {0.0f, 0.0f, 0.0f, 1.0f};

//跟踪效果步骤
int nStep = 0;

// 此函数在呈现上下文中进行任何必要的初始化
// 这是第一次做任何与opengl相关的任务
void setupRC() {
    
    /// bgColor
    glClearColor(0.55f, 0.40f, 0.7f, 1);

    /// 管理着色器 初始化
    shaderManager.InitializeStockShaders();
    
    /// 开启深度测试 暂时不用理解
    glEnable(GL_DEPTH_TEST);
    
    /// 设置变化管线 用来使用 上面的两个矩阵堆栈   - 模型 投影两个
    transformPipeline.SetMatrixStacks(modelViewMatrix, projectionMatrix);
    
    ///观察者在的位置
    cameraFrame.MoveForward(-20.0f);
    
    
    /*
        常见函数:
     void GLBatch::Begin(Glenum primitive, GLuint nVerts, Gluint nTextureUnits = 0);
     参数1: 表示使用的图元
     参数2: 顶点数
     参数3: 纹理坐标(可选)
     
     //负责顶点坐标
     void GLBatch::CopyVertexData3f(GLFloat *vNorms);
     
     //结束,表示已经完成数据复制工作
     void GLBatch::End(void);
     */
    
     
    //定义一些点，类似佛罗里达州的形状。  24个点 每个点xyz3轴
    GLfloat vCoast[24][3] = {
        {2.80, 1.20, 0.0 }, {2.0,  1.20, 0.0 },
        {2.0,  1.08, 0.0 },  {2.0,  1.08, 0.0 },
        {0.0,  0.80, 0.0 },  {-.32, 0.40, 0.0 },
        {-.48, 0.2, 0.0 },   {-.40, 0.0, 0.0 },
        {-.60, -.40, 0.0 },  {-.80, -.80, 0.0 },
        {-.80, -1.4, 0.0 },  {-.40, -1.60, 0.0 },
        {0.0, -1.20, 0.0 },  { .2, -.80, 0.0 },
        {.48, -.40, 0.0 },   {.52, -.20, 0.0 },
        {.48,  .20, 0.0 },   {.80,  .40, 0.0 },
        {1.20, .80, 0.0 },   {1.60, .60, 0.0 },
        {2.0, .60, 0.0 },    {2.2, .80, 0.0 },
        {2.40, 1.0, 0.0 },   {2.80, 1.0, 0.0 }};

    ///用线的形式 - 表示佛罗里达州的形状
    pointBatch.Begin(GL_POINTS, 24);
    pointBatch.CopyVertexData3f(vCoast);
    pointBatch.End();
    
    
    ///通过线的形式 --- 表示佛罗里达州的形状
    lineBatch.Begin(GL_LINES, 24);
    lineBatch.CopyVertexData3f(vCoast);
    lineBatch.End();
    
    ///通过线段的方式 -- 表示佛罗里达州的形状
    lineStripBatch.Begin(GL_LINE_STRIP, 24);
    lineStripBatch.CopyVertexData3f(vCoast);
    lineStripBatch.End();
    
    ///通过环线的方式 --- 表示佛罗里达州的形状
    lineLoopBatch.Begin(GL_LINE_LOOP, 24);
    lineLoopBatch.CopyVertexData3f(vCoast);
    lineLoopBatch.End();
    
    
    ///通过三角形创建金字塔  4个三角形  每个三角形 三个顶点
    GLfloat vPyramid[12][3] = {
        -2.0f, 0.0f, -2.0f,
        2.0f, 0.0f, -2.0f,
        0.0f, 4.0f, 0.0f,
        
        2.0f, 0.0f, -2.0f,
        2.0f, 0.0f, 2.0f,
        0.0f, 4.0f, 0.0f,
        
        2.0f, 0.0f, 2.0f,
        -2.0f, 0.0f, 2.0f,
        0.0f, 4.0f, 0.0f,
        
        -2.0f, 0.0f, 2.0f,
        -2.0f, 0.0f, -2.0f,
        0.0f, 4.0f, 0.0f};
    
    
    ///GL_TRIANGLES 每3个顶点定义一个新的三角形
    triangleBatch.Begin(GL_TRIANGLES, 12);
    triangleBatch.CopyVertexData3f(vPyramid);
    triangleBatch.End();
    
    
    /// 三角形扇形 --- 六边形   ///超过我们需要的数组
    GLfloat vPoints[100][3];
    int nVerts = 0;
    ///半径
    GLfloat r = 3.0f;
    
    ///原点 xyz = 000
    vPoints[nVerts][0] = 0.0f;
    vPoints[nVerts][1] = 0.0f;
    vPoints[nVerts][2] = 0.0f;
    
    ///M3D_2PI 就是2Pi的意思 , 就是一个圆的意思. 绘制圆形
    for (GLfloat angle = 0; angle < M3D_2PI; angle += M3D_2PI / 6.0f) {
        
        ///数组下标自增(每自增1就表示一个顶点)
        nVerts++;
        /*
         弧长=半径*角度,这里的角度是弧度制,不是平时的角度制
         既然知道了cos值, 那么角度=arc cos,求一个反三角函数就行了
         */
        /// x点的坐标 cos(angle) * 半径
        vPoints[nVerts][0] = floor(cos(angle)) * r;
        /// y点的坐标 sin(angle) *半径
        vPoints[nVerts][1] = float(sin(angle)) * r;
        ///z 点的坐标
        vPoints[nVerts][2] = -0.5f;
    }
    
    ///结束扇形 前面一共绘制了7个顶点 包含圆心
    printf("三角扇形定点数:d%\n", nVerts);
    
    /// 三角扇形 的闭合与否
    nVerts++;
    vPoints[nVerts][0] = r;
    vPoints[nVerts][1] = 0;
    vPoints[nVerts][2] = 0.0f;
    
    /// 加载!
    //  GL_TRIANGLE_FAN以一个圆心为中心呈扇形排列,共用相邻顶点的一组三角形
    triangleFanBatch.Begin(GL_TRIANGLE_FAN, 8);
    triangleFanBatch.CopyVertexData3f(vPoints);
    triangleFanBatch.End();
    
    ///三角形条带, 一个小环或圆柱段
    ///顶点下标
    int iCounter = 0;
    ///半径
    GLfloat radius = 3.0f;
    ///从0度~360°, 以0.3弧度为步长
    for (GLfloat angle = 0.0f; angle < (2.0f * M3D_PI); angle += 0.3f) {
        ///或许原型的顶点的x,y
        GLfloat x = radius * sin(angle);
        GLfloat y = radius * cos(angle);
        
        //绘制2个三角形（他们的x,y顶点一样，只是z点不一样）
        vPoints[iCounter][0] = x;
        vPoints[iCounter][1] = y;
        vPoints[iCounter][2] = -0.5;
        iCounter++;
        
        vPoints[iCounter][0] = x;
        vPoints[iCounter][1] = y;
        vPoints[iCounter][2] = 0.5;
        iCounter++;
    }
    
    // 关闭循环
    printf("三角形带的顶点数：%d\n",iCounter);
    //结束循环，在循环位置生成2个三角形
    vPoints[iCounter][0] = vPoints[0][0];
    vPoints[iCounter][1] = vPoints[0][1];
    vPoints[iCounter][2] = -0.5;
    iCounter++;
    
    vPoints[iCounter][0] = vPoints[1][0];
    vPoints[iCounter][1] = vPoints[1][1];
    vPoints[iCounter][2] = 0.5;
    iCounter++;
    
    // GL_TRIANGLE_STRIP 共用一个条带（strip）上的顶点的一组三角形
    triangleStripBatch.Begin(GL_TRIANGLE_STRIP, iCounter);
    triangleStripBatch.CopyVertexData3f(vPoints);
    triangleStripBatch.End();
}

void DrawWireFramedBatch(GLBatch* pBatch) {
    
    /*------------画绿色部分----------------*/
    /* GLShaderManager 中的Uniform 值——平面着色器
     参数1：平面着色器
     参数2：运行为几何图形变换指定一个 4 * 4变换矩阵
          --transformPipeline 变换管线（指定了2个矩阵堆栈）
     参数3：颜色值
    */
    
    /// 使用平面着色器绘制图形
    shaderManager.UseStockShader(GLT_SHADER_FLAT, transformPipeline.GetModelViewProjectionMatrix(), vGreen);
        
    pBatch->Draw();
    
    
    
    /*-----------边框部分-------------------*/
    /*
        glEnable(GLenum mode); 用于启用各种功能。功能由参数决定
     
        参数列表：http://blog.csdn.net/augusdi/article/details/23747081
        注意：glEnable() 不能写在glBegin() 和 glEnd()中间
        GL_POLYGON_OFFSET_LINE  根据函数glPolygonOffset的设置，启用线的深度偏移
        GL_LINE_SMOOTH          执行后，过虑线点的锯齿
        GL_BLEND                启用颜色混合。例如实现半透明效果
        GL_DEPTH_TEST           启用深度测试 根据坐标的远近自动隐藏被遮住的图形（材料
     
     
        glDisable(GLenum mode); 用于关闭指定的功能 功能由参数决定
     
     */
    
    //画黑色边框
    glPolygonOffset(-1.0f, -1.0f);// 偏移深度，在同一位置要绘制填充和边线，会产生z冲突，所以要偏移
    glEnable(GL_POLYGON_OFFSET_LINE);
    
    // 画反锯齿，让黑边好看些
    glEnable(GL_LINE_SMOOTH);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    //绘制线框几何黑色版 三种模式，实心，边框，点，可以作用在正面，背面，或者两面
    //通过调用glPolygonMode将多边形正面或者背面设为线框模式，实现线框渲染
    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    //设置线条宽度
    glLineWidth(2.5f);
    
    /* GLShaderManager 中的Uniform 值——平面着色器
     参数1：平面着色器
     参数2：运行为几何图形变换指定一个 4 * 4变换矩阵
         --transformPipeline.GetModelViewProjectionMatrix() 获取的
          GetMatrix函数就可以获得矩阵堆栈顶部的值
     参数3：颜色值（黑色）
     */
    
    shaderManager.UseStockShader(GLT_SHADER_FLAT, transformPipeline.GetModelViewProjectionMatrix(), vBlack);
    pBatch->Draw();

    // 复原原本的设置
    ////通过调用glPolygonMode将多边形正面或者背面设为全部填充模式
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    glDisable(GL_POLYGON_OFFSET_LINE);
    glLineWidth(1.0f);
    glDisable(GL_BLEND);
    glDisable(GL_LINE_SMOOTH);
    
}


/// 要显示glut必须实现此方法
void RenderScene(void){
    
    /// 清除缓存区
    /// 颜色缓存区 深度缓存区 模板缓存区
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    
    /// 压栈
    modelViewMatrix.PushMatrix();
    
    ///观察者44矩阵
    M3DMatrix44f mCamera;
    cameraFrame.GetCameraMatrix(mCamera);
    
    //矩阵乘以矩阵堆栈的顶部矩阵，相乘的结果随后简存储在堆栈的顶部
    modelViewMatrix.MultMatrix(mCamera);
    
    M3DMatrix44f mObjectFrame;
    //只要使用 GetMatrix 函数就可以获取矩阵堆栈顶部的值，这个函数可以进行2次重载。用来使用GLShaderManager 的使用。或者是获取顶部矩阵的顶点副本数据
    objectFrame.GetMatrix(mObjectFrame);
    
    //矩阵乘以矩阵堆栈的顶部矩阵，相乘的结果随后简存储在堆栈的顶部
    modelViewMatrix.MultMatrix(mObjectFrame);
    
    /* GLShaderManager 中的Uniform 值——平面着色器
     参数1：平面着色器
     参数2：运行为几何图形变换指定一个 4 * 4变换矩阵
     --transformPipeline.GetModelViewProjectionMatrix() 获取的
     GetMatrix函数就可以获得矩阵堆栈顶部的值
     参数3：颜色值（黑色）
     */
    shaderManager.UseStockShader(GLT_SHADER_FLAT, transformPipeline.GetModelViewProjectionMatrix(), vBlack);
    
    switch(nStep) {
        case 0:
            //设置点的大小
            glPointSize(4.0f);
            pointBatch.Draw();
            glPointSize(1.0f);
            break;
        case 1:
            //设置线的宽度
            glLineWidth(2.0f);
            lineBatch.Draw();
            glLineWidth(1.0f);
            break;
        case 2:
            glLineWidth(2.0f);
            lineStripBatch.Draw();
            glLineWidth(1.0f);
            break;
        case 3:
            glLineWidth(2.0f);
            lineLoopBatch.Draw();
            glLineWidth(1.0f);
            break;
        case 4:
            DrawWireFramedBatch(&triangleBatch);
            break;
        case 5:
            DrawWireFramedBatch(&triangleStripBatch);
            break;
        case 6:
            DrawWireFramedBatch(&triangleFanBatch);
            break;
    }
    
    //还原到以前的模型视图矩阵（单位矩阵）
    modelViewMatrix.PopMatrix();
    
    // 进行缓冲区交换
    glutSwapBuffers();
}



//特殊键位处理（上、下、左、右移动）
void SpecialKeys(int key, int x, int y) {
    
    ///移动物体的两种方式:
    ///  1.修改物体坐标
    ///  2.修改世界坐标系
    
    /// 采用修改世界坐标系的方法 处理上下左右
    if(key == GLUT_KEY_UP)
        //围绕一个指定的X,Y,Z轴旋转。
        ///m3dRadToDeg 弧度 到 度数
        ///m3dDegToRad 度数 到 弧度
        
        /// 渲染  deg角度 变 弧度   旋转-5弧度  在x轴上  就是让世界在x轴上向下走5度
        objectFrame.RotateWorld(m3dDegToRad(-5.0f), 1.0f, 0.0f, 0.0f);
    
    if(key == GLUT_KEY_DOWN)
        objectFrame.RotateWorld(m3dDegToRad(5.0f), 1.0f, 0.0f, 0.0f);
    
    if(key == GLUT_KEY_LEFT)
        objectFrame.RotateWorld(m3dDegToRad(-5.0f), 0.0f, 1.0f, 0.0f);
    
    if(key == GLUT_KEY_RIGHT)
        objectFrame.RotateWorld(m3dDegToRad(5.0f), 0.0f, 1.0f, 0.0f);
    
    glutPostRedisplay();
}

//根据空格次数。切换不同的“窗口名称”
void KeyPressFunc(unsigned char key, int x, int y)
{
    /// key == 32就是空格
    if(key == 32)
    {
        nStep++;
        
        if(nStep > 6)
            nStep = 0;
    }
    
    switch(nStep)
    {
        case 0:
            glutSetWindowTitle("GL_POINTS");
            break;
        case 1:
            glutSetWindowTitle("GL_LINES");
            break;
        case 2:
            glutSetWindowTitle("GL_LINE_STRIP");
            break;
        case 3:
            glutSetWindowTitle("GL_LINE_LOOP");
            break;
        case 4:
            glutSetWindowTitle("GL_TRIANGLES");
            break;
        case 5:
            glutSetWindowTitle("GL_TRIANGLE_STRIP");
            break;
        case 6:
            glutSetWindowTitle("GL_TRIANGLE_FAN");
            break;
    }
    
    ///重新渲染
    glutPostRedisplay();
}



// 窗口已更改大小，或刚刚创建。无论哪种情况，我们都需要
// 使用窗口维度设置视口和投影矩阵.
void ChangeSize(int w, int h)
{
    ///其函数原型为glViewport(GLint x,GLint y,GLsizei width,GLsizei height)
    ///指定了窗口左下角的位置
    ///注意 视口 与 窗口
    glViewport(0, 0, w, h);
    
    
    /// 这是一个透视投影3D  不是2D正投影
    /// 投影矩阵:  视角(决定能见范围)  纵横比 近截面 远截面 (其实就是投影的可见范围)
    viewFrustum.SetPerspective(35.0f, float(w) / float(h), 1.0f, 500.0f);
    
    ///投影矩阵 载入 上面设置好的投影矩阵  project在英语中也有投射的意思
    projectionMatrix.LoadMatrix(viewFrustum.GetProjectionMatrix());
    
    //调用顶部载入单元矩阵
    modelViewMatrix.LoadIdentity();
}


int main(int argc,char *argv[])
{
    /// mac设置 目录
    gltSetWorkingDirectory(argv[0]);
    
    /// glut init
    glutInit(&argc, argv);
    
    //申请一个颜色缓存区、深度缓存区、双缓存区、模板缓存区
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH | GLUT_STENCIL);
    
    //设置window 的尺寸
    glutInitWindowSize(800, 600);
    //创建window的名称
    glutCreateWindow("GL_POINTS");
    
    //注册回调函数（改变尺寸）
    glutReshapeFunc(ChangeSize);
    //点击空格时，调用的函数
    glutKeyboardFunc(KeyPressFunc);
    //特殊键位函数（上下左右）
    glutSpecialFunc(SpecialKeys);
    //显示函数
    glutDisplayFunc(RenderScene);
    
    //判断一下是否能初始化glew库，确保项目能正常使用OpenGL 框架
    GLenum err = glewInit();
    if (GLEW_OK != err) {
        fprintf(stderr, "GLEW Error: %s\n", glewGetErrorString(err));
        return 1;
    }
    
    //绘制
    setupRC();
    //runloop运行循环
    glutMainLoop();
    return 0;
}

