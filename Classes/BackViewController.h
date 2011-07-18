//
//  BackViewController.h
//  AGiftFree
//
//  Created by Nelson on 3/18/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface BackViewController : UIViewController {
	
	UIView *statusView;
	UIImageView *backImageView;
	UILabel *statusMessageLable;
}

@property (nonatomic, retain) IBOutlet UIView *statusView;
@property (nonatomic, retain) IBOutlet UIImageView *backImageView;
@property (nonatomic, retain) IBOutlet UILabel *statusMessageLable;

-(void)changeStatusMessage:(NSString*)msg;
-(void)doChangeStatusMessage:(id)object;

@end
