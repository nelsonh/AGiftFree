//
//  GiftSectionViewController.h
//  AGiftFree
//
//  Created by Nelson on 2/22/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MultiTaskProtocol.h"

@interface GiftSectionViewController : UINavigationController<MultiTaskProtocol> {
	
	AVAudioPlayer *soundPlayer;

}

@property (nonatomic, retain) AVAudioPlayer *soundPlayer;

-(void)playSoundWithData:(NSData*)soundData;
-(void)stopPlayingSound;
-(void)removeController:(Class)controllerClass;

@end
