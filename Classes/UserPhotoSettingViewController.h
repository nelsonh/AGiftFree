//
//  UserPhotoSettingView.h
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGiftWebService.h"
#import "UserPhotoSettingHintController.h"


@interface UserPhotoSettingViewController : UIViewController <UITextFieldDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, AGiftWebServiceDelegate>{
	
	UIImageView *userPhotoImageView;
	UIButton *cameraButton;
	UIButton *imageLibraryButton;
	UILabel *userNameLabel;
	UITextField *userNameTextField;
	UIButton *saveButton;
	UILabel *updateProfileLabel;
	CGRect originRectTextField;
	UITextField *userPhoneNumberTextField;
	UIButton *hintButton;
	UserPhotoSettingHintController *hintController;

}

@property (nonatomic, retain) IBOutlet UIImageView *userPhotoImageView;
@property (nonatomic, retain) IBOutlet UIButton *cameraButton;
@property (nonatomic, retain) IBOutlet UIButton *imageLibraryButton;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;
@property (nonatomic, retain) IBOutlet UITextField *userNameTextField;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UILabel *updateProfileLabel;
@property (nonatomic, retain) IBOutlet UITextField *userPhoneNumberTextField;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet UserPhotoSettingHintController *hintController;


-(IBAction)cameraButtonPress;
-(IBAction)imageLibraryButtonPress;
-(IBAction)saveButtonPress;
-(IBAction)resignKeyboard;
-(IBAction)hintButtonPress;

-(void)retrieveUserInfo;
-(void)disableHint;
-(void)moveViewUpAnim;
-(void)moveViewDownAnim;

@end
