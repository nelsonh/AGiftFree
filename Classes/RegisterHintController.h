//
//  RegisterHintController.h
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegisterHintController : UIViewController {
	
	UIButton *closeButton;
	UIButton *avaterPhotoHintButton;
	UIButton *cameraHintButton;
	UIButton *photoLibraryHintButton;
	UIButton *areaCodeHintButton;
	UIButton *phoneNumberHintButton;
	UIButton *displayNameHintButton;
	UITextView *avaterPhotoHintTextView;
	UITextView *cameraHintTextView;
	UITextView *photoLibraryHintTextView;
	UITextView *areaCodeHintTextView;
	UITextView *phoneNumberHintTextView;
	UITextView *displayNameHintTextView;

}

@property (nonatomic, retain) IBOutlet UIButton *closeButton;
@property (nonatomic, retain) IBOutlet UIButton *avaterPhotoHintButton;
@property (nonatomic, retain) IBOutlet UIButton *cameraHintButton;
@property (nonatomic, retain) IBOutlet UIButton *photoLibraryHintButton;
@property (nonatomic, retain) IBOutlet UIButton *areaCodeHintButton;
@property (nonatomic, retain) IBOutlet UIButton *phoneNumberHintButton;
@property (nonatomic, retain) IBOutlet UIButton *displayNameHintButton;
@property (nonatomic, retain) IBOutlet UITextView *avaterPhotoHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *cameraHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *photoLibraryHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *areaCodeHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *phoneNumberHintTextView;
@property (nonatomic, retain) IBOutlet UITextView *displayNameHintTextView;

-(IBAction)closeButtonPress;
-(IBAction)avaterPhotoHintButtonPress;
-(IBAction)cameraHintButtonPress;
-(IBAction)photoLibraryHintButtonPress;
-(IBAction)areaCodeHintButtonPress;
-(IBAction)phoneNumberHintButtonPress;
-(IBAction)displayNameHintButtonPress;

-(void)reset;


@end
