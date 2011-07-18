//
//  GiftMessageBeforeViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftMessageBeforeIndividualViewController.h"
#import "AGiftFreeAppDelegate.h"


@implementation GiftMessageBeforeIndividualViewController

@synthesize senderImageView;
@synthesize senderNameLabel;
@synthesize dismissButton;
@synthesize toLabel;
@synthesize messageTextView;
@synthesize pictureImageView;
@synthesize activityView;
@synthesize giftItem;
@synthesize downloadConnection;
@synthesize senderTempPhoto;
@synthesize canDismiss;
@synthesize messageView;
@synthesize letterButton;
@synthesize isShowMessage;
@synthesize messageViewCenter;
@synthesize receiverNameLabel;

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
	
	//load sender photo
	/*
	//thread to load sender photo avoid freezing
	NSOperationQueue *opQueue=[[NSOperationQueue new] autorelease];
	NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadSenderPhotoWithURL:) object:giftItem.senderPicURL];
	[opQueue addOperation:operation];
	[operation release];
	 */
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[messageView.layer setCornerRadius:7.0f];
	[messageView.layer setMasksToBounds:YES];
	
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

	
	[senderNameLabel setText:giftItem.senderName];
	[receiverNameLabel setText:appDelegate.userName];
	
	if([giftItem.giftBeforeText isEqualToString:@""])
	{
		self.messageTextView.text=@"You have no text message";
	}
	else 
	{
		messageTextView.text=giftItem.giftBeforeText;
	}

	
	[pictureImageView setImage:[UIImage imageWithData:giftItem.giftPhoto]];
	
	if(giftItem.giftPhoto==nil && ![giftItem.giftBeforeText isEqualToString:@""])
	{
		[letterButton setEnabled:NO];
		[letterButton setImage:[UIImage imageNamed:@"Letter20.png"] forState:UIControlStateNormal];
	}
	else if(giftItem.giftPhoto!=nil && [giftItem.giftBeforeText isEqualToString:@""])
	{
		[letterButton setEnabled:NO];
		[letterButton setImage:[UIImage imageNamed:@"Letter20.png"] forState:UIControlStateNormal];
		[messageView setHidden:YES];
	}
	else 
	{
		[letterButton setEnabled:YES];
		[letterButton setImage:[UIImage imageNamed:@"Letter02.png"] forState:UIControlStateNormal];
		
		[messageView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
		
		//assign pic
		[pictureImageView setImage:[UIImage imageWithData:giftItem.giftPhoto]];
	}
	
	messageViewCenter=messageView.center;
	
	self.isShowMessage=YES;
	
	/*
	//start anim
	[messageView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:startAnimSpeed];
	[messageView setTransform:CGAffineTransformMakeScale(1, 1)];
	[UIView commitAnimations];
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
	self.senderNameLabel=nil;
	self.dismissButton=nil;
	self.toLabel=nil;
	self.messageTextView=nil;
	self.pictureImageView=nil;
	self.activityView=nil;
	self.messageView=nil;
	self.letterButton=nil;
	self.receiverNameLabel=nil;
	
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

-(IBAction)letterButtonPress
{
	if(isShowMessage)
	{
		CABasicAnimation *moveAnim=[CABasicAnimation animationWithKeyPath:@"position"];
		[moveAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(letterButton.center.x, letterButton.center.y)]];
		[moveAnim setRemovedOnCompletion:YES];
		
		CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
		[scaleAnim setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
		[scaleAnim setRemovedOnCompletion:YES];
		
		CAAnimationGroup *minimizeAnimGroup=[CAAnimationGroup animation];
		[minimizeAnimGroup setAnimations:[NSArray arrayWithObjects:moveAnim, scaleAnim, nil]];
		[minimizeAnimGroup setDelegate:self];
		[minimizeAnimGroup setDuration:animSpeed];
		
		[messageView.layer addAnimation:minimizeAnimGroup forKey:nil];
		
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:animSpeed];
		[messageView setAlpha:0];
		[UIView commitAnimations];
		 
	}
	else 
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:animSpeed];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(maximizeAnimDidFinish)];
		[messageView setTransform:CGAffineTransformMakeScale(1, 1)];
		[messageView setCenter:messageViewCenter];
		[messageView setAlpha:1];
		[UIView commitAnimations];
	}

}

#pragma mark CoreAnimationDelegate
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	[messageView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
	[messageView setCenter:letterButton.center];
	[messageView setAlpha:0];
	
	self.isShowMessage=NO;
}

-(void)maximizeAnimDidFinish
{
	
	self.isShowMessage=YES;
}

#pragma mark methods
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


- (void)dealloc {
	
	[senderImageView release];
	[senderNameLabel release];
	[dismissButton release];
	[toLabel release];
	[messageTextView release];
	[pictureImageView release];
	[activityView release];
	[messageView release];
	[letterButton release];
	[receiverNameLabel release];
	

	if(senderTempPhoto!=nil)
		[senderTempPhoto release];
	
	if(downloadConnection)
	{
		//[downloadConnection cancel];
		self.downloadConnection=nil;
	}	
	
    [super dealloc];
}


@end
