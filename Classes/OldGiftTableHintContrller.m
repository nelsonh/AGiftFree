    //
//  OldGiftTableHintContrller.m
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "OldGiftTableHintContrller.h"


@implementation OldGiftTableHintContrller

@synthesize closeButton;
@synthesize areaFrameImageView;
@synthesize tableHintButton;
//@synthesize tableHintTextView;
@synthesize cellExampleImageView;
@synthesize cellHintTextView;
@synthesize giftIconImageView;
@synthesize giftIconTextView;

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
	self.areaFrameImageView=nil;
	self.tableHintButton=nil;
	//self.tableHintTextView=nil;
	self.cellExampleImageView=nil;
	self.cellHintTextView=nil;
	self.giftIconImageView=nil;
	self.giftIconTextView=nil;
	
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

-(IBAction)tableHintButtonPress
{
	[self reset];
	
	[areaFrameImageView setHidden:NO];
	//[tableHintTextView setHidden:NO];
	[cellExampleImageView setHidden:NO];
	[cellHintTextView setHidden:NO];
	[giftIconImageView setHidden:NO];
	[giftIconTextView setHidden:NO];
	[tableHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(void)reset
{
	[areaFrameImageView setHidden:YES];
	//[tableHintTextView setHidden:YES];
	[cellExampleImageView setHidden:YES];
	[cellHintTextView setHidden:YES];
	[giftIconImageView setHidden:YES];
	[giftIconTextView setHidden:YES];
	[tableHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
}


- (void)dealloc {
	
	[closeButton release];
	[areaFrameImageView release];
	[tableHintButton release];
	//[tableHintTextView release];
	[cellExampleImageView release];
	[cellHintTextView release];
	[giftIconImageView release];
	[giftIconTextView release];
	
    [super dealloc];
}


@end
