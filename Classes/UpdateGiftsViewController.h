//
//  UpdateGiftsViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/17/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGiftWebService.h"

@interface UpdateGiftsViewController : UIViewController <AGiftWebServiceDelegate>{
	
	UILabel *updateLabel;
	UIActivityIndicatorView *activityView;

}

@property (nonatomic, retain) IBOutlet UILabel *updateLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;

-(void)receiveNewGiftList;

@end
