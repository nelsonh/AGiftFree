//
//  GiftMessageAfterViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewGiftItem.h"
#import <AVFoundation/AVFoundation.h>

@interface GiftMessageAfterIndividualViewController : UIViewController {
	
	UIImageView *senderImageView;
	//UILabel *senderNameLabel;
	UIButton *dismissButton;
	UIImageView *envelopImageView;
	UITextView *messageTextView;
	id performTarget;
	SEL performAction;
	UIActivityIndicatorView *activityView;
	NewGiftItem *giftItem;
	NSData *sound; 
	AVAudioPlayer *soundPlayer;
	
	NSMutableData *senderTempPhoto;
	NSURLConnection *downloadConnection;
	
	BOOL canDismiss;
	BOOL enablePerformActionWhenDismiss;
}

@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
//@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *dismissButton;
@property (nonatomic, retain) IBOutlet UIImageView *envelopImageView;
@property (nonatomic, retain) IBOutlet UITextView *messageTextView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, assign) NewGiftItem *giftItem;
@property (nonatomic, retain) NSData *sound;
@property (nonatomic, retain) AVAudioPlayer *soundPlayer;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *downloadConnection;
@property (nonatomic, assign) BOOL canDismiss;
@property (nonatomic, assign) BOOL enablePerformActionWhenDismiss;

-(IBAction)dismissButtonPress;

-(void)performAcionWhenDismissWithTarget:(id)target Action:(SEL)action;
-(void)loadSenderPhotoWithURL:(id)object;
@end
