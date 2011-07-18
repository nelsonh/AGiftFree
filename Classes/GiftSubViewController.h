//
//  GiftSubView.h
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"
//#import <MediaPlayer/MediaPlayer.h>
#import "NewGiftItem.h"
#import "GiftMessageAfterIndividualViewController.h"
#import "GiftMessageBeforeIndividualViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GiftHintController.h"
#import "MPMoviePlayer.h"

@class RenderingEngine;

@interface GiftSubViewController : UIViewController <GLViewDelegate, AGiftWebServiceDelegate>{
	
	UIImageView *senderImageView;
	UILabel *senderNameLabel;
	UIButton *beforeMessageButton;
	UIButton *afterMessageButton;
	UIView *openGLESReferenceView;
	UIButton *playVideoButton;
	UIActivityIndicatorView *activityView;
	UIView *objectLoadingView;
	RenderingEngine *modelRenderingEngine;
	NewGiftItem *giftItem;
	BOOL playBoxOpenVideo;
	BOOL shouldReloadRnderEngine;
	BOOL shouldPlayMusicBegin;
	BOOL isDataReady;
	BOOL shouldDoActionBegin;
	UILabel *activityMsgLabel;
	UIButton *hintButton;
	GiftHintController *hintController;
	
	NSMutableData *senderTempPhoto;
	NSURLConnection *senderPhotoConnection;
	
	GiftMessageAfterIndividualViewController *afterMagController;
	GiftMessageBeforeIndividualViewController *beforeMsgController;
	
	MPMoviePlayer *videoPlayer;
	BOOL isVideoPlaying;
}

@property (nonatomic, retain) IBOutlet UIImageView *senderImageView;
@property (nonatomic, retain) IBOutlet UILabel *senderNameLabel;
@property (nonatomic, retain) IBOutlet UIButton *beforeMessageButton;
@property (nonatomic, retain) IBOutlet UIButton *afterMessageButton;
@property (nonatomic, retain) IBOutlet UIView *openGLESReferenceView;
@property (nonatomic, retain) IBOutlet UIButton *playVideoButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIView *objectLoadingView;
@property (nonatomic, retain) IBOutlet UILabel *activityMsgLabel;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet GiftHintController *hintController;
@property (nonatomic ,retain) NSMutableData *senderTempPhoto;
@property (nonatomic ,assign) NSURLConnection *senderPhotoConnection;
@property (nonatomic, retain) RenderingEngine *modelRenderingEngine;
@property (nonatomic, retain) GiftMessageAfterIndividualViewController *afterMagController;
@property (nonatomic, retain) GiftMessageBeforeIndividualViewController *beforeMsgController;
@property (nonatomic, assign) BOOL playBoxOpenVideo;
@property (nonatomic, retain) NewGiftItem *giftItem;
@property (nonatomic, assign) BOOL shouldReloadRnderEngine;
@property (nonatomic, assign) BOOL shouldPlayMusicBegin;
@property (nonatomic, assign) BOOL isDataReady;
@property (nonatomic, assign) BOOL shouldDoActionBegin;
@property (nonatomic, assign) MPMoviePlayer *videoPlayer;
@property (nonatomic, assign) BOOL isVideoPlaying;


-(IBAction)playButtonPress;
-(IBAction)beforeMessageButtonPress;
-(IBAction)afterMessageButtonPress;
-(IBAction)hintButtonPress;

-(void)playVideo:(NSString*)videoFileName;
-(void)playVideo:(NSString *)videoFileName Target:(id)target finishPerformAction:(SEL)action;
-(void)presentAfterMessage;
-(void)presentBeforeMessage;
-(void)checkShouldStartThirdDownload;
-(void)startThirdDownload;
-(void)prepareData;
-(BOOL)shouldShowAfterMessage;
-(BOOL)shouldShowBeforeMessage;
-(void)giftVideoDidFinish;
-(void)playSound;


@end
