//
//  RegisterViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "RegisterViewController.h"
#import "AGiftFreeAppDelegate.h"


@implementation RegisterViewController

@synthesize userImageView;
@synthesize cameraButton;
@synthesize userNameLabel;
@synthesize phoneLabel;
@synthesize imageLibraryButton;
@synthesize userNameTextField;
@synthesize phoneNumberTextField;
@synthesize nextButton;
@synthesize resetImageButton;
@synthesize registingLabel;
@synthesize defaultUserImage;
@synthesize resetImageAlert;
@synthesize isFinished;
@synthesize areaCodeTextField;
@synthesize inAreaCode;
@synthesize inPhoneNumber;
@synthesize inUserName;
@synthesize hintButton;
@synthesize hintController;
@synthesize inUserPhoto;
@synthesize registerCompleteAlert;
@synthesize shouldShowPrivacy;
@synthesize privacyController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	//back up default user image so we can use to reset image
	self.defaultUserImage=[userImageView image];

	
	originUserNameTextField=userNameTextField.frame;
	originPhoneNumberTextField=phoneNumberTextField.frame;
	originAreaCodeTextField=areaCodeTextField.frame;
	
	if(inAreaCode)
	{
		[areaCodeTextField setText:inAreaCode];
	}
	
	if(inPhoneNumber)
	{
		[phoneNumberTextField setText:inPhoneNumber];
	}
	
	if(inUserName)
	{
		[userNameTextField setText:inUserName];
	}
	
	if(inUserPhoto)
	{
		[userImageView setImage:inUserPhoto];
	}
	
	self.shouldShowPrivacy=YES;
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	
	self.userImageView=nil;
	self.cameraButton=nil;
	self.userNameLabel=nil;
	self.phoneLabel=nil;
	self.imageLibraryButton=nil;
	self.userNameTextField=nil;
	self.phoneNumberTextField=nil;
	self.nextButton=nil;
	self.resetImageButton=nil;
	self.registingLabel=nil;
	self.defaultUserImage=nil;
	self.areaCodeTextField=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark  methods
-(void)sendRegisterInfoToServer
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSString *udid;
	UIDevice *userDevice=[UIDevice currentDevice];
	
	udid=udid=[appDelegate.userPhoneNumber stringByAppendingString:[NSString stringWithFormat:@"@%@", userDevice.uniqueIdentifier]];
	
	//send register info to server
	//NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
	[service setDelegate:self];
	[appDelegate.mainOpQueue addOperation:service];
	[service registerWithPhoneNumber:appDelegate.userPhoneNumber userName:appDelegate.userName profilePhoto:appDelegate.userPhotoImage deviceID:udid];
	[service release];
}

