//
//  RegisterViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGiftWebService.h"
#import "RegisterHintController.h"
#import "PrivacyController.h"

#define AreaCodeLimitation 3

@interface RegisterViewController : UIViewController <UITextFieldDelegate ,UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AGiftWebServiceDelegate>{
	
	UIImage *defaultUserImage;
	UIImageView *userImageView;
	UIButton *cameraButton;
	UILabel *userNameLabel;
	UILabel *phoneLabel;
	UIButton *imageLibraryButton;
	UITextField *userNameTextField;
	UITextField *phoneNumberTextField;
	UITextField *areaCodeTextField;
	UIButton *nextButton;
	UIButton *resetImageButton;
	UILabel *registingLabel;
	UIButton *hintButton;
	
	NSString *inAreaCode;
	NSString *inPhoneNumber;
	NSString *inUserName;
	UIImage *inUserPhoto;
	
	UIAlertView *resetImageAlert;
	UIAlertView *registerCompleteAlert;
	
	RegisterHintController *hintController;
	PrivacyController *privacyController;
	
	//to determind all register process finished or not
	BOOL isFinished;
	
	CGRect originUserNameTextField;
	CGRect originPhoneNumberTextField;
	CGRect originAreaCodeTextField;
	
	BOOL shouldShowPrivacy;
}

@property (nonatomic, retain) IBOutlet UIImageView *userImageView;
@property (nonatomic, retain) IBOutlet UIButton *cameraButton;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) IBOutlet UIButton *imageLibraryButton;
@property (nonatomic, retain) IBOutlet UITextField *userNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *phoneNumberTextField;
@property (nonatomic, retain) IBOutlet UITextField *areaCodeTextField;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIButton *resetImageButton;
@property (nonatomic, retain) IBOutlet UILabel *registingLabel;
@property (nonatomic, retain) IBOutlet UIButton *hintButton;
@property (nonatomic, retain) IBOutlet RegisterHintController *hintController;
@property (nonatomic, retain) IBOutlet PrivacyController *privacyController;
@property (nonatomic, retain) UIImage *defaultUserImage;
@property (nonatomic, retain) UIAlertView *resetImageAlert;
@property (nonatomic, retain) UIAlertView *registerCompleteAlert;
@property (nonatomic, assign) BOOL isFinished;
@property (nonatomic, retain) NSString *inAreaCode;
@property (nonatomic, retain) NSString *inPhoneNumber;
@property (nonatomic, retain) NSString *inUserName;
@property (nonatomic, retain) UIImage *inUserPhoto;
@property (nonatomic, assign) BOOL shouldShowPrivacy;


-(IBAction)resignKeyboard;
-(IBAction)nextButtonPress;
-(IBAction)resetImageButtonPress;
-(IBAction)imageLibraryButtonPress;
-(IBAction)cameraButtonPress;
-(IBAction)hintButtonPress;

-(void)sendRegisterInfoToServer;
-(void)showPrivacy;

@end
