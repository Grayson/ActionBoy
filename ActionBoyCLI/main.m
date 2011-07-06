//
//  main.m
//  ActionBoyCLI
//
//  Created by Grayson Hansard on 7/6/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FolderAction.h"
#import "common.h"

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
	NSString *path = [[NSUserDefaults standardUserDefaults] stringForKey:@"path"];    
	if (!path) return 0;

	NSData *actionData = [[[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.fromconcentratesoftware.actionboy"] objectForKey:kPrefsActionDataKey];
	if (!actionData) return 0;
    
	NSArray *actions = [NSKeyedUnarchiver unarchiveObjectWithData:actionData];
	if (!actions) return 0;	
	
	NSURL *pathURL = [NSURL fileURLWithPath:path];
	for (FolderAction *action in actions) {
		NSURL *actionURL = [NSURL fileURLWithPath:action.folderPath];
		if (![actionURL isEqual:pathURL]) continue;
		[action performActions];
	}

    [pool drain];
    return 0;
}