-(void)showPrivacy
{
	if(privacyController)
	{
		[privacyController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
		[self presentModalViewController:privacyController animated:YES];
	}
	
}

#pragma mark IBAction method
-(IBAction)resignKeyboard
{
	[phoneNumberTextField resignFirstResponder];
	[userNameTextField resignFirstResponder];
	[areaCodeTextField resignFirstResponder];
}

-(IBAction)nextButtonPress
{
	//TODO save user register info and send to server 
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if([phoneNumberTextField.text isEqualToString:@""])
	{
		UIAlertView *emailBlankAlert=[[UIAlertView alloc] initWithTitle:@"Field empty" message:@"Phone number can not be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[emailBlankAlert show];
		[emailBlankAlert release];
	}
	else if([userNameTextField.text isEqualToString:@""])
	{
		UIAlertView *userNameBlankAlert=[[UIAlertView alloc] initWithTitle:@"Field empty" message:@"User name can not be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[userNameBlankAlert show];
		[userNameBlankAlert release];
	}
	else 
	{
		
		appDelegate.userName=userNameTextField.text;
		appDelegate.userPhoneNumber=[areaCodeTextField.text stringByAppendingString:[NSString stringWithFormat:@"-%@", phoneNumberTextField.text]];
		appDelegate.userPhotoImage=UIImagePNGRepresentation([userImageView image]);
		
		[self resignKeyboard];
		
		//disable textfield
		[phoneNumberTextField setEnabled:NO];
		[userNameTextField setEnabled:NO];
		
		//disable reset image button
		[resetImageButton setEnabled:NO];
		
		//hide button
		[nextButton setHidden:YES];
		
		//show registing label 
		[registingLabel setText:@"Registering..."];
		[registingLabel setHidden:NO];
		
		//send register info to server with performselector avoid freezing scene
		[self performSelector:@selector(sendRegisterInfoToServer)];
	}


}

-(IBAction)resetImageButtonPress
{
	resetImageAlert=[[UIAlertView alloc] initWithTitle:@"Reset photo" message:@"The photo will be reset to default" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
	[resetImageAlert show];
}

-(IBAction)imageLibraryButtonPress
{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *photoLibraryPicker=[[UIImagePickerController alloc] init];
		photoLibraryPicker.delegate=self;
		[photoLibraryPicker setAllowsEditing:YES];
		photoLibraryPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:photoLibraryPicker animated:YES];
		[photoLibraryPicker release];
	}
	else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
	{
		UIImagePickerController *photoAlbumPicker=[[UIImagePickerController alloc] init];
		photoAlbumPicker.delegate=self;
		[photoAlbumPicker setAllowsEditing:YES];
		photoAlbumPicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		[self presentModalViewController:photoAlbumPicker animated:YES];
		[photoAlbumPicker release];
	}
	else 
	{
		NSString *alertTitle=@"Device not support";
		NSString *alertMsg=@"Your device is not support both photo library and photo album";
		
		UIAlertView*deviceNotSupportAlert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[deviceNotSupportAlert show];
		[deviceNotSupportAlert release];
		
	}

}

-(IBAction)cameraButtonPress
{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		UIImagePickerController *photoLibraryPicker=[[UIImagePickerController alloc] init];
		photoLibraryPicker.delegate=self;
		[photoLibraryPicker setAllowsEditing:YES];
		photoLibraryPicker.sourceType=UIImagePickerControllerSourceTypeCamera;
		[self presentModalViewController:photoLibraryPicker animated:YES];
		[photoLibraryPicker release];
	}
	else
	{
		NSString *alertTitle=@"Device not support";
		NSString *alertMsg=@"Your device is not support camera";
		
		UIAlertView*deviceNotSupportAlert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[deviceNotSupportAlert show];
		[deviceNotSupportAlert release];
	}
}

-(IBAction)hintButtonPress
{
	if(hintController)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
		[UIView setAnimationDuration:1.0];
		
		[self.view addSubview:hintController.view];
		
		[UIView commitAnimations];
	}
}

#pragma mark AGiftWebServiceDelegate
-(void)aGiftWebService:(AGiftWebService*)webService RegisterDictionary:(NSDictionary*)respondData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	BOOL isSuccess=[(NSString*)[respondData valueForKey:@"resbool"] boolValue];
	NSString *respondMsg=[respondData valueForKey:@"errorMsg"];
	
	if(isSuccess)
	{
		//save info and go to gift
		[appDelegate saveRegisterInfo];
		
		//mark finished 
		self.isFinished=YES;
		
		NSString *msg=@"Registration completed.";
		UIAlertView *regAlert=[[UIAlertView alloc] initWithTitle:@"Registration completed" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		self.registerCompleteAlert=regAlert;
		[regAlert show];
	}
	else 
	{
		//enable textfield
		[phoneNumberTextField setEnabled:YES];
		[userNameTextField setEnabled:YES];
		
		//enable reset image button
		[resetImageButton setEnabled:YES];
		
		//unhide button
		[nextButton setHidden:NO];
		
		//hide registing label 
		[registingLabel setHidden:YES];
		
		NSString *msg=[NSString stringWithFormat:@"Register fail because %@ \n If you have problem with registration please contact us for help 886+04+35042600", respondMsg];
		UIAlertView *regAlert=[[UIAlertView alloc] initWithTitle:@"Register fail" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[regAlert show];
		[regAlert release];
		
		/*
		if([respondMsg isEqualToString:@"Registered"])
		{
			NSString *msg=@"The phone number had been registered try to use other phone number for registeration";
			UIAlertView *regAlert=[[UIAlertView alloc] initWithTitle:@"Register error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[regAlert show];
			[regAlert release];
		}
		else 
		{
			
			NSString *failMsg=@"Unable to register to server because of ";
			NSString *msg=[failMsg stringByAppendingString:respondMsg];
			
			UIAlertView *registerFailAlert=[[UIAlertView alloc] initWithTitle:@"Register fail" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[registerFailAlert show];
			[registerFailAlert release];
			
		}
		 */

	}	
}

-(void)aGiftWebService:(AGiftWebService*)webService EditProfileDictionary:(NSDictionary*)respondData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	BOOL isSuccess=[(NSString*)[respondData valueForKey:@"resbool"] boolValue];
	NSString *respondMsg=[respondData valueForKey:@"errorMsg"];
	
	if(isSuccess)
	{
		//save info and go to gift
		[appDelegate saveRegisterInfo];
		
		//mark finished 
		self.isFinished=YES;
		
		[self dismissModalViewControllerAnimated:YES];
	}
	else 
	{
		//unhide button
		[nextButton setHidden:NO];
		
		//hide registing label 
		[registingLabel setHidden:YES];
		
		NSString *failMsg=@"Unable to update profile because of ";
		NSString *msg=[failMsg stringByAppendingString:respondMsg];
		
		UIAlertView *registerFailAlert=[[UIAlertView alloc] initWithTitle:@"Update profile fail" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[registerFailAlert show];
		[registerFailAlert release];
	}

}

#pragma mark Touches event
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self resignKeyboard];
}

