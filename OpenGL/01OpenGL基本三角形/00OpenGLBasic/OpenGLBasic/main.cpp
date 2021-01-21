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
    GLfloat vRed[] = {1.0, 1.0, 1.0, 1.0};
    
    shaderManager.UseStockShader(GLT_SHADER_IDENTITY, vRed);
    
    triangleBatch.Draw();
    ///  前后台 双层 缓冲, 后台渲染  前台展示
    glutSwapBuffers();
}


void setupRC() {
    
    /// bgColor
    glClearColor(0.98f, 0.40f, 0.7f, 1);

    /// 着色器是渲染的必须
    shaderManager.InitializeStockShaders();
    
    ///三角形三顶点
    GLfloat vVerts[] = {
        -0.5f, 0.0f, 0.0f,
        0.5f, 0.0f, 0.0,
        0.0f, 0.5f, 0.0f
    };
    
    triangleBatch.Begin(GL_TRIANGLES, 3);
    triangleBatch.CopyVertexData3f(vVerts);
    triangleBatch.End();
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

