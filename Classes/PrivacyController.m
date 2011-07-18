    //
//  PrivacyController.m
//  AGiftFree
//
//  Created by Nelson on 5/31/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "PrivacyController.h"


@implementation PrivacyController

@synthesize allowButtton;
@synthesize topTextView;
@synthesize middleTextView;
@synthesize buttomTextView;

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
	
	[topTextView setFont:[UIFont systemFontOfSize:kFontSize]];
	[middleTextView setFont:[UIFont systemFontOfSize:kFontSize]];
	[buttomTextView setFont:[UIFont systemFontOfSize:kFontSize]];
	
	
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
	
	self.allowButtton=nil;
	self.topTextView=nil;
	self.middleTextView=nil;
	self.buttomTextView=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)allowButttonPress
{
	[self dismissModalViewControllerAnimated:YES];
}



- (void)dealloc {
	
	[allowButtton release];
	[topTextView release];
	[middleTextView release];
	[buttomTextView release];
	
    [super dealloc];
}


@end
