    //
//  RegisterHintController.m
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "RegisterHintController.h"


@implementation RegisterHintController

@synthesize closeButton;
@synthesize avaterPhotoHintButton;
@synthesize cameraHintButton;
@synthesize photoLibraryHintButton;
@synthesize areaCodeHintButton;
@synthesize phoneNumberHintButton;
@synthesize displayNameHintButton;
@synthesize avaterPhotoHintTextView;
@synthesize cameraHintTextView;
@synthesize photoLibraryHintTextView;
@synthesize areaCodeHintTextView;
@synthesize phoneNumberHintTextView;
@synthesize displayNameHintTextView;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	
	self.closeButton=nil;
	self.avaterPhotoHintButton=nil;
	self.cameraHintButton=nil;
	self.photoLibraryHintButton=nil;
	self.areaCodeHintButton=nil;
	self.phoneNumberHintButton=nil;
	self.displayNameHintButton=nil;
	self.avaterPhotoHintTextView=nil;
	self.cameraHintTextView=nil;
	self.photoLibraryHintTextView=nil;
	self.areaCodeHintTextView=nil;
	self.phoneNumberHintTextView=nil;
	self.displayNameHintTextView=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)closeButtonPress
{
	[self reset];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.superview cache:YES];
	[UIView setAnimationDuration:1.0];
	
	[self.view removeFromSuperview];
	
	[UIView commitAnimations];
}

-(IBAction)avaterPhotoHintButtonPress
{
	[self reset];
	
	[avaterPhotoHintTextView setHidden:NO];
	[avaterPhotoHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)cameraHintButtonPress
{
	[self reset];
	
	[cameraHintTextView setHidden:NO];
	[cameraHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)photoLibraryHintButtonPress
{
	[self reset];
	
	[photoLibraryHintTextView setHidden:NO];
	[photoLibraryHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)areaCodeHintButtonPress
{
	[self reset];
	
	[areaCodeHintTextView setHidden:NO];
	[areaCodeHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)phoneNumberHintButtonPress
{
	[self reset];
	
	[phoneNumberHintTextView setHidden:NO];
	[phoneNumberHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)displayNameHintButtonPress
{
	[self reset];
	
	[displayNameHintTextView setHidden:NO];
	[displayNameHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(void)reset
{
	[avaterPhotoHintTextView setHidden:YES];
	[cameraHintTextView setHidden:YES];
	[photoLibraryHintTextView setHidden:YES];
	[areaCodeHintTextView setHidden:YES];
	[phoneNumberHintTextView setHidden:YES];
	[displayNameHintTextView setHidden:YES];
	[avaterPhotoHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[cameraHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[photoLibraryHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[areaCodeHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[phoneNumberHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[displayNameHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
}


- (void)dealloc {
	
	[closeButton release];
	[avaterPhotoHintButton release];
	[cameraHintButton release];
	[photoLibraryHintButton release];
	[areaCodeHintButton release];
	[phoneNumberHintButton release];
	[displayNameHintButton release];
	[avaterPhotoHintTextView release];
	[cameraHintTextView release];
	[photoLibraryHintTextView release];
	[areaCodeHintTextView release];
	[phoneNumberHintTextView release];
	[displayNameHintTextView release];
	
    [super dealloc];
}


@end
