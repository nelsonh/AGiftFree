//
//  GiftMessageBeforeSubViewController.m
//  AGiftFree
//
//  Created by Nelson on 3/2/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "GiftMessageBeforeSubViewController.h"


@implementation GiftMessageBeforeSubViewController

@synthesize senderImageView;
@synthesize senderNameLabel;
@synthesize toLabel;
@synthesize envelopImageView;
@synthesize messageTextView;
@synthesize pictureImageView;
@synthesize activityView;
@synthesize giftItem;
@synthesize senderPhotoConnection;
@synthesize senderTempPhoto;
@synthesize canDismiss;


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
	 
	 
	 [self.senderNameLabel setText:giftItem.senderName];
	 //[self.pictureImageView setImage:[UIImage imageWithData:giftItem.giftPhoto]];
	 
	 if([giftItem.giftBeforeText isEqualToString:@""])
	 {
		 self.messageTextView.text=@"You have no text message";
	 }
	 else 
	 {
		 self.messageTextView.text=giftItem.giftBeforeText;
	 }

	 
	 
	 //sender photo
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
		 self.senderPhotoConnection=connection;
		 [connection release];
	 }
	 
	 [pictureImageView setImage:[UIImage imageWithData:giftItem.giftPhoto]];

	 
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
	self.toLabel=nil;
	self.envelopImageView=nil;
	self.messageTextView=nil;
	self.pictureImageView=nil;
	self.activityView=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated
{
	/*
	[activityView startAnimating];
	
	NSData *senderPhoto=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:giftItem.senderPicURL]];
	
	[activityView stopAnimating];
	
	[senderImageView setImage:[UIImage imageWithData:senderPhoto]];
	
	[senderPhoto release];
	
	canDismiss=YES;
	 */
}


- (void)dealloc {
	
	[senderImageView release];
	[senderNameLabel release];
	[toLabel release];
	[envelopImageView release];
	[messageTextView release];
	[pictureImageView release];
	[activityView release];

	if(senderTempPhoto!=nil)
		[senderTempPhoto release];
	
	if(senderPhotoConnection)
	{
		//[senderPhotoConnection cancel];
		self.senderPhotoConnection=nil;
	}	
	
    [super dealloc];
}


@end
