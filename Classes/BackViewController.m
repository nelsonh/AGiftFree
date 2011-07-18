    //
//  BackViewController.m
//  AGiftFree
//
//  Created by Nelson on 3/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "BackViewController.h"


@implementation BackViewController

@synthesize statusView;
@synthesize backImageView;
@synthesize statusMessageLable;

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
	
	[statusView.layer setCornerRadius:10.0f];
	[statusView.layer setMasksToBounds:YES];
	
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
	
	self.statusView=nil;
	self.backImageView=nil;
	self.statusMessageLable=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)changeStatusMessage:(NSString*)msg
{
	[self performSelectorOnMainThread:@selector(doChangeStatusMessage:) withObject:msg waitUntilDone:NO];
}

-(void)doChangeStatusMessage:(id)object
{
	NSString *msg=object;
	
	[statusMessageLable setText:msg];
}


- (void)dealloc {
	
	[statusView release];
	[backImageView release];
	[statusMessageLable release];
	
    [super dealloc];
}


@end
