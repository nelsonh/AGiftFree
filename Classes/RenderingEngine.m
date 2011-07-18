//
//  RnderingEngine.m
//  OpenGL
//
//  Created by Nelson on 1/28/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "RenderingEngine.h"
#import "WavefrontObj.h"
#import "GLView.h"



@implementation RenderingEngine



-(void)createWavefrontObj:(NSString*)objName
{
	NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *fileDirPath=[domainPaths objectAtIndex:0];
	
	NSString *fullName=[objName stringByAppendingString:@".obj"];
	NSString *path=[fileDirPath stringByAppendingPathComponent:fullName];
	objectToShow=[[WavefrontObj alloc] initWithPath:path];
	Vertex3D position;
	position.x=0.0;
	position.y=0.0;
	position.z=0.0;
	objectToShow.currentPosition=position;
}

-(void)set3DObjectToShowForName:(NSString*)name
{
	if(name!=nil)
	{
		if(objectToShow!=nil)
		{
			[objectToShow release];
			objectToShow=nil;
		}
		
		//create object
		[self createWavefrontObj:name];
	}
}

-(void)setupPerspectiveNear:(float)pnear far:(float)pfar viewWidth:(float)width viewHeight:(float)height
{
	
	float size = pnear * tanf(DEGREES_TO_RADIANS(60) / 2.0);
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glFrustumf(-size, size, -size/(width/height), size/(width/height), pnear, pfar);
	//NSLog(@"bound :%f",width);
	//NSLog(@"bound :%f",height);
	//NSLog(@"size :%f",size);
	glViewport(0, 0, width, height);
	 
}

-(id)initRenderingEngineWithRenderingFrame:(CGRect)renderingFrame EnableDepthBuffer:(BOOL)yesOrNo Controller:(id)viewController
{
	initilized=NO;
	
	modelScale=1.0;
	
	zCam=ZCameMax;
	
	renderFrame=renderingFrame;
	
	//create GLView
	renderingView=[[GLView alloc] initWithFrame:renderingFrame];
	[renderingView setOwner:self];
	[renderingView setDelegate:viewController];
	
	//generate render and frame buffer
	glGenRenderbuffersOES(1, &renderBuffer);
	glGenFramebuffersOES(1, &frameBuffer);
	
	//binding render and frame buffer
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer);
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, frameBuffer);
	
	if(renderingView.renderingContext==nil || renderingView.eaglLayer==nil)
	{
		NSLog(@"context or layer passed in is nil");
		return NO;
	}
	
	[renderingView.renderingContext renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:renderingView.eaglLayer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, renderBuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backHeight);	
	
	if(yesOrNo==YES)
	{
		glEnable(GL_DEPTH_TEST);	
		useDepthBuffer=yesOrNo;
		
		glGenRenderbuffersOES(1, &depthRenderBuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderBuffer);
		glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backWidth, backHeight);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderBuffer);
		
	}

	
	[self setupPerspectiveNear:0.1 far:1000 viewWidth:renderingFrame.size.width viewHeight:renderingFrame.size.height];
	
	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) !=GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"framebuffer not complete %x",glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	
	initilized=YES;
	
	
	//add renderingView(GLView) to provided view
	[renderingView setOpaque:NO];
	[renderingView setAlpha:1.0f];
	[renderingView setHidden:NO];
	[renderingView setBackgroundColor:[UIColor clearColor]];
	
	UIViewController *controller=viewController;
	[controller.view addSubview:renderingView];
	
	return self;


}

-(void)setModelRotationAngle:(float)angle xAxis:(float)x yAxis:(float)y zAxis:(float)z
{
	//apply to model rotation tracker to track angle
	if(x>0)
		modelRotTracker.xAngle=angle;
	if(y>0)
		modelRotTracker.yAngle=angle;
	if(z>0)
		modelRotTracker.zAngle=angle;
	

	
	//NSLog(@"tracker:%f",modelRotTracker.zAngle);
	
	//set new model rot
	if(x>0)
	{
		modelRot.xAngle=angle;
		modelRot.xAxis=x;
	}
	
	if(y>0)
	{
		modelRot.yAngle=angle;
		modelRot.yAxis=y;
	}
	
	if(z>0)
	{
		modelRot.zAngle=angle;
		modelRot.zAxis=z;
	}
	
	
}

