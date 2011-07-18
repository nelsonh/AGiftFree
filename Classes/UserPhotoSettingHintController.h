//
//  UserPhotoSettingHintController.h
//  AGiftFree
//
//  Created by Nelson on 5/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserPhotoSettingHintController : UIViewController {
	
	UIButton *closeButton;
	UIButton *avaterHintButton;
	UIButton *cameraHintButton;
	UIButton *imageLibraryHintButton;
	UIButton *displayNameHintButton;
	UIButton *saveHintButton;
	UITextView *avaterHintTextView;
	UITextView *cameraHintTextView;
	UITextView *imageLibraryHintTextView;
	UITextView *displayNameHintTextView;
	UITextView *saveHintTextView;
	
	UITextView *currentShowedTextView;


}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *avaterHintButton;
@property (nonatomic, retain) IBOutlet UIButton *cameraHintButton;
@property (nonatomic, retain) IBOutlet UIButton *imageLibraryHintButton;
@property (nonatomic, retain) IBOutlet UIButton *displayNameHintButton;
@property (nonatomic, retain) IBOutlet UIButton *saveHintButton;
@property (nonatomic, retain) IBOutlet UITextView *avaterHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *cameraHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *imageLibraryHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *displayNameHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *saveHintTextView;
@property (nonatomic, retain) UITextView *currentShowedTextView;

-(IBAction)closeButtonPressed;
-(IBAction)avaterHintButtonPressed;
-(IBAction)cameraHintButtonPressed;
-(IBAction)imageLibraryHintButtonPressed;
-(IBAction)displayNameHintButtonPressed;
-(IBAction)saveHintButtonPressed;
-(void)reset;

@end
