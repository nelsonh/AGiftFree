    //
//  GiftCollectionHintController.m
//  AGiftFree
//
//  Created by Nelson on 5/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftCollectionHintController.h"


@implementation GiftCollectionHintController

@synthesize closeButton;
@synthesize editHintButton;
@synthesize giftCollectionHintButton;
@synthesize editHintTextView;
@synthesize receiveTimeHintTextView;
@synthesize autoDeletionHintTextView;
@synthesize onGiftBoxMsgHintTextView;
//@synthesize giftCollectionHintTextView;
@synthesize areaFrameImageView;
@synthesize receiveTimeIcon;
@synthesize autoDeletionIcon;
@synthesize onGiftBoxMsgIcon;
@synthesize collectionCellImageView;


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
	self.editHintButton=nil;
	self.giftCollectionHintButton=nil;
	self.editHintTextView=nil;
	self.receiveTimeHintTextView=nil;
	self.autoDeletionHintTextView=nil;
	self.onGiftBoxMsgHintTextView=nil;
	//self.giftCollectionHintTextView=nil;
	self.areaFrameImageView=nil;
	self.receiveTimeIcon=nil;
	self.autoDeletionIcon=nil;
	self.onGiftBoxMsgIcon=nil;
	self.collectionCellImageView=nil;
	
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

-(IBAction)editHintButtonPress
{
	[self reset];
	
	[editHintTextView setHidden:NO];
	[editHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(IBAction)giftCollectionHintButtonPress
{
	[self reset];
	

	[receiveTimeHintTextView setHidden:NO];
	[autoDeletionHintTextView setHidden:NO];
	[onGiftBoxMsgHintTextView setHidden:NO];
	//[giftCollectionHintTextView setHidden:NO];
	[areaFrameImageView setHidden:NO];
	[receiveTimeIcon setHidden:NO];
	[autoDeletionIcon setHidden:NO];
	[onGiftBoxMsgIcon setHidden:NO];
	[collectionCellImageView setHidden:NO];
	
	[giftCollectionHintButton setImage:[UIImage imageNamed:@"Question2.png"] forState:UIControlStateNormal];
}

-(void)reset
{
	[editHintTextView setHidden:YES];
	[receiveTimeHintTextView setHidden:YES];
	[autoDeletionHintTextView setHidden:YES];
	[onGiftBoxMsgHintTextView setHidden:YES];
	//[giftCollectionHintTextView setHidden:YES];
	[areaFrameImageView setHidden:YES];
	[receiveTimeIcon setHidden:YES];
	[autoDeletionIcon setHidden:YES];
	[onGiftBoxMsgIcon setHidden:YES];
	[collectionCellImageView setHidden:YES];
	[editHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
	[giftCollectionHintButton setImage:[UIImage imageNamed:@"Question.png"] forState:UIControlStateNormal];
}


- (void)dealloc {
	
	[closeButton release];
	[editHintButton release];
	[giftCollectionHintButton release];
	[editHintTextView release];
	[receiveTimeHintTextView release];
	[autoDeletionHintTextView release];
	[onGiftBoxMsgHintTextView release];
	[areaFrameImageView release];
	[receiveTimeIcon release];
	[autoDeletionIcon release];
	[onGiftBoxMsgIcon release];
	[collectionCellImageView release];
	
    [super dealloc];
}


@end
