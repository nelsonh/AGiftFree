//
//  CoreDataManager.m
//  AGiftFree
//
//  Created by Nelson on 3/8/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "CoreDataManager.h"
#import "AGiftFreeAppDelegate.h"
#import "OldGiftItem.h"


@implementation CoreDataManager

#pragma mark methods
-(BOOL)addNewGiftItemWithArray:(NSArray*)giftList
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *giftItem=nil;
	
	NSError *error;
	
	
	for(int i=0; i<[giftList count]; i++)
	{
		NewGiftItem *temp=[giftList objectAtIndex:i];
		NSString *giftID=temp.giftID;
		NSPredicate *pred=[NSPredicate predicateWithFormat:@"(GiftID=%@)", giftID];
		
		NSFetchRequest *request=[[NSFetchRequest alloc] init];
		
		NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"NewGiftList" inManagedObjectContext:context];
		[request setEntity:entityDescription];
		[request setPredicate:pred];
		
		NSArray *objects=[context executeFetchRequest:request error:&error];
		
		[request release];
		
		if(objects==nil)
		{
			return NO;
		}
		
		if([objects count]==0)
		{
			// insert new data 
			giftItem=[NSEntityDescription insertNewObjectForEntityForName:@"NewGiftList" inManagedObjectContext:context];
			
			//get input data
			NewGiftItem *item=[giftList objectAtIndex:i];
			
			//set value
			//first
			[giftItem setValue:item.receiveTime forKey:@"ReceiveTime"];
			[giftItem setValue:item.giftID forKey:@"GiftID"];
			[giftItem setValue:item.giftIconID forKey:@"GiftIconID"];
			[giftItem setValue:item.senderID forKey:@"SenderID"];
			[giftItem setValue:item.senderPicURL forKey:@"SenderPicURL"];
			[giftItem setValue:item.senderName forKey:@"SenderName"];
			[giftItem setValue:item.strCanOpenTime forKey:@"strCanOpenTime"];
			[giftItem setValue:item.giftDefMusicNum forKey:@"GiftDefMusicNumber"];
			[giftItem setValue:item.giftNum forKey:@"GiftNumber"];
			[giftItem setValue:item.giftBoxNum forKey:@"GiftBoxNumber"];
			[giftItem setValue:item.gift3DNum forKey:@"Gift3DNumber"];
			[giftItem setValue:item.giftBox3DNum forKey:@"GiftBox3DNumber"];
			[giftItem setValue:item.anonymous forKey:@"Anonymous"];
			
			
			//second
			[giftItem setValue:item.giftAfterText forKey:@"GiftAfterText"];
			[giftItem setValue:item.giftBeforeText forKey:@"GiftBeforeText"];
			[giftItem setValue:item.giftPhotoName forKey:@"GiftPhotoName"];
			[giftItem setValue:item.giftPhoto forKey:@"GiftPhoto"];
			[giftItem setValue:item.giftSoundID forKey:@"GiftSoundID"];
			[giftItem setValue:item.giftSoundName forKey:@"GiftSoundName"];
			[giftItem setValue:item.giftSound forKey:@"GiftSound"];
			[giftItem setValue:item.objNumber forKey:@"ObjNumber"];
			[giftItem setValue:item.giftBoxVideoFileName forKey:@"GiftBoxVideoFileName"];
			
			//third
			[giftItem setValue:item.giftBoxVideoNum forKey:@"GiftBoxVideoNumber"];
			[giftItem setValue:item.giftVideoNum forKey:@"GiftVideoNumber"];
			[giftItem setValue:item.giftBox3DNum forKey:@"GiftBox3DNumber"];
			[giftItem setValue:item.gift3DNum forKey:@"Gift3DNumber"];

			
			
			//check point
			[giftItem setValue:[NSNumber numberWithBool:item.isFirsDownloadComplete] forKey:@"FirstDownloadComplete"];
			[giftItem setValue:[NSNumber numberWithBool:item.isSecondDownloadComplete] forKey:@"SecondDownloadComplete"];
			[giftItem setValue:[NSNumber numberWithBool:item.isThirdDownloadComplete] forKey:@"ThirdDownloadComplete"];
			[giftItem setValue:[NSNumber numberWithBool:item.isTotalDownloadComplete] forKey:@"TotalDownloadComplete"];
		}
		else 
		{
			return YES;
		}

	}
	
	//save gift
	return [context save:&error];
}

