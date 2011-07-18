//
//  GiftImageView.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeleteIconView;
@class GiftGalleryScrollView;



@interface GiftThumbnailImageView : UIImageView {
	
	//the scroll view that own this image view
	GiftGalleryScrollView *owner;
	
	//delete icon
	DeleteIconView *crossIconView;
	
	//thumbial image name
	NSString *thumbnailImagePath;
	
	//index
	NSUInteger imageIndex;
	
	BOOL isEditing;
}

@property (nonatomic, retain) GiftGalleryScrollView *owner;
@property (nonatomic, retain) DeleteIconView *crossIconView;
@property (nonatomic, retain) NSString *thumbnailImagePath;
@property (nonatomic, assign) NSUInteger imageIndex;

-(id)initWithFrame:(CGRect)frame ThumbnailImagePath:(NSString*)imagePath;
-(void)enableCrossIcon;
-(void)disableCrossIcon;
-(void)removeThisGift;

@end