#pragma mark UI alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(self.resetImageAlert==alertView)
	{
		if(buttonIndex==1)
		{
			
			[userImageView setImage:defaultUserImage];
			
		}
		
		self.resetImageAlert=nil;
	}
	else if(self.registerCompleteAlert==alertView)
	{
		self.registerCompleteAlert=nil;
		[self dismissModalViewControllerAnimated:YES];
	}

}

#pragma mark UI image picker controller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *selectedImage=[info objectForKey:UIImagePickerControllerEditedImage];
	[userImageView setImage:selectedImage];
	[picker dismissModalViewControllerAnimated:YES];
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
	if(isFinished)
	{
		AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate updateGiftList];
	}

}

-(void)viewDidAppear:(BOOL)animated
{
	if(shouldShowPrivacy)
	{
		self.shouldShowPrivacy=NO;
		[self showPrivacy];
	}
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
	
	if(textField==userNameTextField)
	{
		[self.view bringSubviewToFront:userNameTextField];
		
		CGRect endRect=CGRectMake(1, 214, 318, originUserNameTextField.size.height);
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[userNameTextField setFrame:endRect];
		[UIView commitAnimations];
	}
	else if(textField==phoneNumberTextField) 
	{
		[self.view bringSubviewToFront:phoneNumberTextField];
		
		CGRect endRect=CGRectMake(1, 214, 318, originPhoneNumberTextField.size.height);
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[phoneNumberTextField setFrame:endRect];
		[UIView commitAnimations];
	}
	else if(textField==areaCodeTextField)
	{
		[self.view bringSubviewToFront:areaCodeTextField];
		
		CGRect endRect=CGRectMake(1, 214, 318, originAreaCodeTextField.size.height);
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[areaCodeTextField setFrame:endRect];
		[UIView commitAnimations];
	}

	

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if(textField==areaCodeTextField)
	{
		NSUInteger textLength=[textField.text length]+[string length]-range.length;
		
		if(textLength>AreaCodeLimitation)
		{
			return NO;
		}
		else 
		{
			return YES;
		}
		
	}
	
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if(textField==userNameTextField)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[userNameTextField setFrame:originUserNameTextField];
		[UIView commitAnimations];
	}
	else if(textField==phoneNumberTextField)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[phoneNumberTextField setFrame:originPhoneNumberTextField];
		[UIView commitAnimations];
	}
	else if(textField==areaCodeTextField)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		[areaCodeTextField setFrame:originAreaCodeTextField];
		[UIView commitAnimations];
	}


}

- (void)dealloc {
	
	[userImageView release];
	[cameraButton release];
	[userNameLabel release];
	[phoneLabel release];
	[imageLibraryButton release];
	[userNameTextField release];
	[phoneNumberTextField release];
	[nextButton release];
	[resetImageButton release];
	[registingLabel release];
	[defaultUserImage release];
	[areaCodeTextField release];
	[inAreaCode release];
	[inPhoneNumber release];
	[inUserName release];
	[hintButton release];
	[hintController release];
	[inUserPhoto release];
	[resetImageAlert release];
	[registerCompleteAlert release];
	
    [super dealloc];
}


@end