-(void)CamZoom:(float)value
{
	zCam+=value;
	
	if(zCam>ZCameZoomInMax)
	{
		zCam=ZCameZoomInMax;
	}
	else if(zCam<ZCameMax)
	{
		zCam=ZCameMax;
	}
}

-(void)SetScale:(float)value
{
	modelScale+=value;
	
	if(modelScale<1.0)
	{
		modelScale=1.0;
	}
	else if(modelScale>2.0)
	{
		modelScale=2.0;
	}
}

-(void)render
{
	 
	[self startOneFrameRender];
	
	//light
	static GLfloat lightPosition[] = {0.0, 5.0, 0.0, 1.0};
	static GLfloat lightPosition1[]= {0.0, 1.0, 5.0, 1.0};
	static GLfloat lightDefuse[] = { 1.0, 1.0, 1.0, 1.0};
	static GLfloat lightAmbient[] = { 1.0, 1.0, 1.0, 1.0};
	static GLfloat lightSpecular[] = {0.7, 0.7, 0.7, 1.0};
	static GLfloat lightShininess = 100.0;

	 glEnable( GL_LIGHTING);
	 
	 glEnable( GL_LIGHT0);
	 glLightfv( GL_LIGHT0, GL_DIFFUSE, lightDefuse);
	 glLightfv( GL_LIGHT0, GL_AMBIENT, lightAmbient);
	 glLightfv(GL_LIGHT0, GL_SPECULAR, lightSpecular);
	 glLightfv( GL_LIGHT0, GL_POSITION, lightPosition);
	 glLightfv(GL_LIGHT0, GL_SHININESS, &lightShininess);
	 
	 glEnable(GL_LIGHT1);
	 glLightfv( GL_LIGHT1, GL_DIFFUSE, lightDefuse);
	 glLightfv( GL_LIGHT1, GL_AMBIENT, lightAmbient);
	 glLightfv(GL_LIGHT1, GL_SPECULAR, lightSpecular);
	 glLightfv( GL_LIGHT1, GL_POSITION, lightPosition1);
	 glLightfv(GL_LIGHT1, GL_SHININESS, &lightShininess);


	
	//camera
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glTranslatef(0.0, YCam, zCam);
	

	
	//wavefront obj
	//[exampleWavefrontObj SetRotationAngle:modelRot.angle xAxis:modelRot.xAxis yAxis:modelRot.yAxis zAxis:modelRot.zAxis];
	//[exampleWavefrontObj SetScale:modelScale];
	
	if(objectToShow!=nil)
	{
		[objectToShow SetRotationXAngle:modelRot.xAngle yAngle:modelRot.yAngle zAngle:modelRot.zAngle];
		[objectToShow renderSelf];
	}
	
	//glDisable( GL_LIGHT0);
	//glDisable(GL_LIGHT1);
	//glDisable( GL_LIGHTING);
	
	[self endOneFrameRender];
}

-(void)startOneFrameRender
{
	glClearColor( 0.0, 0.0, 0.0, 0.0);
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

-(void)endOneFrameRender
{
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, renderBuffer);
	[renderingView.renderingContext presentRenderbuffer:GL_RENDERBUFFER_OES];
}

-(void)startRender
{
	renderTimer=[NSTimer scheduledTimerWithTimeInterval:kFPS target:self selector:@selector(render) userInfo:nil repeats:YES];
}

-(void)stopRender
{
	if(renderTimer)
	{
		[renderTimer invalidate];
		renderTimer=nil;
	}
}

-(void)updateAnimationWithTimeStep:(float)timeStep
{
}

-(BOOL)isInitilized
{
	return initilized;
}



-(void)destroyAll
{
	[self stopRender];
	[self destroyFrameRenderBuffer];
}

-(void)destroyFrameRenderBuffer
{
	if(frameBuffer)
	{
		glDeleteFramebuffersOES(1, &frameBuffer);
		frameBuffer=0;
	}
	
	if(renderBuffer)
	{
		glDeleteRenderbuffersOES(1, &renderBuffer);
		renderBuffer=0;
	}
	
	if(depthRenderBuffer)
	{
		glDeleteRenderbuffersOES(1, &depthRenderBuffer);
		depthRenderBuffer=0;
	}
}

-(void)resetContext
{
	[EAGLContext setCurrentContext:renderingView.renderingContext];
}



-(void)dealloc
{

	[renderingView removeFromSuperview];
	[self destroyAll];
	[objectToShow release];

	[super dealloc];
}

@end
