//
//  UserPhotoSettingView.m
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "UserPhotoSettingViewController.h"
#import "AGiftFreeAppDelegate.h"

@implementation UserPhotoSettingViewController

@synthesize userPhotoImageView;
@synthesize cameraButton;
@synthesize imageLibraryButton;
@synthesize userNameLabel;
@synthesize userNameTextField;
@synthesize saveButton;
@synthesize updateProfileLabel;
@synthesize userPhoneNumberTextField;
@synthesize hintButton;
@synthesize hintController;


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
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//load saved user image
	if(appDelegate.userPhotoImage==nil)
	{
		[userPhotoImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
	}
	else 
	{
		[userPhotoImageView setImage:[UIImage imageWithData:appDelegate.userPhotoImage]];
	}

	originRectTextField=userNameTextField.frame;
	[userNameTextField setDelegate:self];
	
	[self retrieveUserInfo];
	
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
	
	self.userPhotoImageView=nil;
	self.cameraButton=nil;
	self.imageLibraryButton=nil;
	self.userNameLabel=nil;
	self.userNameTextField=nil;
	self.saveButton=nil;
	self.updateProfileLabel=nil;
	self.userPhoneNumberTextField=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark IBAction methods
-(IBAction)cameraButtonPress
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		UIImagePickerController *photoLibraryPicker=[[UIImagePickerController alloc] init];
		photoLibraryPicker.delegate=self;
		[photoLibraryPicker setAllowsEditing:YES];
		photoLibraryPicker.sourceType=UIImagePickerControllerSourceTypeCamera;
		[appDelegate.rootController presentModalViewController:photoLibraryPicker animated:YES];
		[photoLibraryPicker release];
	}
	else
	{
		NSString *alertTitle=@"Device not support";
		NSString *alertMsg=@"Your device is not support camera";
		
		UIAlertView* deviceNotSupportAlert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[deviceNotSupportAlert show];
		[deviceNotSupportAlert release];
	}
}

-(IBAction)imageLibraryButtonPress
{

	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *photoAlbumPicker=[[UIImagePickerController alloc] init];
		photoAlbumPicker.delegate=self;
		photoAlbumPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
		[photoAlbumPicker setAllowsEditing:YES];
		[appDelegate.rootController presentModalViewController:photoAlbumPicker animated:YES];
		[photoAlbumPicker release];
	}
	else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
	{
		UIImagePickerController *photoLibraryPicker=[[UIImagePickerController alloc] init];
		photoLibraryPicker.delegate=self;
		photoLibraryPicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		[photoLibraryPicker setAllowsEditing:YES];
		[appDelegate.rootController presentModalViewController:photoLibraryPicker animated:YES];
		[photoLibraryPicker release];
	}
	else 
	{
		NSString *alertTitle=@"Device not support";
		NSString *alertMsg=@"Your device is not support both photo library and photo album";
		
		UIAlertView* deviceNotSupportAlert=[[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[deviceNotSupportAlert show];
		[deviceNotSupportAlert release];
		
	}
	
	
}

-(IBAction)saveButtonPress
{
	//TODO:save image and send to server
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[self resignKeyboard];
	
	if([userNameTextField.text isEqualToString:@""])
	{
		UIAlertView *userNameBlankAlert=[[UIAlertView alloc] initWithTitle:@"Field empty" message:@"User name can not be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[userNameBlankAlert show];
		[userNameBlankAlert release];
										 
	}
	else
	{
		//hide save button and disable camera, image library button and textfield
		[cameraButton setEnabled:NO];
		[imageLibraryButton setEnabled:NO];
		[userNameTextField setEnabled:NO];
		[saveButton setHidden:YES];
		
		//show update label
		[updateProfileLabel setHidden:NO];
		
		appDelegate.userName=userNameTextField.text;
		appDelegate.userPhotoImage=UIImagePNGRepresentation([userPhotoImageView image]);
		
		//NSOperationQueue *opQueue=[NSOperationQueue new];
		AGiftWebService *service=[[AGiftWebService alloc] initAGiftWebService];
		[service setDelegate:self];
		[appDelegate.mainOpQueue addOperation:service];
		[service editProfileWithPhoneNumber:appDelegate.userPhoneNumber userName:appDelegate.userName profilePhoto:appDelegate.userPhotoImage];
		[service release];
		
	}

}

-(IBAction)resignKeyboard
{
	[userNameTextField resignFirstResponder];
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

#pragma mark methods
-(void)retrieveUserInfo
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[userPhotoImageView setImage:[UIImage imageWithData:appDelegate.userPhotoImage]];
	[userNameTextField setText:appDelegate.userName];
	[userPhoneNumberTextField setText:appDelegate.userPhoneNumber];
}

-(void)disableHint
{
	[hintController closeButtonPressed];
}

-(void)moveViewUpAnim
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[self.view setFrame:CGRectMake(self.view.frame.origin.x, -90, self.view.frame.size.width, self.view.frame.size.height)];
	[UIView commitAnimations];
}

-(void)moveViewDownAnim
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[UIView commitAnimations];
}

#pragma mark AGiftWebServiceDelegate
-(void)aGiftWebService:(AGiftWebService*)webService EditProfileDictionary:(NSDictionary*)respondData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	BOOL isSuccess=[(NSString*)[respondData valueForKey:@"resbool"] boolValue];
	NSString *respondMsg=[respondData valueForKey:@"errorMsg"];
	
	if(isSuccess)
	{
		//save info and go to gift
		[appDelegate saveRegisterInfo];
		
		NSString *msg=@"Profile has been updated successful";
		UIAlertView *saveImageAlert=[[UIAlertView alloc] initWithTitle:@"Update profile successful" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[saveImageAlert show];
		[saveImageAlert release];
	}
	else 
	{
		
		NSString *failMsg=@"Unable to update profile because of ";
		NSString *msg=[failMsg stringByAppendingString:respondMsg];
		
		UIAlertView *registerFailAlert=[[UIAlertView alloc] initWithTitle:@"Update profile fail" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[registerFailAlert show];
		[registerFailAlert release];
	}
	
	//unhide save button and enable camera, image library button and textfield
	[cameraButton setEnabled:YES];
	[imageLibraryButton setEnabled:YES];
	[userNameTextField setEnabled:YES];
	[saveButton setHidden:NO];
	
	//hide update label
	[updateProfileLabel setHidden:YES];
}
	
#pragma mark UI image picker controller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *selectedImage=[info objectForKey:UIImagePickerControllerEditedImage];
	[userPhotoImageView setImage:selectedImage];
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	/*
	CGRect endRect=CGRectMake(1, 170, 318, originRectTextField.size.height);
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[userNameTextField setFrame:endRect];
	[UIView commitAnimations];
	 */
	
	[self performSelector:@selector(moveViewUpAnim) withObject:nil afterDelay:0.2];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	/*
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[userNameTextField setFrame:originRectTextField];
	[UIView commitAnimations];
	 */
	
	[self performSelector:@selector(moveViewDownAnim) withObject:nil afterDelay:0.0];
}

#pragma mark touch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self resignKeyboard];
}

- (void)dealloc {
	
	[userPhotoImageView release];
	[cameraButton release];
	[imageLibraryButton release];
	[userNameLabel release];
	[userNameTextField release];
	[saveButton release];
	[updateProfileLabel release];
	[userPhoneNumberTextField release];
	[hintButton release];
	[hintController release];
	
    [super dealloc];
}


@end
