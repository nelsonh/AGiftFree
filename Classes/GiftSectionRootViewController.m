//
//  GiftSectionRootViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftSectionRootViewController.h"
#import "NewGiftTableController.h"
#import "OldGiftTableController.h"


@implementation GiftSectionRootViewController

@synthesize segmentedController;
@synthesize newGiftViewController;
@synthesize oldGiftViewController;
@synthesize viewControllers;


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
	NSArray *segmentedButtonText=[[NSArray alloc] initWithObjects:@"New", @"Old", nil];
	segmentedController=[[UISegmentedControl alloc] initWithItems:segmentedButtonText];
	
	[segmentedController setSelectedSegmentIndex:0];
	[segmentedController setSegmentedControlStyle:UISegmentedControlStyleBar];
	[segmentedController setFrame:CGRectMake(0, 0, 125, 30)];
	[segmentedController addTarget:self action:@selector(toggleView:) forControlEvents:UIControlEventValueChanged];
	
	[self.navigationItem setTitleView:segmentedController];
	
	[segmentedButtonText release];
	
	//view controllers array
	viewControllers=[[NSArray alloc] initWithObjects:newGiftViewController, oldGiftViewController, nil];
	
	//insert init view
	[self.view insertSubview:newGiftViewController.view atIndex:0];
	
	//self.navigationItem.title=@"Root";
	
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
	
	self.newGiftViewController=nil;
	self.oldGiftViewController=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark moethods
-(void)toggleView:(id)sender
{
	UISegmentedControl *segmentedControl=sender;
	NSUInteger currentPage=[segmentedControl selectedSegmentIndex];
	UIViewController *selectedController=[viewControllers objectAtIndex:currentPage];
	
	for(int i=0; i<[[self.view subviews] count]; i++)
	{
		[(UIView*)[[self.view subviews] objectAtIndex:i] removeFromSuperview];
	}
	
	if([selectedController isKindOfClass:[OldGiftTableController class]])
	{
		[(OldGiftTableController*)selectedController disableHint];
		[(OldGiftTableController*)selectedController reloadSourceData];
	}
	
	if([selectedController isKindOfClass:[NewGiftTableController class]])
	{
		[(NewGiftTableController*)selectedController disableHint];
		[(NewGiftTableController*)selectedController reloadSourceData];
	}
	
	[self.view insertSubview:selectedController.view atIndex:0];
}

-(void)updateViewControllers
{
	
	NSUInteger currentPage=[segmentedController selectedSegmentIndex];
	UIViewController *selectedController=[viewControllers objectAtIndex:currentPage];
	
	if([selectedController isKindOfClass:[OldGiftTableController class]])
	{
		[(OldGiftTableController*)selectedController reloadSourceData];
	}
	else if([selectedController isKindOfClass:[NewGiftTableController class]])
	{
		[(NewGiftTableController*)selectedController reloadSourceData];
	}
}

#pragma mark  UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if([viewController isKindOfClass:[GiftSectionRootViewController class]])
	{
		NSUInteger currentPage=[segmentedController selectedSegmentIndex];
		UIViewController *currentController=[viewControllers objectAtIndex:currentPage];
		
		if([currentController isKindOfClass:[NewGiftTableController class]])
		{
			[(NewGiftTableController*)currentController reloadSourceData];
		}
		else if([currentController isKindOfClass:[OldGiftTableController class]])
		{
			[(OldGiftTableController*)currentController reloadSourceData];
		}
	}
}

-(void)viewWillAppear:(BOOL)animated
{
	NSUInteger currentPage=[segmentedController selectedSegmentIndex];
	UIViewController *selectedController=[viewControllers objectAtIndex:currentPage];
	
	if([selectedController isKindOfClass:[OldGiftTableController class]])
	{
		[(OldGiftTableController*)selectedController reloadSourceData];
	}
	
	if([selectedController isKindOfClass:[NewGiftTableController class]])
	{
		[(NewGiftTableController*)selectedController reloadSourceData];
	}

}

- (void)dealloc {
	
	[segmentedController release];
	[newGiftViewController release];
	[oldGiftViewController release];
	[viewControllers release];
    [super dealloc];
}


@end
