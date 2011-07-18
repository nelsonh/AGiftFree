//
//  UserSectionView.m
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "UserSectionRootViewController.h"
#import "UserPhotoSettingViewController.h"
#import "UserSettingViewController.h"


@implementation UserSectionRootViewController

@synthesize userPhotoViewController;
@synthesize userSettingViewController;
@synthesize viewContainer;
@synthesize segmentedController;

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
	
	//programmatically create uisegmentedcontrol and add it to navigation bar
	NSArray *segmentedButtonText=[[NSArray alloc] initWithObjects:@"User", @"Setting", nil];
	segmentedController=[[UISegmentedControl alloc] initWithItems:segmentedButtonText];
	
	[segmentedController setSelectedSegmentIndex:0];
	[segmentedController setSegmentedControlStyle:UISegmentedControlStyleBar];
	[segmentedController setFrame:CGRectMake(0, 0, 125, 30)];
	[segmentedController addTarget:self action:@selector(toggleView:) forControlEvents:UIControlEventValueChanged];
	
	[self.navigationItem setTitleView:segmentedController];
	
	[segmentedButtonText release];
	
	[userPhotoViewController retrieveUserInfo];
	
	//insert user photo view
	[self.view insertSubview:userPhotoViewController.view atIndex:0];
	
	viewContainer=[[NSArray alloc] initWithObjects:userPhotoViewController, userSettingViewController, nil];
	
    [super viewDidLoad];
}

-(void)updateCurrentChildView
{
	NSUInteger currentPage=[segmentedController selectedSegmentIndex];
	UIViewController *selectedViewController=[viewContainer objectAtIndex:currentPage];

	if([selectedViewController isKindOfClass:[UserPhotoSettingViewController class]])
	{
		[(UserPhotoSettingViewController*)selectedViewController retrieveUserInfo];
	}
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
	
	self.userPhotoViewController=nil;
	self.userSettingViewController=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark IBAction methods
-(IBAction)toggleView:(id)sender
{
	UISegmentedControl *segmentedControl=sender;
	NSUInteger currentPage=[segmentedControl selectedSegmentIndex];
	UIViewController *selectedViewController=[viewContainer objectAtIndex:currentPage];
	
	//run through subviews and remove them
	for(int i=0; i<[[self.view subviews] count]; i++)
	{
		[(UIView*)[[self.view subviews] objectAtIndex:i] removeFromSuperview];
	}
	
	if([selectedViewController isKindOfClass:[UserPhotoSettingViewController class]])
	{
		[(UserPhotoSettingViewController*)selectedViewController retrieveUserInfo];
	}
	
	//disable hint for each view
	for(UIViewController *controller in viewContainer)
	{
		if([controller isKindOfClass:[UserPhotoSettingViewController class]])
		{
			[(UserPhotoSettingViewController*)controller disableHint];
		}
		else if([controller isKindOfClass:[userSettingViewController class]])
		{
			[(UserSettingViewController*)controller disableHint];
		}
	}
	
	//insert new selected view
	[self.view insertSubview:selectedViewController.view atIndex:0];
}


- (void)dealloc {
    
	[userPhotoViewController release];
	[userSettingViewController release];
	[viewContainer release];
	[segmentedController release];
	
	[super dealloc];
}


@end
