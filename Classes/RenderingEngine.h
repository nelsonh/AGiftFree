//
//  RnderingEngine.h
//  OpenGL
//
//  Created by Nelson on 1/28/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>
#import "GLView.h"



#define ZCameMax -3.0
#define ZCameZoomInMax -1.0
#define YCam -0.7
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
#define kFPS 1.0/30.0

typedef struct modelRotation 
{
	float xAngle;
	float yAngle;
	float zAngle;
	float xAxis;
	float yAxis;
	float zAxis;
	
}ModelRot;

typedef struct modelRotationTracker
{
	float xAngle;
	float yAngle;
	float zAngle;
	
}ModelRotTracker;


@class WavefrontObj;

@interface RenderingEngine : NSObject {
	
	BOOL initilized;
	BOOL useDepthBuffer;
	GLuint renderBuffer;
	GLuint frameBuffer;
	GLuint depthRenderBuffer;
	GLint backWidth;
	GLint backHeight;

	NSTimer *renderTimer;
	GLView *renderingView;
	
	WavefrontObj *objectToShow;
	
	ModelRot modelRot;
	ModelRotTracker modelRotTracker;
	float modelScale;
	
	float zCam;
	
	CGRect renderFrame;
}

-(void)setupPerspectiveNear:(float)pnear far:(float)pfar viewWidth:(float)width viewHeight:(float)height;
-(id)initRenderingEngineWithRenderingFrame:(CGRect)renderingFrame EnableDepthBuffer:(BOOL)yesOrNo Controller:(id)viewController;
-(void)render;
-(void)startOneFrameRender;
-(void)endOneFrameRender;
-(void)startRender;
-(void)stopRender;
-(void)updateAnimationWithTimeStep:(float)timeStep;
-(void)destroyAll;
-(void)destroyFrameRenderBuffer;
-(BOOL)isInitilized;
-(void)set3DObjectToShowForName:(NSString*)name;
-(void)createWavefrontObj:(NSString*)objName;
-(void)setModelRotationAngle:(float)angle xAxis:(float)x yAxis:(float)y zAxis:(float)z;
-(void)SetScale:(float)value;
-(void)CamZoom:(float)value;
-(void)resetContext;

@end
