//
//  GiftCollectionHintController.h
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GiftCollectionHintController : UIViewController {
	
	UIButton *closeButton;
	UIButton *editHintButton;
	UIButton *giftCollectionHintButton;
	UITextView *editHintTextView;
	UITextView *receiveTimeHintTextView;
	UITextView *autoDeletionHintTextView;
	UITextView *onGiftBoxMsgHintTextView;
	//UITextView *giftCollectionHintTextView;
	UIImageView *areaFrameImageView;
	UIImageView *receiveTimeIcon;
	UIImageView *autoDeletionIcon;
	UIImageView *onGiftBoxMsgIcon;
	UIImageView *collectionCellImageView;
}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *editHintButton;
@property (nonatomic, retain) IBOutlet UIButton *giftCollectionHintButton;
@property (nonatomic, retain) IBOutlet UITextView *editHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *receiveTimeHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *autoDeletionHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *onGiftBoxMsgHintTextView;
//@property (nonatomic, retain) IBOutlet UITextView *giftCollectionHintTextView;
@property (nonatomic, retain) IBOutlet UIImageView *areaFrameImageView;
@property (nonatomic, retain) IBOutlet UIImageView *receiveTimeIcon;
@property (nonatomic, retain) IBOutlet UIImageView *autoDeletionIcon;
@property (nonatomic, retain) IBOutlet UIImageView *onGiftBoxMsgIcon;
@property (nonatomic, retain) IBOutlet UIImageView *collectionCellImageView;

-(IBAction)closeButtonPress;
-(IBAction)editHintButtonPress;
-(IBAction)giftCollectionHintButtonPress;

-(void)reset;

@end
