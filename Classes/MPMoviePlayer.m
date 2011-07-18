//
//  MPMoviePlayer.m
//  AGiftFree
//
//  Created by Nelson on 3/2/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "MPMoviePlayer.h"
#import "AGiftFreeAppDelegate.h"

@implementation MPMoviePlayer



- (id)initWithContentURL:(NSURL *)contentURL Target:(id)target Action:(SEL)action;
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	
	performTarget=target;
	perfromAction=action;
	

	
	return [self initWithContentURL:contentURL];
}

- (id)initWithContentURL:(NSURL *)url
{
	return [super initWithContentURL:url];
}

- (void)setFullscreen:(BOOL)fullscreen animated:(BOOL)animated
{
}


-(void)videoDidFinished:(NSNotification*)notification
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	
	/*
	[self dismissModalViewControllerAnimated:YES];
	 */
	
	[self.view removeFromSuperview];
	
	[appDelegate.window sendSubviewToBack:appDelegate.backViewController.view];
	[appDelegate.backViewController.view setAlpha:1.0];
	
	if(performTarget!=nil && perfromAction!=nil)
		[performTarget performSelector:perfromAction];
}

- (void)viewDidDisappear:(BOOL)animated
{	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate.window sendSubviewToBack:appDelegate.backViewController.view];
	[appDelegate.backViewController.view setAlpha:1.0];
	
	if(performTarget!=nil && perfromAction!=nil)
		[performTarget performSelector:perfromAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
