//
//  UserSectionView.h
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserPhotoSettingViewController;
@class UserSettingViewController;

@interface UserSectionRootViewController : UIViewController {
	
	UISegmentedControl *segmentedController;
	UserPhotoSettingViewController *userPhotoViewController;
	UserSettingViewController *userSettingViewController;
	NSArray *viewContainer;
}

@property (nonatomic, retain) IBOutlet UserPhotoSettingViewController *userPhotoViewController;
@property (nonatomic, retain) IBOutlet UserSettingViewController *userSettingViewController;
@property (nonatomic, retain) NSArray *viewContainer;
@property (nonatomic, retain) UISegmentedControl *segmentedController;

-(IBAction)toggleView:(id)sender;
-(void)updateCurrentChildView;

@end