-(BOOL)updateNewGiftAnonymousStatus:(NSString*)anonymous WithGiftID:(NSString*)giftID
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *giftItem=nil;
	NSError *error;
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(GiftID=%@)", giftID];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"NewGiftList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		giftItem=[objects objectAtIndex:0];
		
		[giftItem setValue:anonymous forKey:@"Anonymous"];
		
		return [context save:&error];
	}
	else 
	{
		return NO;
	}

}

-(NSMutableArray*)retrieveNewGiftList
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *giftItem=nil;
	NSMutableArray *newGiftItemContainer=[[[NSMutableArray alloc] init] autorelease];
	NSError *error;
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"NewGiftList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		for(giftItem in objects)
		{
			NewGiftItem *item=[[NewGiftItem alloc] init];
			
			//first
			[item setReceiveTime:[giftItem valueForKey:@"ReceiveTime"]];
			[item setGiftID:[giftItem valueForKey:@"GiftID"]];
			[item setGiftIconID:[giftItem valueForKey:@"GiftIconID"]];
			[item setSenderID:[giftItem valueForKey:@"SenderID"]];
			[item setSenderPicURL:[giftItem valueForKey:@"SenderPicURL"]];
			[item setSenderName:[giftItem valueForKey:@"SenderName"]];
			[item setStrCanOpenTime:[giftItem valueForKey:@"strCanOpenTime"]];
			[item setGiftDefMusicNum:[giftItem valueForKey:@"GiftDefMusicNumber"]];
			[item setGiftNum:[giftItem valueForKey:@"GiftNumber"]];
			[item setGiftBoxNum:[giftItem valueForKey:@"GiftBoxNumber"]];
			[item setGift3DNum:[giftItem valueForKey:@"Gift3DNumber"]];
			[item setGiftBox3DNum:[giftItem valueForKey:@"GiftBox3DNumber"]];
			[item setAnonymous:[giftItem valueForKey:@"Anonymous"]];
			
			
			//second
			[item setGiftBeforeText:[giftItem valueForKey:@"GiftBeforeText"]];
			[item setGiftAfterText:[giftItem valueForKey:@"GiftAfterText"]];
			[item setGiftPhotoName:[giftItem valueForKey:@"GiftPhotoName"]];
			[item setGiftPhoto:[giftItem valueForKey:@"GiftPhoto"]];
			[item setGiftSoundID:[giftItem valueForKey:@"GiftSoundID"]];
			[item setGiftSoundName:[giftItem valueForKey:@"GiftSoundName"]];
			[item setGiftSound:[giftItem valueForKey:@"GiftSound"]];
			[item setObjNumber:[giftItem valueForKey:@"ObjNumber"]];
			[item setGiftBoxVideoFileName:[giftItem valueForKey:@"GiftBoxVideoFileName"]];
			
			//third
			[item setGiftBoxVideoNum:[giftItem valueForKey:@"GiftBoxVideoNumber"]];
			[item setGiftVideoNum:[giftItem valueForKey:@"GiftVideoNumber"]];
			[item setGiftBox3DNum:[giftItem valueForKey:@"GiftBox3DNumber"]];
			[item setGift3DNum:[giftItem valueForKey:@"Gift3DNumber"]];
			
			
			//check point
			BOOL first=[(NSNumber*)[giftItem valueForKey:@"FirstDownloadComplete"] boolValue];
			BOOL second=[(NSNumber*)[giftItem valueForKey:@"SecondDownloadComplete"] boolValue];
			BOOL Third=[(NSNumber*)[giftItem valueForKey:@"ThirdDownloadComplete"] boolValue];
			BOOL Total=[(NSNumber*)[giftItem valueForKey:@"TotalDownloadComplete"] boolValue];
			
			[item setIsFirsDownloadComplete:first];
			[item setIsSecondDownloadComplete:second];
			[item setIsThirdDownloadComplete:Third];
			[item setIsTotalDownloadComplete:Total];
			
			[newGiftItemContainer addObject:item];
			
			[item release];
		}
		
		return newGiftItemContainer;
	}
	
	return newGiftItemContainer;
}

