//
//  GiftSectionViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftSectionViewController.h"
#import "GiftSectionRootViewController.h"
#import "NewGiftTableController.h"
#import "OldGiftTableController.h"

@implementation GiftSectionViewController

@synthesize soundPlayer;

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
	
	GiftSectionRootViewController *rootViewController=[[GiftSectionRootViewController alloc] initWithNibName:@"GiftSectionRootViewController" bundle:nil];
	NSArray *viewControllerArray=[[NSArray alloc] initWithObjects:rootViewController, nil];
	
	[self setViewControllers:viewControllerArray];
	[self setDelegate:rootViewController];
	
	[rootViewController release];
	[viewControllerArray release];
	
	[self.navigationBar setTintColor:[UIColor colorWithRed:87.0f/255.0f green:126.0f/255.0f blue:159.0f/255.0f alpha:1.0f]];
	
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
	
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)playSoundWithData:(NSData*)soundData
{
	NSError *error;
	
	
	
	if(soundPlayer!=nil)
	{
		[self stopPlayingSound];
		self.soundPlayer=nil;
	}
	
	AVAudioPlayer *musicPlayer=[[AVAudioPlayer alloc] initWithData:soundData error:&error];
	self.soundPlayer=musicPlayer;
	[musicPlayer release];
	[soundPlayer prepareToPlay];
	[soundPlayer play];
}

-(void)stopPlayingSound
{
	if([soundPlayer isPlaying])
	{
		[soundPlayer stop];
	}
}

-(void)removeController:(Class)controllerClass
{
	NSMutableArray *listOfController=[[[NSMutableArray alloc] init] autorelease];
	
	for(int i=0; i<[self.viewControllers count]; i++)
	{
		UIViewController *controller=[self.viewControllers objectAtIndex:i];
		
		if(![controller isKindOfClass:controllerClass])
		{
			[listOfController addObject:controller];
		}
	}
	
	[self setViewControllers:listOfController];
}

#pragma mark mutitask protocol
-(void)update
{
	if([self.topViewController isKindOfClass:[GiftSectionRootViewController class]])
	{
		[(GiftSectionRootViewController*)self.topViewController updateViewControllers];
	}
}


- (void)dealloc {
	
	if(soundPlayer!=nil)
		self.soundPlayer=nil;
	
    [super dealloc];
}


@end
