//
//  UserSectionVeiwController.m
//  AGiftFree
//
//  Created by Nelson on 3/1/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "UserSectionVeiwController.h"
#import "UserSectionRootViewController.h"


@implementation UserSectionVeiwController

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
	
	UserSectionRootViewController *rootViewController=[[UserSectionRootViewController alloc] initWithNibName:@"UserSectionRootViewController" bundle:nil];
	NSArray *viewControllerArray=[[NSArray alloc] initWithObjects:rootViewController, nil];
	
	[self setViewControllers:viewControllerArray];
	
	[rootViewController release];
	[viewControllerArray release];
	
	[self.navigationBar setTintColor:[UIColor colorWithRed:87.0f/255.0f green:126.0f/255.0f blue:159.0f/255.0f alpha:1.0f]];
	
    [super viewDidLoad];
}

-(void)update
{
	if([self.topViewController isKindOfClass:[UserSectionRootViewController class]])
	{
		[(UserSectionRootViewController*)self.topViewController updateCurrentChildView];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