-(NSMutableArray*)retrieveSenderInfo
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *senderInfoObject=nil;
	NSMutableArray *senderInfoContainer=[[[NSMutableArray alloc] init] autorelease];
	NSError *error;
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		for(senderInfoObject in objects)
		{
			OldSenderInfo *senderInfo=[[OldSenderInfo alloc] init];
			
			//fill data
			[senderInfo setSenderGiftPlist:[senderInfoObject valueForKey:@"SenderGiftPlist"]];
			[senderInfo setSenderName:[senderInfoObject valueForKey:@"SenderName"]];
			[senderInfo setSenderPhoneNumber:[senderInfoObject valueForKey:@"SenderPhoneNumber"]];
			[senderInfo setSenderPicURL:[senderInfoObject valueForKey:@"SenderPicURL"]];
			[senderInfo setNumberOfGift:[senderInfoObject valueForKey:@"NumberOfGift"]];
			
			[senderInfoContainer addObject:senderInfo];
			
			[senderInfo release];
		}
		
		return senderInfoContainer;
	}
	
	return senderInfoContainer;

}

-(BOOL)updateNewGiftItemWithGift:(NewGiftItem*)inItem WithGiftID:(NSString*)giftID
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *giftItem=nil;
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(GiftID=%@)", giftID];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"NewGiftList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if(objects==nil)
	{
		return NO;
	}
	
	if([objects count]>0)
	{
		for(giftItem in objects)
		{
			//set value
			//first
			[giftItem setValue:inItem.receiveTime forKey:@"ReceiveTime"];
			[giftItem setValue:inItem.giftID forKey:@"GiftID"];
			[giftItem setValue:inItem.giftIconID forKey:@"GiftIconID"];
			[giftItem setValue:inItem.senderID forKey:@"SenderID"];
			[giftItem setValue:inItem.senderPicURL forKey:@"SenderPicURL"];
			[giftItem setValue:inItem.senderName forKey:@"SenderName"];
			[giftItem setValue:inItem.strCanOpenTime forKey:@"strCanOpenTime"];
			[giftItem setValue:inItem.giftDefMusicNum forKey:@"GiftDefMusicNumber"];
			[giftItem setValue:inItem.giftNum forKey:@"GiftNumber"];
			[giftItem setValue:inItem.giftBoxNum forKey:@"GiftBoxNumber"];
			[giftItem setValue:inItem.gift3DNum forKey:@"Gift3DNumber"];
			[giftItem setValue:inItem.giftBox3DNum forKey:@"GiftBox3DNumber"];
			
			
			//second
			[giftItem setValue:inItem.giftAfterText forKey:@"GiftAfterText"];
			[giftItem setValue:inItem.giftBeforeText forKey:@"GiftBeforeText"];
			[giftItem setValue:inItem.giftPhotoName forKey:@"GiftPhotoName"];
			[giftItem setValue:inItem.giftPhoto forKey:@"GiftPhoto"];
			[giftItem setValue:inItem.giftSoundID forKey:@"GiftSoundID"];
			[giftItem setValue:inItem.giftSoundName forKey:@"GiftSoundName"];
			[giftItem setValue:inItem.giftSound forKey:@"GiftSound"];
			[giftItem setValue:inItem.objNumber forKey:@"ObjNumber"];
			[giftItem setValue:inItem.giftBoxVideoFileName forKey:@"GiftBoxVideoFileName"];
			
			//third
			[giftItem setValue:inItem.giftBoxVideoNum forKey:@"GiftBoxVideoNumber"];
			[giftItem setValue:inItem.giftVideoNum forKey:@"GiftVideoNumber"];
			[giftItem setValue:inItem.giftBox3DNum forKey:@"GiftBox3DNumber"];
			[giftItem setValue:inItem.gift3DNum forKey:@"Gift3DNumber"];
			
			
			
			//check point
			[giftItem setValue:[NSNumber numberWithBool:inItem.isFirsDownloadComplete] forKey:@"FirstDownloadComplete"];
			[giftItem setValue:[NSNumber numberWithBool:inItem.isSecondDownloadComplete] forKey:@"SecondDownloadComplete"];
			[giftItem setValue:[NSNumber numberWithBool:inItem.isThirdDownloadComplete] forKey:@"ThirdDownloadComplete"];
			[giftItem setValue:[NSNumber numberWithBool:inItem.isTotalDownloadComplete] forKey:@"TotalDownloadComplete"];
		}
	}
	else 
	{
		return NO;
	}
	
	return [context save:&error];

}

