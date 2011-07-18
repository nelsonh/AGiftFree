//
//  GiftMessageBeforeSubViewController.h
//  AGiftFree
//
//  Created by Nelson on 3/2/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewGiftItem.h"

@interface GiftMessageBeforeSubViewController : UIViewController {
	
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UILabel *toLabel;
	UIImageView *envelopImageView;
	UITextView *messageTextView;
	UIImageView *pictureImageView;
	UIActivityIndicatorView *activityView;
	NewGiftItem *giftItem;
	
	NSMutableData *senderTempPhoto;
	NSURLConnection *senderPhotoConnection;
	
	BOOL canDismiss;

}

@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *toLabel;
@property (nonatomic, retain) IBOutlet UIImageView *envelopImageView;
@property (nonatomic, retain) IBOutlet UITextView *messageTextView;
@property (nonatomic, retain) IBOutlet UIImageView *pictureImageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, assign) NewGiftItem *giftItem;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *senderPhotoConnection;
@property (nonatomic, assign) BOOL canDismiss;


@end
