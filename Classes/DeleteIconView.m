//
//  DeleteIconView.m
//  AGiftFree
//
//  Created by Nelson on 2/23/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "DeleteIconView.h"
#import "GiftThumbnailImageView.h"

@implementation DeleteIconView

@synthesize owner;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		[self setImage:[UIImage imageNamed:@"Xtest.png"]];
		[self setUserInteractionEnabled:YES];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

#pragma mark touch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//show alert view to ask user if user want to delete
	UIAlertView *deleteAlert=[[UIAlertView alloc] initWithTitle:@"Delete gift" message:@"Would you like to delete this gift?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete",nil];
	[deleteAlert show];
	[deleteAlert release];
}

#pragma mark alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==1)
	{
		[owner removeThisGift];
	}
}

- (void)dealloc {
	
	[owner release];
    [super dealloc];
}


@end
