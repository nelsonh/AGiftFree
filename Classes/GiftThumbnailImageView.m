//
//  GiftImageView.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftThumbnailImageView.h"
#import "DeleteIconView.h"
#import "GiftGalleryScrollView.h"

@implementation GiftThumbnailImageView

@synthesize owner;
@synthesize crossIconView;
@synthesize thumbnailImagePath;
@synthesize imageIndex;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame ThumbnailImagePath:(NSString*)imagePath
{
	self=[super initWithFrame:frame];
	if(self)
	{
		//create delete icon
		crossIconView=[[DeleteIconView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		[self addSubview:crossIconView];
		[crossIconView setOwner:self];
		
		//hide cross icon at first time
		[crossIconView setHidden:YES];
		
		thumbnailImagePath=imagePath;
		
		//create thumbnail image
		[self setImage:[UIImage imageWithContentsOfFile:imagePath]];
		
		//enable user interaction
		[self setUserInteractionEnabled:YES];
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

#pragma mark methods
-(void)enableCrossIcon
{
	[crossIconView setHidden:NO];
	isEditing=YES;
}

-(void)disableCrossIcon
{
	[crossIconView setHidden:YES];
	isEditing=NO;
}

-(void)removeThisGift
{
	[owner removeItemWithIndex:self.imageIndex];
}

#pragma mark touch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(!isEditing)
	{
		//tell scroll view this image has just been selected
		[owner selectItemWithIndex:self.imageIndex];
	}
}

- (void)dealloc {
	
	[owner release];
	[crossIconView release];
	[thumbnailImagePath release];
    [super dealloc];
}


@end
