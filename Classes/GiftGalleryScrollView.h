//
//  GiftGalleryScrollView.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kSpace 5
#define kItemSize 64
#define kRowItem 4

@protocol GiftGalleryScrollViewSourceDataDelegate, GiftGalleryScrollViewDelegate;

@interface GiftGalleryScrollView : UIScrollView {
	
	//hold images 
	NSMutableArray *giftThumbnails;
	CGPoint positionToSet;
	NSUInteger refreshStartIndex;
	NSUInteger totalItem;
	
	id<GiftGalleryScrollViewSourceDataDelegate> sourceDataDelegate;
	id<GiftGalleryScrollViewDelegate> methodDelegate;
}

@property (nonatomic, retain) NSMutableArray *giftThumbnails;
@property (nonatomic, assign) IBOutlet id<GiftGalleryScrollViewSourceDataDelegate> sourceDataDelegate;
@property (nonatomic, assign) IBOutlet id<GiftGalleryScrollViewDelegate> methodDelegate;

-(void)initialize;
-(void)startEditItem;
-(void)stopEditItem;
-(void)setupContentSize:(NSUInteger)numberOfItem;
-(CGPoint)calculateNextPosition;
-(void)removeItemWithIndex:(NSUInteger)imageIndex;
-(void)selectItemWithIndex:(NSUInteger)imageIndex;
-(void)refreshItemIndex;
-(void)refreshView;
@end

@protocol GiftGalleryScrollViewDelegate<NSObject>

-(void)GalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView didSelectItemWithIndex:(NSUInteger)index;
-(void)GalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView didDeleteItemWithIndex:(NSUInteger)index;

@end

@protocol GiftGalleryScrollViewSourceDataDelegate<NSObject>

-(NSUInteger)numberOfItemInContentWithGiftGalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView;
-(NSString*)GalleryScrollView:(GiftGalleryScrollView*)giftGalleryScrollView giftImageFileNameForIndex:(NSUInteger)index;

@end