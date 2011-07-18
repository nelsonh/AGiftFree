//
//  AGiftWebService.m
//  AGiftFree
//
//  Created by Nelson on 3/7/11.
//  Copyright 2011 ASquare LLC. All rights reserved.
//

#import "AGiftWebService.h"
#import "SDZaGiftService.h"
#import "AGiftFreeAppDelegate.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "NSData+Base64.h"


@implementation AGiftWebService

@synthesize webService;
@synthesize currentRequest;
@synthesize delegate;

-(id)initAGiftWebService
{
	if(self=[super init])
	{
		SDZaGiftService *service=[[SDZaGiftService alloc] init];
		self.webService=service;
		[service release];
		
	}
	
	return self;
}

-(BOOL)cancelCurrentRequest
{
	return [currentRequest cancel];
}

#pragma mark web service
#pragma mark get Authorized key service and respond
-(BOOL)retrieveAuthorizedKeyWithUsername:(NSString*)username Password:(NSString*)password
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if([appDelegate isNetworkVaild])
	{
		if(username!=nil && password!=nil)
		{
			
			//request from server
			[appDelegate startNetworkActivity];
			currentRequest=[webService Auth:self action:@selector(retrieveAuthorizedKeyRespond:) username:username passwod:password];
			
			
			return YES;
		}
	}
	else 
	{
		[appDelegate networkConnectionError];
		[delegate aGiftWebService:self AuthorizedKeyDictionary:nil];
		
	}
	
	return NO;
}

-(void)retrieveAuthorizedKeyRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[delegate aGiftWebService:self AuthorizedKeyDictionary:nil];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[delegate aGiftWebService:self AuthorizedKeyDictionary:nil];
			[self cancel];
			return;
		}
		
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		[delegate aGiftWebService:self AuthorizedKeyDictionary:deserializedData];
	}
	
	[self cancel];
}

#pragma mark register service and respond
-(BOOL)registerWithPhoneNumber:(NSString*)phoneNumber userName:(NSString*)username profilePhoto:(NSData*)photo deviceID:(NSString*)udid
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	

	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			//encoding photo
			NSString *photo64Encoding=[photo base64Encoding];
			
			//fill data
			[dataDictionary setObject:phoneNumber forKey:@"PhoneNumber"];
			
			NSString *userName64=[[username dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
			[dataDictionary setObject:userName64 forKey:@"UserName"];
			[dataDictionary setObject:@"ProfilePhoto.png" forKey:@"ProfilePhotoName"];
			[dataDictionary setObject:photo64Encoding forKey:@"ProfilePhoto"];
			[dataDictionary setObject:@"IP" forKey:@"KindofPhone"];
			[dataDictionary setObject:udid forKey:@"PhoneDeviceID"];
			
			//DebugLog
			//NSLog(@"%@", photo64Encoding);
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService Register:self action:@selector(registerRespond:) key:authKey v_jsonProfile:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)registerRespond:(NSString*)jsonPackage;
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];

	[appDelegate stopNetworkActivity];
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		[delegate aGiftWebService:self RegisterDictionary:deserializedData];
	}
	
	[self cancel];
}

#pragma mark edit profile service and respond
-(BOOL)editProfileWithPhoneNumber:(NSString*)phoneNumber userName:(NSString*)username profilePhoto:(NSData*)photo
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];

	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			//encoding photo
			NSString *photo64Encoding=[photo base64Encoding];
			
			//fill data
			[dataDictionary setObject:phoneNumber forKey:@"PhoneNumber"];
			
			NSString *userName64=[[username dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
			[dataDictionary setObject:userName64 forKey:@"UserName"];
			[dataDictionary setObject:@"ProfilePhoto.png" forKey:@"ProfilePhotoName"];
			[dataDictionary setObject:photo64Encoding forKey:@"ProfilePhoto"];
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService EditProfile:self action:@selector(editProfileRespond:) key:authKey v_jsonEditProfile:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)editProfileRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		[delegate aGiftWebService:self EditProfileDictionary:deserializedData];
	}
	
	[self cancel];
}

#pragma mark receive new gift list service and respond
-(BOOL)ReceiveNewGiftList:(NSString*)phoneNumber
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeString:phoneNumber error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService GetGiftSumList:self action:@selector(ReceiveNewGiftListRespond:) key:authKey v_jsonFreeUserPhoneNumber:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)ReceiveNewGiftListRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		
		NSDictionary *giftSumlist=[deserializedData valueForKey:@"GiftSumList"];
		
		//get sum list back which has number of gifts
		NSArray *giftlist=[giftSumlist valueForKey:@"SumList"];
		

		[delegate aGiftWebService:self ReceiveNewGiftsArray:giftlist];
	}
	
	[self cancel];
}