-(BOOL)moveNewGiftToOldWithGiftItem:(NewGiftItem*)inItem WithSenderPhoneNumber:(NSString*)senderPhoneNumber
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *giftItem=nil;
	NSManagedObject *senderInfo=nil;
	NSMutableDictionary *giftInfo=[[[NSMutableDictionary alloc] init] autorelease];
	
	NSString *plistPrefix=@"GiftList";
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(GiftID=%@)", inItem.giftID];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];

	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"NewGiftList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	
	
	if([objects count]>0)
	{
		//new gift item found retrieve data and prepare to move to old section
		giftItem=[objects objectAtIndex:0];
		
		//set  dictionary value
		//first
		[giftInfo setValue:[giftItem valueForKey:@"ReceiveTime"] forKey:@"ReceiveTime"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftID"] forKey:@"GiftID"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftIconID"] forKey:@"GiftIconID"];
		[giftInfo setValue:[giftItem valueForKey:@"SenderID"] forKey:@"SenderID"];
		[giftInfo setValue:[giftItem valueForKey:@"SenderPicURL"] forKey:@"SenderPicURL"];
		[giftInfo setValue:[giftItem valueForKey:@"SenderName"] forKey:@"SenderName"];
		[giftInfo setValue:[giftItem valueForKey:@"strCanOpenTime"] forKey:@"strCanOpenTime"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftDefMusicNumber"] forKey:@"GiftDefMusicNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftNumber"] forKey:@"GiftNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftBoxNumber"] forKey:@"GiftBoxNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"Gift3DNumber"] forKey:@"Gift3DNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftBox3DNumber"] forKey:@"GiftBox3DNumber"];
		
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
			
			[giftInfo setValue:autoDeleteDate forKey:@"AutoDeletionDate"];
		}
		else 
		{
			[giftInfo setValue:@"Never" forKey:@"AutoDeletionDate"];
		}

		
		//second
		[giftInfo setValue:[giftItem valueForKey:@"GiftAfterText"] forKey:@"GiftAfterText"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftBeforeText"] forKey:@"GiftBeforeText"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftPhotoName"] forKey:@"GiftPhotoName"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftPhoto"] forKey:@"GiftPhoto"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftSoundID"] forKey:@"GiftSoundID"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftSoundName"] forKey:@"GiftSoundName"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftSound"] forKey:@"GiftSound"];
		[giftInfo setValue:[giftItem valueForKey:@"ObjNumber"] forKey:@"ObjNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftBoxVideoFileName"] forKey:@"GiftBoxVideoFileName"];
		
		//third
		[giftInfo setValue:[giftItem valueForKey:@"GiftBoxVideoNumber"] forKey:@"GiftBoxVideoNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftVideoNumber"] forKey:@"GiftVideoNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"GiftBox3DNumber"] forKey:@"GiftBox3DNumber"];
		[giftInfo setValue:[giftItem valueForKey:@"Gift3DNumber"] forKey:@"Gift3DNumber"];
		
		//check point
		NSString *first=[giftItem valueForKey:@"FirstDownloadComplete"];
		NSString *second=[giftItem valueForKey:@"SecondDownloadComplete"];
		NSString *third=[giftItem valueForKey:@"ThirdDownloadComplete"];
		NSString *total=[giftItem valueForKey:@"TotalDownloadComplete"];
		
		[giftInfo setValue:[NSNumber numberWithBool:[first boolValue]] forKey:@"FirstDownloadComplete"];
		[giftInfo setValue:[NSNumber numberWithBool:[second boolValue]] forKey:@"SecondDownloadComplete"];
		[giftInfo setValue:[NSNumber numberWithBool:[third boolValue]] forKey:@"ThirdDownloadComplete"];
		[giftInfo setValue:[NSNumber numberWithBool:[total boolValue]] forKey:@"TotalDownloadComplete"];
		
		//find sender info by phone number
		pred=[NSPredicate predicateWithFormat:@"(SenderPhoneNumber=%@)", senderPhoneNumber];
		
		entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
		[request setEntity:entityDescription];
		[request setPredicate:pred];
		
		objects=[context executeFetchRequest:request error:&error];
		
		[request release];
		
		if([objects count]>0)
		{
			//sender info is existed
			
			senderInfo=[objects objectAtIndex:0];
			
			//retrieve gift list file name form sender info
			NSString *plistFileName=[senderInfo valueForKey:@"SenderGiftPlist"];
			
			//combine path
			NSString *plistFilePath=[docDirectory stringByAppendingPathComponent:plistFileName];
			
			//retrieve gift list
			NSMutableArray *giftCollection=[NSMutableArray arrayWithContentsOfFile:plistFilePath];
			
			//add gift item
			[giftCollection addObject:giftInfo];
			
			//save gift list
			[giftCollection writeToFile:plistFilePath atomically:NO];
			
			
			//update gift count
			[senderInfo setValue:[NSString stringWithFormat:@"%i", [giftCollection count]] forKey:@"NumberOfGift"];
			
			//save core data
			if(![context save:&error])
			{
				//save fail
				return NO;
				
			}
			
			
		}
		else 
		{
			//sender info is not existed
			NSString *plistSaveName=[[plistPrefix stringByAppendingString:senderPhoneNumber] stringByAppendingString:@".plist"];
			NSString *plistSavePath=[docDirectory stringByAppendingPathComponent:plistSaveName];
			
			NSMutableArray *giftCollection=[[NSMutableArray alloc] init];
			
			
			
			//create a gift list plist and add gift
			[giftCollection addObject:giftInfo];
			
			[giftCollection writeToFile:plistSavePath atomically:NO];
			
			
			
			//create new sender info in core data
			senderInfo=[NSEntityDescription insertNewObjectForEntityForName:@"SenderList" inManagedObjectContext:context];
			
			//fill info
			[senderInfo setValue:senderPhoneNumber forKey:@"SenderPhoneNumber"];
			[senderInfo setValue:plistSaveName forKey:@"SenderGiftPlist"];
			[senderInfo setValue:inItem.senderName forKey:@"SenderName"];
			[senderInfo setValue:inItem.senderPicURL forKey:@"SenderPicURL"];
			[senderInfo setValue:[NSString stringWithFormat:@"%i", [giftCollection count]] forKey:@"NumberOfGift"];
			
			
			[giftCollection release];
			
			//save core data
			if(![context save:&error])
			{
				//save fail
				return NO;
				
			}

		}
		
		//remove new gift from NewGiftList core data
		return [self removeNewGiftItemWithGiftID:inItem.giftID];
		
		[request release];
		
	}
	else 
	{
		[request release];
		//no new gift item found return
		return NO;
	}

}

