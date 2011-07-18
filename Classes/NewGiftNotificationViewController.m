//
//  NewGiftNotificationView.m
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "NewGiftNotificationViewController.h"
#import "AGiftFreeAppDelegate.h"


@implementation NewGiftNotificationViewController

@synthesize animationImageView;
@synthesize gotGiftMsgImageView;
@synthesize noGiftMsgImageView;
@synthesize openButton;
@synthesize animationSlide;
@synthesize hasNewGifts;
@synthesize musicPlayer;

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
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if(hasNewGifts)
	{
		[noGiftMsgImageView setHidden:YES];
		
		//has new gift set animation
		NSString *animationPath=[[NSBundle mainBundle] pathForResource:@"Animation" ofType:@"plist"];
		NSArray *animationImagesFileName=[[NSArray alloc] initWithContentsOfFile:animationPath];
		NSMutableArray *animationImages=[[NSMutableArray alloc] init];
		
		for(int i=0; i<[animationImagesFileName count]; i++)
		{
			UIImage *image=[UIImage imageNamed:[animationImagesFileName objectAtIndex:i]];
			[animationImages addObject:image];
		}
		
		[animationImageView setAnimationImages:animationImages];
		[animationImageView setAnimationDuration:0.5];
		[animationImageView startAnimating];
		
		[animationImagesFileName release];
		[animationImages release];
		
		//anim effect
		[gotGiftMsgImageView setTransform:CGAffineTransformMakeRotation(0.2)];
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationRepeatAutoreverses:YES];
		[UIView setAnimationRepeatCount:INFINITY];
		[gotGiftMsgImageView setTransform:CGAffineTransformMakeRotation(-0.2)];
		[UIView commitAnimations];
		
		CGSize btnSize=[UIImage imageNamed:@"funwrapgift.png"].size;
		[openButton setImage:[UIImage imageNamed:@"funwrapgift.png"] forState:UIControlStateNormal];
		[openButton setFrame:CGRectMake(320/2-btnSize.width/2, 352, btnSize.width, btnSize.height)];
		
		
		//[openButton setTransform:CGAffineTransformMakeRotation(-0.3)];
	}
	else
	{
		//no new gift change image to another
		[noGiftMsgImageView setHidden:NO];
		[gotGiftMsgImageView setHidden:YES];
		[animationImageView setImage:[UIImage imageNamed:@"gift1.png"]];
		//[openButton setTransform:CGAffineTransformMakeRotation(-0.3)];
		
		
		CGSize btnSize=[UIImage imageNamed:@"fenter.png"].size;
		[openButton setImage:[UIImage imageNamed:@"fenter.png"] forState:UIControlStateNormal];
		[openButton setFrame:CGRectMake(320/2-btnSize.width/2, 250, btnSize.width, btnSize.height)];
	}
	
	appDelegate.backViewController.backImageView.image=nil;

	
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
	
	self.animationImageView=nil;
	self.gotGiftMsgImageView=nil;
	self.noGiftMsgImageView=nil;
	self.openButton=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated
{
	if(hasNewGifts)
	{
		//play got gift music
		NSString *bundleResourcePath=[[NSBundle mainBundle] pathForResource:@"Gotgift" ofType:@"mp3"];
		NSURL *musicURL;
		
		NSError *error;
		
		if(bundleResourcePath)
		{
			musicURL=[NSURL fileURLWithPath:bundleResourcePath];
		}
		
		AVAudioSession *audioSession=[AVAudioSession sharedInstance];
		[audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
		
		AVAudioPlayer *player=[[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
		[player setCurrentTime:0.0f];
		[player prepareToPlay];
		self.musicPlayer=player;
		[musicPlayer play];
		
		[player release];
	}
}

#pragma mark IBAction methods
-(IBAction)openButtonPress
{
	//tell window to add AGift view
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	[appDelegate presentAGiftRootView];
	[self dismissModalViewControllerAnimated:YES];
	
	if(musicPlayer)
	{
		if([musicPlayer isPlaying])
		{
			[musicPlayer stop];
		}
	}
	
}


- (void)dealloc {
	
	[animationImageView release];
	[gotGiftMsgImageView release];
	[noGiftMsgImageView release];
	[openButton release];
	[animationSlide release];
	
	if(musicPlayer)
		[musicPlayer release];
	
    [super dealloc];
}


@end