#pragma mark receive first data and respond
-(BOOL)ReceiveFirstData:(NSString*)giftID DownloadBox3DObj:(BOOL)objYesOrNo DownloadBoxVideo:(BOOL)videoYesOrNo DownloadGiftIcon:(BOOL)iconYesOrNo
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			[dataDictionary setObject:giftID forKey:@"giftGUID"];
			
			if(objYesOrNo)
			{
				[dataDictionary setObject:@"Y" forKey:@"isDL3Dobj"];
			}
			else 
			{
				[dataDictionary setObject:@"N" forKey:@"isDL3Dobj"];
			}
			
			if(videoYesOrNo)
			{
				[dataDictionary setObject:@"Y" forKey:@"isDLVideo"];
			}
			else 
			{
				[dataDictionary setObject:@"N" forKey:@"isDLVideo"];
			}
			
			if(iconYesOrNo)
			{
				[dataDictionary setObject:@"Y" forKey:@"isDLSmailGiftPic"];
			}
			else 
			{
				[dataDictionary setObject:@"N" forKey:@"isDLSmailGiftPic"];
			}

			[dataDictionary setObject:@"N" forKey:@"isDLLockGiftBox"];
			
			[dataDictionary setObject:@"N" forKey:@"isDLPlayerBgPic"];

			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService GetGiftFirstMedia:self action:@selector(ReceiveFirstDataRespond:) key:authKey v_jsonDLMediaOption:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)ReceiveFirstDataRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		NSDictionary *firstData=[deserializedData valueForKey:@"firstPageMedia"];
		
		[delegate aGiftWebService:self ReceiveFirstDataDictionary:firstData];
	}
	
	[self cancel];
}

#pragma mark receive thirdData data and respond
-(BOOL)ReceiveThirdData:(NSString*)giftID DownloadGift3DObj:(BOOL)objYesOrNo DownloadGiftVideo:(BOOL)videoYesOrNo
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];

	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			[dataDictionary setObject:giftID forKey:@"giftGUID"];
			
			if(objYesOrNo)
			{
				[dataDictionary setObject:@"Y" forKey:@"isDL3Dobj"];
			}
			else 
			{
				[dataDictionary setObject:@"N" forKey:@"isDL3Dobj"];
			}
			
			if(videoYesOrNo)
			{
				[dataDictionary setObject:@"Y" forKey:@"isDLVideo"];
			}
			else 
			{
				[dataDictionary setObject:@"N" forKey:@"isDLVideo"];
			}
			
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService GetOpenGift:self action:@selector(ReceiveThirdDataRespond:) key:authKey v_jsonDLMediaOption:jsonPackage];
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)ReceiveThirdDataRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];

	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		NSDictionary *thirdData=[deserializedData valueForKey:@"GiftAnimation"];
		
		[delegate aGiftWebService:self ReceiveThirdDataDictionary:thirdData];
	}
	
	[self cancel];
}

#pragma mark update gift status and respond
-(BOOL)setGiftStatusWithGiftID:(NSString*)giftID Status:(NSString*)status
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];

	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			[dataDictionary setObject:giftID forKey:@"GiftGuid"];
			[dataDictionary setObject:status forKey:@"GiftStatus"];
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService SetGiftStatus:self action:@selector(setGiftStatusRespond:) key:authKey v_jsonUpdateGiftStatusModel:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)setGiftStatusRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		NSLog(@"update : %@", [deserializedData valueForKey:@"resbool"]);
	}
	
	[self cancel];
}

#pragma mark deleteGift and respond
-(BOOL)deleteGift:(NSString*)giftID
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//NSMutableDictionary *dataDictionary=[[NSMutableDictionary alloc] init];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			//[dataDictionary setObject:giftID forKey:@"GiftGuid"];
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeString:giftID error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService DeleteGift:self action:@selector(deleteGiftRespond:) key:authKey v_jsonGiftGuid:jsonPackage];
			
			//[dataDictionary release];
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	//[dataDictionary release];
	return NO;
}

-(void)deleteGiftRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		NSLog(@"delete gift : %@", [deserializedData valueForKey:@"resbool"]);
	}
	
	[self cancel];
}

#pragma mark unOpenDeleteGift and respond
-(BOOL)unOpenDeleteGift:(NSString*)giftID
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//NSMutableDictionary *dataDictionary=[[NSMutableDictionary alloc] init];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			//[dataDictionary setObject:giftID forKey:@"GiftGuid"];
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeString:giftID error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService UnOpenDeleteGift:self action:@selector(unOpenDeleteGiftRespond:) key:authKey v_jsonGiftGuid:jsonPackage];
			
			//[dataDictionary release];
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	//[dataDictionary release];
	return NO;
}

-(void)unOpenDeleteGiftRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		NSLog(@"unopen delete gift : %@", [deserializedData valueForKey:@"resbool"]);
	}
	
	[self cancel];
}

#pragma mark userExisted and respond
-(BOOL)userExisted:(NSString*)deviceID
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			[dataDictionary setObject:deviceID forKey:@"PhoneDeviceID"];
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService UserIsExist:self action:@selector(userExistedRespond:) key:authKey v_jsonProfile:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
		[delegate aGiftWebService:self userExistedDictionary:nil];
	}
	
	return NO;
}

