//
//  WavefrontTexture.h
//  OpenGL
//
//  Created by Nelson on 2/15/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


@interface WavefrontTexture : NSObject {
	
	GLuint		texture[1];  
	NSString	*filename;

}

@property (nonatomic, retain) NSString *filename;
-(id)initWithFilename:(NSString *)inFilename;
-(void)bind;

@end
