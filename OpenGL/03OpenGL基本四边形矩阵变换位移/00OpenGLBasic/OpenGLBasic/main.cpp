//
//  main.cpp
//  OpenGLBasic
//
//  Created by zhangyu on 2021/1/20.
//


/// 着色管理器
#include "GLShaderManager.h"

#include "GLTools.h"

#include <GLUT/GLUT.h>

GLShaderManager shaderManager;
/// 批次容器, from GLTools
GLBatch triangleBatch;

GLfloat blockSize = 0.1f;

//x&y
GLfloat xPos = 0.0f;
GLfloat yPos = 0.0f;

/// 四顶点
GLfloat vVerts[] = {
    -blockSize, -blockSize, 0.0f,
    blockSize, -blockSize, 0.0f,
    blockSize, blockSize, 0.0f,
    -blockSize, blockSize, 0.0f
};


void changeSize(int w, int h) {
    
    /// x y width height
    glViewport(0, 0, w, h);
}

/// 要显示glut必须实现此方法
void RenderScene(void){
    
    /// 清除缓存区
    /// 颜色缓存区 深度缓存区 模板缓存区
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    
    ///rgba
    GLfloat vColor[] = {1.0, 1.0, 1.0, 1.0};
    
    /// 44矩阵 在常见的22矩阵中 加入了 平移和缩放
    /// 平移 最终 旋转
    M3DMatrix44f mTransfromMatrix, mFinalTransform, mRotationMatix;
    
    ///平移  m  x y z
    /// inline void m3dTranslationMatrix44(M3DMatrix44f m, float x, float y, float z)
    m3dTranslationMatrix44(mTransfromMatrix, xPos, yPos, 0.0f);
    
    m3dMatrixMultiply44(mFinalTransform, mTransfromMatrix, mRotationMatix);

    
    ///GLT_SHADER_FLAT平面着色器  区别于之前使用过的单元着色器  IDENTITY
    shaderManager.UseStockShader(GLT_SHADER_FLAT, mTransfromMatrix,vColor);
    
    triangleBatch.Draw();
    ///  前后台 双层 缓冲, 后台渲染  前台展示
    glutSwapBuffers();
}


void setupRC() {
    
    /// bgColor
    glClearColor(0.98f, 0.40f, 0.7f, 1);

    /// 着色器是渲染的必须
    shaderManager.InitializeStockShaders();
    

    triangleBatch.Begin(GL_TRIANGLE_FAN, 4);
    triangleBatch.CopyVertexData3f(vVerts);
    triangleBatch.End();
}

void SpecialKeys(int key, int x, int y) {
    
    /// 步长
    GLfloat stepSize = 0.025f;

    
   
    
    if (key == GLUT_KEY_UP) {
        yPos += stepSize;
    } else if (key == GLUT_KEY_DOWN) {
        yPos -= stepSize;
    } else if (key == GLUT_KEY_LEFT) {
        xPos -= stepSize;
    } else if (key == GLUT_KEY_RIGHT) {
        xPos += stepSize;
    }
    
    ///边界处理
    if (xPos < -1.0f + blockSize) {
        xPos = -1.0f + blockSize;
    }
    
    if (xPos > 1.0f - blockSize) {
        xPos = 1.0f - blockSize;
    }
    
    if (yPos < -1.0f + blockSize) {
        yPos = -1.0f + blockSize;
    }
    
    if (yPos > 1.0f - blockSize) {
        yPos = 1.0f - blockSize;
    }
    
    
    glutPostRedisplay();
}


int main(int argc,char *argv[])
{
    
    /// mac设置
    gltSetWorkingDirectory(argv[0]);
    
    /// 初始化GLUT -> GLUT，是指OpenGL Utility Toolkit，用于开发独立于窗口系统的OpenGL程序
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH | GLUT_STENCIL);
    glutInitWindowSize(800, 600);
    glutCreateWindow("Triangle");
    
    /*
     GLUT 内部运行一个本地消息循环，拦截适当的消息。然后调用我们不同时间注册的回调函数。我们一共注册2个回调函数：
     1）为窗口改变大小而设置的一个回调函数
     2）包含OpenGL 渲染的回调函数
     */
    
    glutReshapeFunc(changeSize);
    glutDisplayFunc(RenderScene);
    
    /// 注册特殊函数
    glutSpecialFunc(SpecialKeys);
    
    GLenum status = glewInit();
    if (GLEW_OK != status) {
        printf("GLEW OpenGL扩展库不可用, 错误:%s \n", glewGetErrorString(status));
        return 1;
    }
    
    ///渲染
    setupRC();
    
    /// glut run loop
    glutMainLoop();
    
    return  0;
}