-(void)userExistedRespond:(NSString*)jsonPackage
{
	NSError *error;
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[delegate aGiftWebService:self userExistedDictionary:nil];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[delegate aGiftWebService:self userExistedDictionary:nil];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		[delegate aGiftWebService:self userExistedDictionary:deserializedData];

	}
	
	[self cancel];
}

#pragma mark sendDeviceToken and respond
-(BOOL)registerDeviceToken:(NSData*)token phoneNumber:(NSString*)userPhoneNumber
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			[dataDictionary setObject:userPhoneNumber forKey:@"PhoneNumber"];
			
			//convert token to base64
			NSString *token64=[token base64Encoding];
			[dataDictionary setObject:token64 forKey:@"PushChannelID"];
			[dataDictionary setObject:@"Free" forKey:@"PaidOrFree"];
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService RegClientChannelUri:self action:@selector(registerDeviceTokenRespond:) key:authKey v_jsonChinnelUri:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)registerDeviceTokenRespond:(NSString*)jsonPackage
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	 
	
	[appDelegate stopNetworkActivity];
	
	[self cancel];
}

#pragma mark sendPushNotificationToReceiver and respond
-(BOOL)sendPushNotificationToSender:(NSString*)senderID
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			[dataDictionary setObject:senderID forKey:@"APReceiverPhoneNumber"];
			[dataDictionary setObject:@"PushNotifycation.wav" forKey:@"APSoundFile"];
			
			NSString *msg=[appDelegate.userName stringByAppendingString:@" opened your gift"];
			[dataDictionary setObject:msg forKey:@"APBody"];
			[dataDictionary setObject:@"aGiftPaidPushProduction" forKey:@"APKind"];
			
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService SendAPN:self action:@selector(sendPushNotificationToSenderRespond:) key:authKey v_jsonAPN:jsonPackage];
		
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	
	return NO;
}

-(void)sendPushNotificationToSenderRespond:(NSString*)jsonPackage
{
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	[self cancel];
}

#pragma mark trackfriendinfo and respond
-(BOOL)trackFriendInfo:(NSString*)clientPhoneNumber FriendID:(NSString*)friendID
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSMutableDictionary *dataDictionary=[[[NSMutableDictionary alloc] init] autorelease];
	
	//auth key
	NSString *authKey=appDelegate.userAuthorizedKey;
	
	if([appDelegate isNetworkVaild])
	{
		if(authKey!=nil)
		{
			[dataDictionary setObject:clientPhoneNumber forKey:@"ClientID"];
			[dataDictionary setObject:friendID forKey:@"FindID"];
			
			//serialize
			NSData *jsonData=[[CJSONSerializer serializer] serializeDictionary:dataDictionary error:&error];
			NSString *jsonPackage=[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
			
			//DebugLog
			//NSLog(@"js:%@", jsonPackage);
			
			//send to server
			[appDelegate startNetworkActivity];
			currentRequest=[webService FindFriend:self action:@selector(trackFriendInfoDataRespond:) key:authKey v_jsonFindUser:jsonPackage];
			
			
			return YES;
		}
	}
	else
	{
		[appDelegate networkConnectionError];
	}
	

	return NO;
}

-(void)trackFriendInfoDataRespond:(NSString*)jsonPackage
{
	NSError *error;
	
	AGiftFreeAppDelegate *appDelegate=(AGiftFreeAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[appDelegate stopNetworkActivity];
	
	//DebugLog
	//NSLog(@"%@", jsonPackage);
	
	if(delegate!=nil)
	{
		if([jsonPackage isKindOfClass:[NSError class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@"Service has an error occurred"];
			[self cancel];
			return;
		}
		else if([jsonPackage isKindOfClass:[SoapFault class]])
		{
			[appDelegate webServiceError:@"Service fail" message:@" Soap service fault"];
			[self cancel];
			return;
		}
		
		//DebugLog
		//NSLog(@"%@", jsonPackage);
		
		
		//deserialize
		NSData *jsonData=[jsonPackage dataUsingEncoding:NSUTF32BigEndianStringEncoding];
		NSDictionary *deserializedData=[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
		
		NSString *errorMsg=[deserializedData valueForKey:@"errorMsg"];
		
		if([errorMsg isEqualToString:@"success"])
		{
			NSDictionary *friendDic=[deserializedData valueForKey:@"QueryFriend"];
			
			[delegate aGiftWebService:self trackFriendInfoDictionary:friendDic];
		}
		else 
		{
			[delegate aGiftWebService:self trackFriendInfoDictionary:nil];
		}
		
		
	}
	
	[self cancel];
}

-(void)dealloc
{
	
	if(webService)
	{
		self.webService=nil;
	}
	
	if(delegate)
	{
		self.delegate=nil;
	}
	
	[super dealloc];
}

@end
