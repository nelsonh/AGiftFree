//
//  GiftBoxSubView.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NewGiftItem.h"
#import "AGiftWebService.h"
#import "GiftMessageBeforeIndividualViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GiftBoxHintController.h"
#import "MPMoviePlayer.h"

#define patientMsgDelay 10
#define patientMsgFadeInDuration 0.3
#define patientMsgFadeOutDuration 0.3
#define patientMsgPresentTime 3

@class RenderingEngine;

@interface GiftBoxSubViewController : UIViewController <GLViewDelegate, AGiftWebServiceDelegate>{
	
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UIButton *beforeMessageButton;
	UIButton *afterMessageButton;
	UIView *openGLESReferenceView;
	UILabel *lockTimeLabel;
	UIButton *openButton;
	UIActivityIndicatorView *activityView;
	UIActivityIndicatorView *downloadActivityView;
	UIView *objectLoadingView;
	RenderingEngine *modelRenderingEngine;
	NSTimer *countDownTimer;
	NewGiftItem *giftItem;
	BOOL shouldReloadRnderEngine;
	//BOOL isDownloadingThirdData;
	UILabel *patientMsgLabel;
	GiftMessageBeforeIndividualViewController *beforeMsgController;
	UIButton *hintButton;
	GiftBoxHintController *hintController;
	MPMoviePlayer *videoPlayer;
	
	NSMutableData *senderTempPhoto;
	NSURLConnection *senderPhotoConnection;
	
	BOOL hasShowMessage;
}

@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *beforeMessageButton;
@property (nonatomic, retain) IBOutlet UIButton *afterMessageButton;
@property (nonatomic, retain) IBOutlet UIView *openGLESReferenceView;
@property (nonatomic, retain) IBOutlet UILabel *lockTimeLabel;
@property (nonatomic, retain) IBOutlet UIButton *openButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *downloadActivityView;
@property (nonatomic, retain) IBOutlet UIView *objectLoadingView;
@property (nonatomic, retain) IBOutlet UILabel *patientMsgLabel;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet GiftBoxHintController *hintController;
@property (nonatomic, retain) GiftMessageBeforeIndividualViewController *beforeMsgController;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *senderPhotoConnection;
@property (nonatomic, retain) RenderingEngine *modelRenderingEngine;
@property (nonatomic, assign) NSTimer *countDownTimer;
@property (nonatomic, retain) NewGiftItem *giftItem;
@property (nonatomic, assign) BOOL shouldReloadRnderEngine;
@property (nonatomic, assign) BOOL hasShowMessage;
@property (nonatomic, assign) MPMoviePlayer *videoPlayer;
//@property (nonatomic, assign) BOOL isDownloadingThirdData;


-(IBAction)openButtonPress;
-(IBAction)beforeMessageButtonPress;
-(IBAction)afterMessageButtonPress;
-(IBAction)hintButtonPress;

-(void)countDown;
//-(void)downloadGift;
-(void)unlockGiftBox;
-(void)fadeInPatientMsg;
-(void)fadeOutPatientMsg;
-(void)fadeInPatientMsgDidFinish;
-(void)fadeOutPatientMsgDidFinish;
-(void)giftBoxVideoFinished;
-(void)playVideo:(NSString*)videoFileName;
-(void)playVideo:(NSString *)videoFileName Target:(id)target finishPerformAction:(SEL)action;
-(BOOL)shouldShowMessage;
-(void)showMessage;



@end
