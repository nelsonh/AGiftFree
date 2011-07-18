    //
//  UserPhotoSettingHintController.m
//  AGiftFree
//
//  Created by Nelson on 5/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "UserPhotoSettingHintController.h"


@implementation UserPhotoSettingHintController

@synthesize closeButton;
@synthesize avaterHintButton;
@synthesize cameraHintButton;
@synthesize imageLibraryHintButton;
@synthesize displayNameHintButton;
@synthesize saveHintButton;
@synthesize avaterHintTextView;
@synthesize cameraHintTextView;
@synthesize imageLibraryHintTextView;
@synthesize displayNameHintTextView;
@synthesize saveHintTextView;
@synthesize currentShowedTextView;


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
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
	
	self.closeButton=nil;
	self.avaterHintButton=nil;
	self.cameraHintButton=nil;
	self.imageLibraryHintButton=nil;
	self.displayNameHintButton=nil;
	self.saveHintButton=nil;
	self.avaterHintTextView=nil;
	self.cameraHintTextView=nil;
	self.imageLibraryHintTextView=nil;
	self.displayNameHintTextView=nil;
	self.saveHintTextView=nil;

	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)closeButtonPressed
{
	[self reset];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.superview cache:YES];
	[UIView setAnimationDuration:1.0];
	
	[self.view removeFromSuperview];
	
	[UIView commitAnimations];
}

-(IBAction)avaterHintButtonPressed
{
	[self reset];
	
	[avaterHintTextView setHidden:NO];
	[avaterHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)cameraHintButtonPressed
{
	[self reset];
	
	[cameraHintTextView setHidden:NO];
	[cameraHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)imageLibraryHintButtonPressed
{
	[self reset];
	
	[imageLibraryHintTextView setHidden:NO];
	[imageLibraryHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)displayNameHintButtonPressed
{
	[self reset];
	
	[displayNameHintTextView setHidden:NO];
	[displayNameHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)saveHintButtonPressed
{
	[self reset];
	
	[saveHintTextView setHidden:NO];
	[saveHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(void)reset
{
	[avaterHintTextView setHidden:YES];
	[cameraHintTextView setHidden:YES];
	[imageLibraryHintTextView setHidden:YES];
	[displayNameHintTextView setHidden:YES];
	[saveHintTextView setHidden:YES];
	[avaterHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[cameraHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[imageLibraryHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[displayNameHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[saveHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
}


- (void)dealloc {
	
	[closeButton release];
	[avaterHintButton release];
	[cameraHintButton release];
	[imageLibraryHintButton release];
	[displayNameHintButton release];
	[saveHintButton release];
	[avaterHintTextView release];
	[cameraHintTextView release];
	[imageLibraryHintTextView release];
	[displayNameHintTextView release];
	[saveHintTextView release];
	[currentShowedTextView release];

	
    [super dealloc];
}


@end
