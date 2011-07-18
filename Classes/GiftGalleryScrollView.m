//
//  GiftGalleryScrollView.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftGalleryScrollView.h"
#import "GiftThumbnailImageView.h"

@implementation GiftGalleryScrollView

@synthesize giftThumbnails;
@synthesize sourceDataDelegate;
@synthesize methodDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
        // Initialization code.

		
    }
    return self;
}

-(void)initialize
{
	self.giftThumbnails=[[NSMutableArray alloc] init];
	
	//start position point
	positionToSet.x=kSpace;
	positionToSet.y=kSpace;
	
	if(self.sourceDataDelegate!=nil)
	{
		//setup content size base on number of item
		totalItem=[self.sourceDataDelegate numberOfItemInContentWithGiftGalleryScrollView:self];
		[self setupContentSize:totalItem];
		
	}
	
	if(self.sourceDataDelegate!=nil)
	{
		//create images
		
		for(int i=0; i<totalItem; i++)
		{
			NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docDirectory=[paths objectAtIndex:0];
			
			NSString *imageFileName=[self.sourceDataDelegate GalleryScrollView:self giftImageFileNameForIndex:i];
			NSString *imageFullPath=[docDirectory stringByAppendingPathComponent:imageFileName];
			GiftThumbnailImageView *tempImage=[[GiftThumbnailImageView alloc] initWithFrame:CGRectMake(0, 0, kItemSize, kItemSize) ThumbnailImagePath:imageFullPath];
			[tempImage setOwner:self];
			[tempImage setImageIndex:i];
			[tempImage.layer setCornerRadius:10.0f];
			[tempImage.layer setMasksToBounds:YES];
			[giftThumbnails addObject:tempImage];
			[tempImage release];
		}
		
		//[imageFileName release];
	}
	
	if(self.sourceDataDelegate!=nil)
	{
		for(int i=0; i<[giftThumbnails count]; i++)
		{
			//setup image position
			GiftThumbnailImageView *thumbnail=[giftThumbnails objectAtIndex:i];
			CGRect thumbnailFrame=CGRectMake(positionToSet.x, positionToSet.y, thumbnail.frame.size.width, thumbnail.frame.size.height);
			
			//set frame
			thumbnail.frame=thumbnailFrame;
			
			//calculate next position
			positionToSet=[self calculateNextPosition];
		}
		
		for(int j=0; j<[giftThumbnails count]; j++)
		{
			//add image to scroll view
			GiftThumbnailImageView *thumbnail=[giftThumbnails objectAtIndex:j];
			[self addSubview:thumbnail];
		}
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

#pragma mark methods
-(void)startEditItem
{
	for(GiftThumbnailImageView *image in giftThumbnails)
	{
		[image enableCrossIcon];
	}
}

-(void)stopEditItem
{
	for(GiftThumbnailImageView *image in giftThumbnails)
	{
		[image disableCrossIcon];
	}
}

-(void)setupContentSize:(NSUInteger)numberOfItem
{
	CGSize scrollViewContentSize;
	CGSize scrollViewSpaceSize;
	CGSize scrollViewTotalSize;
	NSUInteger numberOfRow=numberOfItem/kRowItem;
	NSUInteger remain=numberOfItem%kRowItem;
	
	if(remain!=0)
	{
		numberOfRow=numberOfRow+1;
	}
	
	scrollViewContentSize.width=kItemSize*kRowItem;
	scrollViewContentSize.height=numberOfRow*kItemSize;
	scrollViewSpaceSize.width=kSpace*(kRowItem+1);
	scrollViewSpaceSize.height=kSpace*(numberOfRow+1);
	
	scrollViewTotalSize.width=scrollViewContentSize.width+scrollViewSpaceSize.width;
	scrollViewTotalSize.height=scrollViewContentSize.height+scrollViewSpaceSize.height;
	
	[self setContentSize:CGSizeMake(scrollViewTotalSize.width,	scrollViewTotalSize.height)];
}

-(CGPoint)calculateNextPosition
{
	CGPoint newPoisition;
	
	//x position
	if((positionToSet.x+kItemSize+kSpace)<self.frame.size.width)
	{
		//a row is not full
		newPoisition.x=positionToSet.x+kItemSize+kSpace;
		
		//y position
		newPoisition.y=positionToSet.y;
	}
	else
	{
		//position to next row most left 
		newPoisition.x=kSpace;
		//y position
		newPoisition.y=positionToSet.y+kItemSize+kSpace;
	}
	
	return newPoisition;
}

-(void)removeItemWithIndex:(NSUInteger)imageIndex
{
	//set refresh start point and index
	refreshStartIndex=imageIndex;
	positionToSet=[(GiftThumbnailImageView*)[giftThumbnails objectAtIndex:imageIndex] frame].origin;
	
	//remove image at index
	GiftThumbnailImageView *thumbnail=[giftThumbnails objectAtIndex:imageIndex];
	[thumbnail removeFromSuperview];
	[giftThumbnails removeObjectAtIndex:imageIndex];
	
	//inform delegate
	if(self.methodDelegate!=nil)
	{
		[self.methodDelegate GalleryScrollView:self didDeleteItemWithIndex:imageIndex];
	}
	
	//refresh index and view
	[self refreshItemIndex];
	[self refreshView];
	

}

-(void)selectItemWithIndex:(NSUInteger)imageIndex
{
	//inform delegate
	if(self.methodDelegate!=nil)
	{
		[self.methodDelegate GalleryScrollView:self didSelectItemWithIndex:imageIndex];
	}
}

-(void)refreshItemIndex
{
	for(int i=0; i<[giftThumbnails count]; i++)
	{
		GiftThumbnailImageView *thumbnail=[giftThumbnails objectAtIndex:i];
		[thumbnail setImageIndex:i];
	}
}

-(void)refreshView
{
	for(int i=refreshStartIndex; i<[giftThumbnails count]; i++)
	{
		//setup image position
		GiftThumbnailImageView *thumbnail=[giftThumbnails objectAtIndex:i];
		CGRect thumbnailFrame=CGRectMake(positionToSet.x, positionToSet.y, thumbnail.frame.size.width, thumbnail.frame.size.height);
		
		//set frame
		thumbnail.frame=thumbnailFrame;
		
		//calculate next position
		positionToSet=[self calculateNextPosition];
	}
	
	//refresh content size
	[self setupContentSize:[giftThumbnails count]];
}


- (void)dealloc {
	
	[giftThumbnails release];
	self.sourceDataDelegate=nil;
	self.methodDelegate=nil;
	
    [super dealloc];
}


@end