-(BOOL)removeNewGiftItemWithGiftID:(NSString*)giftID
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *removedNewGift;
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(GiftID=%@)", giftID];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"NewGiftList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		//found new gift remove it
		removedNewGift=[objects objectAtIndex:0];
		
		[context deleteObject:removedNewGift];
		
		return [context save:&error];
	}
	else 
	{
		return NO;
	}

}

-(BOOL)removeSenderInfoAndGiftsWithSendrPhoneNumber:(NSString*)phoneNumber
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *removedSenderInfo;
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(SenderPhoneNumber=%@)", phoneNumber];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		removedSenderInfo=[objects objectAtIndex:0];
		NSString *giftCollectionPlist=[removedSenderInfo valueForKey:@"SenderGiftPlist"];
		NSString *giftCollectionPlistFullPath=[docDirectory stringByAppendingPathComponent:giftCollectionPlist];
		NSFileManager *defaultFileManager=[NSFileManager defaultManager];
		
		NSError *error;
		
		//found sender info
		//remove gift collection plist
		[defaultFileManager removeItemAtPath:giftCollectionPlistFullPath error:&error];
		
		//remove sender info from core data
		[context deleteObject:removedSenderInfo];
		
		return [context save:&error];
	}
	else 
	{
		return NO;
	}

}

