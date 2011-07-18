//
//  UserSettingHintController.h
//  AGiftFree
//
//  Created by Nelson on 5/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserSettingHintController : UIViewController {
	
	UIButton *closeButton;
	UIButton *autoDeletionHintButton;
	UITextView *autoDeletionTextView;

}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *autoDeletionHintButton;
@property (nonatomic, retain) IBOutlet UITextView *autoDeletionTextView;

-(IBAction)closeButtonPressed;
-(IBAction)autoDeletionHintButtonPressed;
-(void)reset;

@end
