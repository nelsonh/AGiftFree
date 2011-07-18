//
//  WavefrontTexture.m
//  OpenGL
//
//  Created by Nelson on 2/15/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "WavefrontTexture.h"


@implementation WavefrontTexture

@synthesize filename;

-(id)initWithFilename:(NSString *)inFilename;
{
	if ((self = [super init]))
	{
		glEnable(GL_TEXTURE_2D);
		
		self.filename = inFilename;
		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);

		glGenTextures(1, &texture[0]);

		glBindTexture(GL_TEXTURE_2D, texture[0]);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);

		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);

		

		NSArray *domainPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *fileDirPath=[domainPaths objectAtIndex:0];
		
		//NSString *extension = [inFilename pathExtension];
		//NSString *base = [[inFilename componentsSeparatedByString:@"."] objectAtIndex:0];
		NSString *path = [fileDirPath stringByAppendingPathComponent:inFilename];
		NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
		
		// Assumes pvr4 is RGB not RGBA, which is how texturetool generates them

		UIImage *image = [[UIImage alloc] initWithData:texData];
		
		
		if (image == nil)
		{
			[texData release];
			return nil;
		}
		
		GLuint width = CGImageGetWidth(image.CGImage);
		GLuint height = CGImageGetHeight(image.CGImage);
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		void *imageData = malloc( height * width * 4 );
		CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
		CGColorSpaceRelease( colorSpace );
		CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
		CGContextTranslateCTM( context, 0, height - height );
		CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
		
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
		GLuint errorcode = glGetError();
		if(errorcode!=GL_NO_ERROR)
			NSLog(@"texture error %i", errorcode);
		
		CGContextRelease(context);
		
		
		free(imageData);
		[image release];
		[texData release];
		glEnable(GL_BLEND);
		
	}
	return self;
}
-(void)bind
{
	//NSLog(@"Binding texture: %@ (OGL: %d", filename, texture[0]);
	glBindTexture(GL_TEXTURE_2D, texture[0]);
}
-(void)dealloc
{
	glDeleteTextures(1, &texture[0]);
	[filename release];
	[super dealloc];
}

@end
