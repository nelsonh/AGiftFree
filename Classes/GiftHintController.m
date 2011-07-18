    //
//  GiftHintController.m
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftHintController.h"


@implementation GiftHintController

@synthesize closeButton;
@synthesize onGiftBoxMsgHintButton;
@synthesize onGiftMsgHintButton;
@synthesize unwrapGiftHintButton;
@synthesize gestureGiftBoxHintButton;
@synthesize onGiftBoxHintMsgTextView;
@synthesize onGiftHintMsgTextView;
@synthesize unwrapGiftHintTextView;
@synthesize gestureGiftBoxHintTextView;
@synthesize pinchInOutImageView;
@synthesize panImageView;

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
	self.onGiftBoxMsgHintButton=nil;
	self.onGiftMsgHintButton=nil;
	self.unwrapGiftHintButton=nil;
	self.gestureGiftBoxHintButton=nil;
	self.onGiftBoxHintMsgTextView=nil;
	self.onGiftHintMsgTextView=nil;
	self.unwrapGiftHintTextView=nil;
	self.gestureGiftBoxHintTextView=nil;
	self.pinchInOutImageView=nil;
	self.panImageView=nil;
	
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

-(IBAction)onGiftBoxMsgHintButtonPress
{
	[self reset];
	
	[onGiftBoxHintMsgTextView setHidden:NO];
	[onGiftBoxMsgHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)onGiftMsgHintButtonPress
{
	[self reset];
	[onGiftHintMsgTextView setHidden:NO];
	[onGiftMsgHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)unwrapGiftHintButtonPress
{
	[self reset];
	
	[unwrapGiftHintTextView setHidden:NO];
	[unwrapGiftHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)gestureGiftBoxHintButtonPress
{
	[self reset];
	
	[gestureGiftBoxHintTextView setHidden:NO];
	[pinchInOutImageView setHidden:NO];
	[panImageView setHidden:NO];
	[gestureGiftBoxHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(void)reset
{
	[onGiftBoxHintMsgTextView setHidden:YES];
	[onGiftHintMsgTextView setHidden:YES];
	[unwrapGiftHintTextView setHidden:YES];
	[gestureGiftBoxHintTextView setHidden:YES];
	[pinchInOutImageView setHidden:YES];
	[panImageView setHidden:YES];
	[onGiftBoxMsgHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[onGiftMsgHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[unwrapGiftHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[gestureGiftBoxHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
}


- (void)dealloc {
	
	[closeButton release];
	[onGiftBoxMsgHintButton release];
	[onGiftMsgHintButton release];
	[unwrapGiftHintButton release];
	[gestureGiftBoxHintButton release];
	[onGiftBoxHintMsgTextView release];
	[onGiftHintMsgTextView release];
	[unwrapGiftHintTextView release];
	[gestureGiftBoxHintTextView release];
	[pinchInOutImageView release];
	[panImageView release];
	
    [super dealloc];
}


@end