-(NSMutableArray*)retrieveOldGiftItemsWithSenderPhoneNumber:(NSString*)phoneNumber
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *senderInfo=nil;
	NSMutableArray *giftItems=[[[NSMutableArray alloc] init] autorelease];
	NSString *plistName;
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(SenderPhoneNumber=%@)", phoneNumber];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		senderInfo=[objects objectAtIndex:0];
		plistName=[senderInfo valueForKey:@"SenderGiftPlist"];
		NSString *plistPath=[docDirectory stringByAppendingPathComponent:plistName];
		NSArray *giftCollection=[NSArray arrayWithContentsOfFile:plistPath];
		
		for(int i=0; i<[giftCollection count]; i++)
		{
			OldGiftItem *oldGift=[[OldGiftItem alloc] init];
			NSDictionary *dictionary=[giftCollection objectAtIndex:i];
			
			[oldGift setReceiveTime:[dictionary valueForKey:@"ReceiveTime"]];
			[oldGift setGiftID:[dictionary valueForKey:@"GiftID"]];
			[oldGift setGiftIconID:[dictionary valueForKey:@"GiftIconID"]];
			[oldGift setSenderID:[dictionary valueForKey:@"SenderID"]];
			[oldGift setSenderPicURL:[dictionary valueForKey:@"SenderPicURL"]];
			[oldGift setSenderName:[dictionary valueForKey:@"SenderName"]];
			[oldGift setStrCanOpenTime:[dictionary valueForKey:@"strCanOpenTime"]];
			[oldGift setGiftDefMusicNum:[dictionary valueForKey:@"GiftDefMusicNumber"]];
			[oldGift setGiftNum:[dictionary valueForKey:@"GiftNumber"]];
			[oldGift setGiftBoxNum:[dictionary valueForKey:@"GiftBoxNumber"]];
			[oldGift setGift3DNum:[dictionary valueForKey:@"Gift3DNumber"]];
			[oldGift setGiftBoxNum:[dictionary valueForKey:@"GiftBox3DNumber"]];
			[oldGift setAutoDeleteDate:[dictionary valueForKey:@"AutoDeletionDate"]];
			
			
			//second
			[oldGift setGiftAfterText:[dictionary valueForKey:@"GiftAfterText"]];
			[oldGift setGiftBeforeText:[dictionary valueForKey:@"GiftBeforeText"]];
			[oldGift setGiftPhotoName:[dictionary valueForKey:@"GiftPhotoName"]];
			[oldGift setGiftPhoto:[dictionary valueForKey:@"GiftPhoto"]];
			[oldGift setGiftSoundID:[dictionary valueForKey:@"GiftSoundID"]];
			[oldGift setGiftSoundName:[dictionary valueForKey:@"GiftSoundName"]];
			[oldGift setGiftSound:[dictionary valueForKey:@"GiftSound"]];
			[oldGift setObjNumber:[dictionary valueForKey:@"ObjNumber"]];
			[oldGift setGiftBoxVideoFileName:[dictionary valueForKey:@"GiftBoxVideoFileName"]];
			
			//third
			[oldGift setGiftBoxVideoNum:[dictionary valueForKey:@"GiftBoxVideoNumber"]];
			[oldGift setGiftVideoNum:[dictionary valueForKey:@"GiftVideoNumber"]];
			[oldGift setGiftBox3DNum:[dictionary valueForKey:@"GiftBox3DNumber"]];
			[oldGift setGift3DNum:[dictionary valueForKey:@"Gift3DNumber"]];
			
			//check point
			NSString *first=[dictionary valueForKey:@"FirstDownloadComplete"];
			NSString *second=[dictionary valueForKey:@"SecondDownloadComplete"];
			NSString *third=[dictionary valueForKey:@"ThirdDownloadComplete"];
			NSString *total=[dictionary valueForKey:@"TotalDownloadComplete"];
			
			[oldGift setIsFirsDownloadComplete:[first boolValue]];
			[oldGift setIsSecondDownloadComplete:[second boolValue]];
			[oldGift setIsThirdDownloadComplete:[third boolValue]];
			[oldGift setIsTotalDownloadComplete:[total boolValue]];
			
			[giftItems addObject:oldGift];
			
			[oldGift release];
		}
		
		return giftItems;
	}
	else 
	{
		return giftItems;
	}

}

