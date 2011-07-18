//
//  DeleteIconView.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiftThumbnailImageView;

@interface DeleteIconView : UIImageView <UIAlertViewDelegate>{

	//imageview that own this delete icon 
	GiftThumbnailImageView *owner;
}

@property (nonatomic, retain) GiftThumbnailImageView *owner;

@end
