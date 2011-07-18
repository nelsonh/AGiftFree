//
//  GLView.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>

#define RADIANS_TO_DEGREES(__RADIANS__) ((__RADIANS__) * 180.0 / M_PI)


@protocol GLViewDelegate;

@class RenderingEngine;

@interface GLView : UIView {
	
	EAGLContext *renderingContext;
	CAEAGLLayer *eaglLayer;
	
	//a reference to rendering engine that own this view
	RenderingEngine *owner;
	
	float timeStep;
	CGPoint lastTouchLoc;
	CGPoint lastAmountMovement;
	CGFloat initialDist;
	
	//delegate target
	id<GLViewDelegate> delegate;

}

@property (nonatomic, retain) RenderingEngine *owner;
@property (nonatomic, retain) EAGLContext *renderingContext;
@property (nonatomic, retain) CAEAGLLayer *eaglLayer;
@property (nonatomic, assign) id<GLViewDelegate> delegate;

-(CGFloat)distBetweenPoints:(CGPoint)firstPoint secPoint:(CGPoint)secondPoint;
-(void)pinchHandler:(UIPinchGestureRecognizer*)sender;

@end

@protocol GLViewDelegate<NSObject>
@optional

-(void)glView:(GLView*)glView withTapCount:(NSUInteger)tapCount;


@end