-(BOOL)saveSenderGiftCollectionWithSenderPhoneNumber:(NSString*)phoneNumber WithGiftCollection:(NSArray*)giftList
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *senderInfo=nil;
	NSMutableArray *giftItems=[[NSMutableArray alloc] init];
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(SenderPhoneNumber=%@)", phoneNumber];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		senderInfo=[objects objectAtIndex:0];
		
		//update gift count
		[senderInfo setValue:[NSString stringWithFormat:@"%i", [giftList count]] forKey:@"NumberOfGift"];
		
		//update physical data
		NSString *plistName=[senderInfo valueForKey:@"SenderGiftPlist"];
		NSString *plistSavePath=[docDirectory stringByAppendingPathComponent:plistName];
		
		for(int i=0; i<[giftList count]; i++)
		{
			OldGiftItem *item=[giftList objectAtIndex:i];
			NSMutableDictionary *giftInfo=[[NSMutableDictionary alloc] init];
			
			//set  dictionary value
			//first
			[giftInfo setValue:item.receiveTime forKey:@"ReceiveTime"];
			[giftInfo setValue:item.giftID forKey:@"GiftID"];
			[giftInfo setValue:item.giftIconID forKey:@"GiftIconID"];
			[giftInfo setValue:item.senderID forKey:@"SenderID"];
			[giftInfo setValue:item.senderPicURL forKey:@"SenderPicURL"];
			[giftInfo setValue:item.senderName forKey:@"SenderName"];
			[giftInfo setValue:item.strCanOpenTime forKey:@"strCanOpenTime"];
			[giftInfo setValue:item.giftDefMusicNum forKey:@"GiftDefMusicNumber"];
			[giftInfo setValue:item.giftNum forKey:@"GiftNumber"];
			[giftInfo setValue:item.giftBoxNum forKey:@"GiftBoxNumber"];
			[giftInfo setValue:item.gift3DNum forKey:@"Gift3DNumber"];
			[giftInfo setValue:item.giftBox3DNum forKey:@"GiftBox3DNumber"];
			
			
			//second
			[giftInfo setValue:item.giftAfterText forKey:@"GiftAfterText"];
			[giftInfo setValue:item.giftBeforeText forKey:@"GiftBeforeText"];
			[giftInfo setValue:item.giftPhotoName forKey:@"GiftPhotoName"];
			[giftInfo setValue:item.giftPhoto forKey:@"GiftPhoto"];
			[giftInfo setValue:item.giftSoundID forKey:@"GiftSoundID"];
			[giftInfo setValue:item.giftSoundName forKey:@"GiftSoundName"];
			[giftInfo setValue:item.giftSound forKey:@"GiftSound"];
			[giftInfo setValue:item.objNumber forKey:@"ObjNumber"];
			[giftInfo setValue:item.giftBoxVideoFileName forKey:@"GiftBoxVideoFileName"];
			
			//third
			[giftInfo setValue:item.giftBoxVideoNum forKey:@"GiftBoxVideoNumber"];
			[giftInfo setValue:item.giftVideoNum forKey:@"GiftVideoNumber"];
			[giftInfo setValue:item.giftBox3DNum forKey:@"GiftBox3DNumber"];
			[giftInfo setValue:item.gift3DNum forKey:@"Gift3DNumber"];
			
			//check point
			[giftInfo setValue:[NSNumber numberWithBool:item.isFirsDownloadComplete] forKey:@"FirstDownloadComplete"];
			[giftInfo setValue:[NSNumber numberWithBool:item.isSecondDownloadComplete] forKey:@"SecondDownloadComplete"];
			[giftInfo setValue:[NSNumber numberWithBool:item.isThirdDownloadComplete] forKey:@"ThirdDownloadComplete"];
			[giftInfo setValue:[NSNumber numberWithBool:item.isTotalDownloadComplete] forKey:@"TotalDownloadComplete"];
			
			[giftItems addObject:giftInfo];
			
			[giftInfo release];
		}
		
		if([giftItems writeToFile:plistSavePath atomically:NO] && [context save:&error])
		{
			return YES;
		}
		else 
		{
			return NO;
		}

	}
	else 
	{
		return NO;
	}

							   
}

-(BOOL)removeAllSenderData
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *removedSenderInfo;
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSFileManager *fileManager=[NSFileManager defaultManager];
	
	NSError *error;
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		//run through each sender 
		for(int i=0; i<[objects count]; i++)
		{
			BOOL shouldRemoveSenderInfo=NO;
			
			removedSenderInfo=[objects objectAtIndex:i];
			
			NSString *giftPlist=[removedSenderInfo valueForKey:@"SenderGiftPlist"];
			NSString *giftPlistPath=[docDirectory stringByAppendingPathComponent:giftPlist];
			
			if([fileManager fileExistsAtPath:giftPlistPath])
			{
				/*
				//delete file
				[fileManager removeItemAtPath:giftPlistPath error:&error];
				 */
				//remove gift that is not set to never for auto deletion
				NSMutableArray *neverDeleteGiftArray=[[NSMutableArray alloc] init];
				NSMutableArray *oldGiftArray=[NSMutableArray arrayWithContentsOfFile:giftPlistPath];
				
				for(NSDictionary *oldGiftDic in oldGiftArray)
				{
					NSString *autoDeleteDate=[oldGiftDic valueForKey:@"AutoDeletionDate"];
					
					if([autoDeleteDate isEqualToString:@"Never"])
					{
						[neverDeleteGiftArray addObject:oldGiftDic];
					}
				}
				
				[fileManager removeItemAtPath:giftPlistPath error:&error];
				
				if([neverDeleteGiftArray count]!=0)
				{
					//save 
					[neverDeleteGiftArray writeToFile:giftPlistPath atomically:NO];
					
					shouldRemoveSenderInfo=NO;
				}
				else 
				{
					shouldRemoveSenderInfo=YES;
				}

			}
			
			if(shouldRemoveSenderInfo)
			{
				//remove senderinfo
				[context deleteObject:removedSenderInfo];
			}

		}
		
		return [context save:&error];
	}
	else 
	{
		return YES;
	}
}

