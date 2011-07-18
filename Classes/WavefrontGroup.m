//
//  WavefrontGroup.m
//  OpenGL
//
//  Created by Nelson on 2/11/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "WavefrontGroup.h"


@implementation WavefrontGroup

@synthesize name;
@synthesize numberOfFaces;
@synthesize faces;

@synthesize material;

-(id)initWithName:(NSString *)inName 
	 numberOfFaces:(GLuint)inNumFaces
		  material:(WavefrontMaterial *)inMaterial
{
	if ((self = [super init]))
	{
		self.name = inName;
		self.numberOfFaces = inNumFaces;
		self.material = inMaterial;
		
		faces = malloc(sizeof(Face3D) * numberOfFaces);
	}
	return self;
}

-(void)dealloc
{
	[name release];
	if (faces)
		free(faces);
	[material release];
	[super dealloc];
}

@end
