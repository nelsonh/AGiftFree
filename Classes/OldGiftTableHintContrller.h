//
//  OldGiftTableHintContrller.h
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OldGiftTableHintContrller : UIViewController {
	
	UIButton *closeButton;
	UIImageView *areaFrameImageView;
	UIButton *tableHintButton;
	//UITextView *tableHintTextView;
	UIImageView *cellExampleImageView;
	UITextView *cellHintTextView;
	UIImageView *giftIconImageView;
	UITextView *giftIconTextView;

}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIImageView *areaFrameImageView;
@property (nonatomic, retain) IBOutlet UIButton *tableHintButton;
//@property (nonatomic, retain) IBOutlet UITextView *tableHintTextView;
@property (nonatomic, retain) IBOutlet UIImageView *cellExampleImageView;
@property (nonatomic, retain) IBOutlet UITextView *cellHintTextView;
@property (nonatomic, retain) IBOutlet UIImageView *giftIconImageView;
@property (nonatomic, retain) IBOutlet UITextView *giftIconTextView;

-(IBAction)closeButtonPress;
-(IBAction)tableHintButtonPress;

-(void)reset;

@end
