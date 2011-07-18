//
//  MPMoviePlayer.h
//  AGiftFree
//
//  Created by Nelson on 3/2/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface MPMoviePlayer : MPMoviePlayerViewController {
	
	id performTarget;
	SEL perfromAction;
	

}



- (id)initWithContentURL:(NSURL *)contentURL Target:(id)target Action:(SEL)action;
-(void)videoDidFinished:(NSNotification*)notification;


@end
