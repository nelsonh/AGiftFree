//
//  NewGiftNotificationView.h
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface NewGiftNotificationViewController : UIViewController {
	
	UIImageView *animationImageView;
	UIImageView *gotGiftMsgImageView;
	UIImageView *noGiftMsgImageView;
	UIButton *openButton;
	NSArray *animationSlide;
	BOOL hasNewGifts;
	AVAudioPlayer *musicPlayer;
}

@property (nonatomic, retain) IBOutlet UIImageView *animationImageView;
@property (nonatomic, retain) IBOutlet UIImageView *gotGiftMsgImageView;
@property (nonatomic, retain) IBOutlet UIImageView *noGiftMsgImageView;
@property (nonatomic, retain) IBOutlet UIButton *openButton;
@property (nonatomic, retain) NSArray *animationSlide;
@property (nonatomic, assign) BOOL hasNewGifts;
@property (nonatomic, retain) AVAudioPlayer *musicPlayer;

-(IBAction)openButtonPress;


@end