-(BOOL)updateOldGiftAutoDeletion:(NSString*)deleteDate
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *senderInfo;
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSError *error;
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		//run through each sender 
		for(int i=0; i<[objects count]; i++)
		{
			senderInfo=[objects objectAtIndex:i];
			
			NSString *giftPlist=[senderInfo valueForKey:@"SenderGiftPlist"];
			NSString *giftPlistPath=[docDirectory stringByAppendingPathComponent:giftPlist];
			
			NSMutableArray *oldGiftList=[NSMutableArray arrayWithContentsOfFile:giftPlistPath];
			
			for(NSMutableDictionary *oldGiftDic in oldGiftList)
			{
				//set auto deletion
				[oldGiftDic setValue:deleteDate forKey:@"AutoDeletionDate"];
			}
			
			[oldGiftList writeToFile:giftPlistPath atomically:NO];
		}
		
		return YES;
	}
	else 
	{
		return YES;
	}
}

-(BOOL)removeOldGiftFromSenderID:(NSString*)senderID GiftID:(NSString*)giftID
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *senderInfo=nil;

	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(SenderPhoneNumber=%@)", senderID];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		senderInfo=[objects objectAtIndex:0];
		
		NSString *giftPlist=[senderInfo valueForKey:@"SenderGiftPlist"];
		NSString *giftPlistPath=[docDirectory stringByAppendingPathComponent:giftPlist];
		
		NSMutableArray *oldGiftList=[NSMutableArray arrayWithContentsOfFile:giftPlistPath];
		
		for(int i=0; i<[oldGiftList count]; i++)
		{
			NSDictionary *giftDic=[oldGiftList objectAtIndex:i];
			NSString *giftIndentifier=[giftDic valueForKey:@"GiftID"];
			
			if([giftIndentifier isEqualToString:giftID])
			{
				[oldGiftList removeObjectAtIndex:i];
				
				break;
			}
		}
		
		//save list
		[oldGiftList writeToFile:giftPlistPath atomically:NO];
		
		[senderInfo setValue:[NSString stringWithFormat:@"%i", [oldGiftList count]] forKey:@"NumberOfGift"];
		
		return [context save:&error];
		
	}
	else 
	{
		return NO;
	}
}

-(BOOL)updateOldGiftAutoDeletionFromSenderID:(NSString*)senderID GiftID:(NSString*)giftID AutoDeletionDate:(NSString*)deleteDate
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	NSManagedObject *senderInfo=nil;
	
	
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory=[paths objectAtIndex:0];
	
	NSError *error;
	
	NSPredicate *pred=[NSPredicate predicateWithFormat:@"(SenderPhoneNumber=%@)", senderID];
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"SenderList" inManagedObjectContext:context];
	[request setEntity:entityDescription];
	[request setPredicate:pred];
	
	NSArray *objects=[context executeFetchRequest:request error:&error];
	
	[request release];
	
	if([objects count]>0)
	{
		senderInfo=[objects objectAtIndex:0];
		
		NSString *giftPlist=[senderInfo valueForKey:@"SenderGiftPlist"];
		NSString *giftPlistPath=[docDirectory stringByAppendingPathComponent:giftPlist];
		
		NSMutableArray *oldGiftList=[NSMutableArray arrayWithContentsOfFile:giftPlistPath];
		
		for(int i=0; i<[oldGiftList count]; i++)
		{
			NSDictionary *giftDic=[oldGiftList objectAtIndex:i];
			NSString *giftIndentifier=[giftDic valueForKey:@"GiftID"];
			
			if([giftIndentifier isEqualToString:giftID])
			{
				[giftDic setValue:deleteDate forKey:@"AutoDeletionDate"];
				
				break;
			}
		}
		
		//save list
		[oldGiftList writeToFile:giftPlistPath atomically:NO];
		
		return YES;
		
	}
	else 
	{
		return NO;
	}
}

-(void)dealloc
{
	[super dealloc];
}

@end
