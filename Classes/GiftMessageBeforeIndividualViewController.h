//
//  GiftMessageBeforeViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewGiftItem.h"
#import <QuartzCore/QuartzCore.h>

#define animSpeed 0.5
#define startAnimSpeed 0.2

@interface GiftMessageBeforeIndividualViewController : UIViewController {
	
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UILabel *receiverNameLabel;
	UIButton *dismissButton;
	UIButton *letterButton;
	UILabel *toLabel;
	UITextView *messageTextView;
	UIImageView *pictureImageView;
	UIActivityIndicatorView *activityView;
	UIView *messageView;
	NewGiftItem *giftItem;
	
	NSMutableData *senderTempPhoto;
	NSURLConnection *downloadConnection;
	
	BOOL canDismiss;
	BOOL isShowMessage;
	
	CGPoint messageViewCenter;
}

@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *receiverNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *dismissButton;
@property (nonatomic, retain) IBOutlet UILabel *toLabel;
@property (nonatomic, retain) IBOutlet UITextView *messageTextView;
@property (nonatomic, retain) IBOutlet UIImageView *pictureImageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIView *messageView;
@property (nonatomic, retain) IBOutlet UIButton *letterButton;
@property (nonatomic, assign) NewGiftItem *giftItem;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *downloadConnection;
@property (nonatomic, assign) BOOL canDismiss;
@property (nonatomic, assign) BOOL isShowMessage;
@property (nonatomic, assign) CGPoint messageViewCenter;


-(IBAction)dismissButtonPress;
-(IBAction)letterButtonPress;

-(void)loadSenderPhotoWithURL:(id)object;
-(void)maximizeAnimDidFinish;



@end
