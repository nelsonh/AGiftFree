//
//  GiftMessageAfterViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftMessageAfterIndividualViewController.h"


@implementation GiftMessageAfterIndividualViewController

@synthesize senderImageView;
//@synthesize senderNameLabel;
@synthesize dismissButton;
@synthesize envelopImageView;
@synthesize messageTextView;
@synthesize activityView;
@synthesize giftItem;
@synthesize sound;
@synthesize soundPlayer;
@synthesize canDismiss;
@synthesize downloadConnection;
@synthesize senderTempPhoto;
@synthesize enablePerformActionWhenDismiss;

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
	
	//NSError *error;
	
	//load sender photo
	/*
	//thread to load sender photo avoid freezing
	NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadSenderPhotoWithURL:) object:giftItem.senderPicURL];
	[opQueue addOperation:operation];
	[operation release];
	 */
	
	[senderImageView.layer setCornerRadius:7.0f];
	[senderImageView.layer setMasksToBounds:YES];
	
	if([giftItem.senderPicURL isEqualToString:@"Anonymous"])
	{
		[senderImageView setImage:[UIImage imageNamed:@"AUser2.png"]];
	}
	else 
	{
		[activityView startAnimating];
		
		NSMutableData *senderPhotoData=[[NSMutableData alloc] init];
		self.senderTempPhoto=senderPhotoData;
		[senderPhotoData release];
		
		NSURL *url=[NSURL URLWithString:giftItem.senderPicURL];
		NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
		NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
		self.downloadConnection=connection;
		[connection release];
	}

	
	//[senderNameLabel setText:giftItem.senderName];
	
	if([giftItem.giftAfterText isEqualToString:@""])
	{
		self.messageTextView.text=@"You have no text message";
	}
	else 
	{
		self.messageTextView.text=giftItem.giftAfterText;
	}

	
	/*
	if(giftItem.giftSound!=nil)
	{
		
		soundPlayer=[[AVAudioPlayer alloc] initWithData:giftItem.giftSound error:&error];
		[soundPlayer setNumberOfLoops:1];
		[soundPlayer play];
	}
	 */
	
	/*
	//rotate sender photo by 15 degree
	[senderImageView setTransform:CGAffineTransformMakeRotation(-15*(3.14159/180))];
	 */
	
    [super viewDidLoad];
}

#pragma mark NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[senderTempPhoto appendData:data];
	
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{	
	
	[senderImageView setImage:[UIImage imageWithData:senderTempPhoto]];
	[activityView stopAnimating];
	
	canDismiss=YES;
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
	
	self.senderImageView=nil;
	//self.senderNameLabel=nil;
	self.dismissButton=nil;
	self.envelopImageView=nil;
	self.messageTextView=nil;
	self.activityView=nil;;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark IBAction methods

-(IBAction)dismissButtonPress
{
	/*
	if(canDismiss)
	{
		[self dismissModalViewControllerAnimated:YES];
	}
	else 
	{
		UIAlertView *loadingAlert=[[UIAlertView alloc] initWithTitle:@"Loading not complete" message:@"Please wait for loading finish" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[loadingAlert show];
		[loadingAlert release];
	}
	 */
	
	//[self dismissModalViewControllerAnimated:YES];
	[self.view removeFromSuperview];
}

#pragma mark methods
-(void)performAcionWhenDismissWithTarget:(id)target Action:(SEL)action
{
	performTarget=target;
	performAction=action;
}

-(void)loadSenderPhotoWithURL:(id)object
{
	NSString *photoURL=object;
	
	[activityView startAnimating];
	
	NSData *senderPhoto=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photoURL]];
	
	[activityView stopAnimating];
	
	
	[senderImageView setImage:[UIImage imageWithData:senderPhoto]];
	
	[senderPhoto release];
	
	canDismiss=YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
	if(enablePerformActionWhenDismiss)
	{
		if(performTarget!=nil && performAction!=nil)
			[performTarget performSelector:performAction];

	}
}

- (void)dealloc {
	
	[senderImageView release];
	//[senderNameLabel release];
	[dismissButton release];
	[envelopImageView release];
	[messageTextView release];
	[sound release];
	
	if(senderTempPhoto!=nil)
		[senderTempPhoto release];
	
	if(downloadConnection)
	{
		//[downloadConnection cancel];
		self.downloadConnection=nil;
	}
	
	if(soundPlayer!=nil)
		[soundPlayer release];
	
    [super dealloc];
}


@end
