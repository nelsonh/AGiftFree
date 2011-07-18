//
//  OldGiftEditController.m
//  AGiftFree
//
//  Created by Nelson on 5/16/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "OldGiftEditController.h"


@implementation OldGiftEditController

@synthesize deleteButton;
@synthesize neverDeleteButton;
@synthesize autoDeleteButton;
@synthesize confirmButton;

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark IBAction Method
-(IBAction)deleteButtonPress
{
}

-(IBAction)neverDeleteButtonPress
{
}

-(IBAction)autoDeleteButtonPress
{
}

-(IBAction)confirmButtonPress
{
}


- (void)dealloc {
	
	[deleteButton release];
	[neverDeleteButton release];
	[autoDeleteButton release];
	[confirmButton release];
	
    [super dealloc];
}


@end
