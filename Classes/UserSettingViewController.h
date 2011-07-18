//
//  UserSettingViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSettingHintController.h"

@interface UserSettingViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	
	UILabel *autoDeleteLabel;
	UIPickerView *monthsPicker;
	UILabel *notificationLabel;
	UISwitch *notificationSwitch;
	UIImageView *asquareLogo;
	UITextView *infoTextView;
	UIButton *hintButton;
	UserSettingHintController *hintController;
	
	NSArray *autoDeletionDataSource;
}

@property (nonatomic, retain) IBOutlet UILabel *autoDeleteLabel;
@property (nonatomic, retain) IBOutlet UIPickerView *monthsPicker;
@property (nonatomic, retain) IBOutlet UILabel *notificationLabel;
@property (nonatomic, retain) IBOutlet UISwitch *notificationSwitch;
@property (nonatomic, retain) IBOutlet UIImageView *asquareLogo;
@property (nonatomic, retain) IBOutlet UITextView *infoTextView;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet UserSettingHintController *hintController;

@property (nonatomic, retain) NSArray *autoDeletionDataSource;

-(IBAction)notificationSwitchChange:(id)sender;
-(IBAction)hintButtonPress;

-(void)disableHint;


@end
