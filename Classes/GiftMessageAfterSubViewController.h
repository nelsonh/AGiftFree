//
//  GiftMessageAfterSubViewController.h
//  AGiftFree
//
//  Created by Nelson on 3/2/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "NewGiftItem.h"

@interface GiftMessageAfterSubViewController : UIViewController {
	
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UIImageView *envelopImageView;
	UITextView *messageTextView;
	UIActivityIndicatorView *activityView;
	NSData *sound; 
	AVAudioPlayer *soundPlayer;
	NewGiftItem *giftItem;
	
	NSMutableData *senderTempPhoto;
	NSURLConnection *senderPhotoConnection;
	
	BOOL canDismiss;
}

@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *envelopImageView;
@property (nonatomic, retain) IBOutlet UITextView *messageTextView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) NSData *sound;
@property (nonatomic, retain) AVAudioPlayer *soundPlayer;
@property (nonatomic, assign) NewGiftItem *giftItem;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *senderPhotoConnection;
@property (nonatomic, assign) BOOL canDismiss;





@end

