    //
//  UserSettingViewController.m
//  AGiftFree
//
//  Created by Nelson on 2/21/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "UserSettingViewController.h"
#import "AGiftFreeAppDelegate.h"


@implementation UserSettingViewController

@synthesize autoDeleteLabel;
@synthesize monthsPicker;
@synthesize notificationLabel;
@synthesize notificationSwitch;
@synthesize asquareLogo;
@synthesize infoTextView;
@synthesize autoDeletionDataSource;
@synthesize hintButton;
@synthesize hintController;

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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSString *deletionDataSourcePath=[[NSBundle mainBundle] pathForResource:@"AutoDeletionMonths" ofType:@"plist"];
	
	autoDeletionDataSource=[[NSArray alloc] initWithContentsOfFile:deletionDataSourcePath];
	
	[infoTextView setFont:[UIFont systemFontOfSize:12]];
	
	//retrieve user last setting and set to picker view
    NSNumber *month=[NSNumber numberWithInt:appDelegate.userAutoDeletionPeriod];
	
	[monthsPicker selectRow:[autoDeletionDataSource indexOfObject:month] inComponent:0 animated:YES];
	
	[notificationSwitch setOn:appDelegate.userNotification];

	
	
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
	
	self.autoDeleteLabel=nil;
	self.monthsPicker=nil;
	self.notificationLabel=nil;
	self.notificationSwitch=nil;
	self.asquareLogo=nil;
	self.infoTextView=nil;
	self.hintButton=nil;
	self.hintController=nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark  IBAction methods
-(IBAction)notificationSwitchChange:(id)sender
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	UISwitch *notificationSwitcher=sender;
	
	appDelegate.userNotification=[notificationSwitcher isOn];
	
	[appDelegate saveUserSettingInfo];
}

-(IBAction)hintButtonPress
{
	if(hintController)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
		[UIView setAnimationDuration:1.0];
		
		[self.view addSubview:hintController.view];
		
		[UIView commitAnimations];
	}
}

#pragma mark methods
-(void)disableHint
{
	[hintController closeButtonPressed];
}

#pragma mark picker data source methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [autoDeletionDataSource count];
}


#pragma mark picker delegate methods
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSUInteger month=[(NSNumber*)[autoDeletionDataSource objectAtIndex:row] integerValue];
	NSString *title;
	
	if(month>1)
	{
		title=[NSString stringWithFormat:@"%i months", month];
	}
	else if(month==1)
	{
		title=[NSString stringWithFormat:@"%i month", month];
	}
	else if(month==0)
	{
		title=[NSString stringWithString:@"Never"];
	}
	
	
	return title;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSUInteger selectedMonth=[(NSNumber*)[autoDeletionDataSource objectAtIndex:row] integerValue];
	
	appDelegate.userAutoDeletionPeriod=selectedMonth;
	
	appDelegate.deletionStartDate=[NSDate date];
	
	[appDelegate saveUserSettingInfo];
	
	if(appDelegate.userAutoDeletionPeriod!=0)
	{
		NSCalendar *calendar=[NSCalendar currentCalendar];
		NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
		[comps setMonth:appDelegate.userAutoDeletionPeriod];
		
		NSDate *deleteDate=[calendar dateByAddingComponents:comps toDate:appDelegate.deletionStartDate options:0];
		NSDateFormatter *dateFormatter=[[[NSDateFormatter alloc] init] autorelease];
		
		[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"US"] autorelease]];
		[dateFormatter setDateFormat:@"MMM d, yyyy"];
		
		NSString *autoDeleteDate=[dateFormatter stringFromDate:deleteDate];
		
		[appDelegate.dataManager updateOldGiftAutoDeletion:autoDeleteDate];
	}
	else 
	{
		[appDelegate.dataManager updateOldGiftAutoDeletion:@"Never"];
	}
}


- (void)dealloc {
	
	[autoDeleteLabel release];
	[monthsPicker release];
	[notificationLabel release];
	[notificationSwitch release];
	[asquareLogo release];
	[infoTextView release];
	[autoDeletionDataSource release];
	[hintButton release];
	[hintController release];
	
    [super dealloc];
}


@end
