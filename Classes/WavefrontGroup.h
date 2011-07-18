//
//  WavefrontGroup.h
//  OpenGL
//
//  Created by Nelson on 2/11/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "WavefrontCommon.h"

@class WavefrontMaterial;

@interface WavefrontGroup : NSObject 
{
	NSString				*name;
	GLuint					numberOfFaces;
	Face3D					*faces;	

	WavefrontMaterial	    *material;
}

@property (nonatomic, retain) NSString *name;
@property GLuint numberOfFaces;
@property Face3D *faces;
@property (nonatomic, retain) WavefrontMaterial *material;

-(id)initWithName:(NSString *)inName 
	 numberOfFaces:(GLuint)inNumFaces
		  material:(WavefrontMaterial *)inMaterial;

@end
