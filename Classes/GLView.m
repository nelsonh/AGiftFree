//
//  GLView.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GLView.h"
#import "mach/mach_time.h"
#import <OpenGLES/ES2/gl.h>
#import "RenderingEngine.h"

@implementation GLView

@synthesize owner;
@synthesize renderingContext;
@synthesize eaglLayer;
@synthesize delegate;

+(Class)layerClass
{
	return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		eaglLayer=(CAEAGLLayer*)self.layer;
		eaglLayer.opaque=YES;
		eaglLayer.drawableProperties=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],
									  kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
									  nil];
		
		//create context with api
		renderingContext=[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
		//check context is created success
		if(!renderingContext || ![EAGLContext setCurrentContext:renderingContext])
		{
			[self release];
			return nil;
		}
		
		UIPinchGestureRecognizer *pinchGesture=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchHandler:)];
		[self addGestureRecognizer:pinchGesture];
		[pinchGesture release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

-(void)pinchHandler:(UIPinchGestureRecognizer*)sender
{
	
	/*
	 if(sender.scale>1)
	 {
	 [owner CamZoom:sender.scale*0.005];
	 }
	 else 
	 {
	 [owner CamZoom:-sender.scale*0.01];
	 }
	 */
	[owner CamZoom:sender.velocity*0.01];
	
}

#pragma mark touch event

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if([[[event allTouches] allObjects] count]==1)
	{
		UITouch *touch=[[event allTouches] anyObject];
		
		CGPoint touchLocation=[touch locationInView:self];
		
		lastTouchLoc=touchLocation;
	}
	/*
	else if([[[event allTouches] allObjects] count]==2)
	{
		
		UITouch *firstTouch=[[[event allTouches] allObjects] objectAtIndex:0];
		UITouch *secondTouch=[[[event allTouches] allObjects] objectAtIndex:1];
		
		initialDist=[self distBetweenPoints:[firstTouch locationInView:self] secPoint:[secondTouch locationInView:self]];
	}
	 */
	
	UITouch *touch=[[event allTouches] anyObject];
	
	
	if([touch tapCount]==2)
	{
		if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(glView:withTapCount:)])
		{
			[self.delegate glView:self withTapCount:[touch tapCount]];
		}
	}
	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint currentTouchLoc;
	CGPoint amountMovement;
	//float rotDegree;
	
	if([[[event allTouches] allObjects] count]==1)
	{
		UITouch *touch=[[event allTouches] anyObject];
		
		currentTouchLoc=[touch locationInView:self];
		
		amountMovement.x=currentTouchLoc.x-lastTouchLoc.x;
		amountMovement.y=currentTouchLoc.y-lastTouchLoc.y;
		
		lastAmountMovement.x+=amountMovement.x;
		lastAmountMovement.y+=amountMovement.y;
		
		if(lastAmountMovement.x!=0)
			[owner setModelRotationAngle:lastAmountMovement.x*0.5 xAxis:0.0 yAxis:1.0 zAxis:0.0];
		
		if(lastAmountMovement.y!=0)
			[owner setModelRotationAngle:lastAmountMovement.y*0.5 xAxis:1.0 yAxis:0.0 zAxis:0.0];
		
		//NSLog(@"degree:%f",rotDegree);
		
		lastTouchLoc.x=currentTouchLoc.x;
		lastTouchLoc.y=currentTouchLoc.y;
	}
	/*
	else if([[[event allTouches] allObjects] count]==2)
	{
		
		CGFloat currentDist;
		
		float scaleAmount;
		
		UITouch *firstTouch=[[[event allTouches] allObjects] objectAtIndex:0];
		UITouch *secondTouch=[[[event allTouches] allObjects] objectAtIndex:1];
		
		currentDist=[self distBetweenPoints:[firstTouch locationInView:self] secPoint:[secondTouch locationInView:self]];
		
		if(currentDist==0)
		{
			initialDist=currentDist;
		}
		else if(currentDist>initialDist)
		{
			scaleAmount=currentDist-initialDist;
		}
		else if(currentDist<initialDist)
		{
			scaleAmount=currentDist-initialDist;
		}
		
		[owner CamZoom:(scaleAmount * 0.005)];
		
		initialDist=currentDist;
		
		//NSLog(@"sa:%f",scaleAmount);
		
		
	}
	 */
	
	
}

#pragma mark methods
-(CGFloat)distBetweenPoints:(CGPoint)firstPoint secPoint:(CGPoint)secondPoint
{
	CGFloat deltaX=secondPoint.x-firstPoint.x;
	CGFloat deltaY=secondPoint.y-firstPoint.y;
	
	return sqrt((deltaX*deltaX)+(deltaY*deltaY));
}




- (void)dealloc {
	
	if([EAGLContext currentContext]==renderingContext)
		[EAGLContext setCurrentContext:nil];
	
	self.renderingContext=nil;
	self.eaglLayer=nil;
	self.delegate=nil;
	self.owner=nil;
	
    [super dealloc];
}


@end
