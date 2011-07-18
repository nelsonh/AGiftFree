//
//  GiftHintController.h
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GiftHintController : UIViewController {
	
	UIButton *closeButton;
	UIButton *onGiftBoxMsgHintButton;
	UIButton *onGiftMsgHintButton;
	UIButton *unwrapGiftHintButton;
	UIButton *gestureGiftBoxHintButton;
	UITextView *onGiftBoxHintMsgTextView;
	UITextView *onGiftHintMsgTextView;
	UITextView *unwrapGiftHintTextView;
	UITextView *gestureGiftBoxHintTextView;
	UIImageView *pinchInOutImageView;
	UIImageView *panImageView;

}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *onGiftBoxMsgHintButton;
@property (nonatomic, retain) IBOutlet UIButton *onGiftMsgHintButton;
@property (nonatomic, retain) IBOutlet UIButton *unwrapGiftHintButton;
@property (nonatomic, retain) IBOutlet UIButton *gestureGiftBoxHintButton;
@property (nonatomic, retain) IBOutlet UITextView *onGiftBoxHintMsgTextView;
@property (nonatomic, retain) IBOutlet UITextView *onGiftHintMsgTextView;
@property (nonatomic, retain) IBOutlet UITextView *unwrapGiftHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *gestureGiftBoxHintTextView;
@property (nonatomic, retain) IBOutlet UIImageView *pinchInOutImageView;
@property (nonatomic, retain) IBOutlet UIImageView *panImageView;

-(IBAction)closeButtonPress;
-(IBAction)onGiftBoxMsgHintButtonPress;
-(IBAction)onGiftMsgHintButtonPress;
-(IBAction)unwrapGiftHintButtonPress;
-(IBAction)gestureGiftBoxHintButtonPress;

-(void)reset;

@end
