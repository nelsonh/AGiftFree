//
//  PrivacyController.h
//  AGiftFree
//
//  Created by Nelson on 5/31/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFontSize 16

@interface PrivacyController : UIViewController {
	
	UIButton *allowButtton;
	UITextView *topTextView;
	UITextView *middleTextView;
	UITextView *buttomTextView;

}

@property (nonatomic, retain) IBOutlet UIButton *allowButtton;
@property (nonatomic, retain) IBOutlet UITextView *topTextView;
@property (nonatomic, retain) IBOutlet UITextView *middleTextView;
@property (nonatomic, retain) IBOutlet UITextView *buttomTextView;

-(IBAction)allowButttonPress;

@end
