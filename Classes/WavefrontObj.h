//
//  WavefrontObj.h
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
#import "WavefrontMaterial.h"

@interface WavefrontObj : NSObject 
{
	NSString			*sourceObjFilePath;
	NSString			*sourceMtlFilePath;
	
	GLuint				numberOfVertices;
	Vertex3D			*vertices;	
	GLuint				numberOfFaces;			// Total faces in all groups
	
	Vector3D			*surfaceNormals;		// length = numberOfFaces
	Vector3D			*vertexNormals;			// length = numberOfFaces (*3 vertices per triangle);
	
	GLfloat				*textureCoords;
	GLubyte				valuesPerCoord;			// 1, 2, or 3, representing U, UV, or UVW mapping, could be 4 but OBJ doesn't support 4
	
	NSDictionary		*materials;
	NSMutableArray		*groups;
	
	Vertex3D			currentPosition;
	Rotation3D			currentRotation;
	
	float               rotXAngle;
	float               rotYAngle;
	float               rotZAngle;
	
	float				selfScale;

}

@property (nonatomic, retain) NSString *sourceObjFilePath;
@property (nonatomic, retain) NSString *sourceMtlFilePath;
@property (nonatomic, retain) NSDictionary *materials;
@property (nonatomic, retain) NSMutableArray *groups;
@property Vertex3D currentPosition;
@property Rotation3D currentRotation;
- (id)initWithPath:(NSString *)path;
- (void)renderSelf;
-(void)SetRotationXAngle:(float)x_Angle yAngle:(float)y_Angle zAngle:(float)z_Angle;
-(void)SetScale:(float)scale;

@end
