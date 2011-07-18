//
//  WavefrontMaterial.h
//  OpenGL
//
//  Created by Nelson on 2/11/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "WavefrontCommon.h"

@class WavefrontTexture;

@interface WavefrontMaterial : NSObject 
{
	NSString	*name;
	Color3D		diffuse;
	Color3D		ambient;
	Color3D		specular;
	GLfloat		shininess;
	WavefrontTexture *texture;
}

@property (nonatomic, retain) NSString *name;
@property Color3D diffuse;
@property Color3D ambient;
@property Color3D specular;
@property GLfloat shininess;
@property (nonatomic, retain) WavefrontTexture *texture;

+ (id)defaultMaterial;
+ (id)materialsFromMtlFile:(NSString *)path;
- (id)initWithName:(NSString *)inName shininess:(GLfloat)inShininess diffuse:(Color3D)inDiffuse ambient:(Color3D)inAmbient specular:(Color3D)inSpecular;
- (id)initWithName:(NSString *)inName shininess:(GLfloat)inShininess diffuse:(Color3D)inDiffuse ambient:(Color3D)inAmbient specular:(Color3D)inSpecular texture:(WavefrontTexture *)inTexture;
@end
