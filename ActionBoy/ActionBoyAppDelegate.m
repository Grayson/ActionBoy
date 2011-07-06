//
//  ActionBoyAppDelegate.m
//  ActionBoy
//
//  Created by Grayson Hansard on 6/23/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "ActionBoyAppDelegate.h"

@implementation ActionBoyAppDelegate
@synthesize mainWindowController = _mainWindowController;

- (id)init
{
	self = [super init];
	if (!self) return nil;
	
	self.mainWindowController = [[MainWindowController new] autorelease];
	
	return self;
}

- (void)dealloc
{
	self.mainWindowController = nil;
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSString *appSupportFolder = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
	if (!appSupportFolder) return;
	NSString *abSupportFolder = [appSupportFolder stringByAppendingPathComponent:@"ActionBoy"];
	NSFileManager *fm = [NSFileManager defaultManager];
	BOOL isDir;
	if ([fm fileExistsAtPath:abSupportFolder isDirectory:&isDir] && isDir) goto checkScript;
	[fm createDirectoryAtPath:abSupportFolder withIntermediateDirectories:YES attributes:nil error:nil];
	
	checkScript:;
	if ([fm fileExistsAtPath:[abSupportFolder stringByAppendingPathComponent:@"ActionBoyFolderAction.scpt"] isDirectory:nil]) return;
	NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"ActionBoyFolderAction" ofType:@"scpt"];
	NSError *err = nil;
	[fm copyItemAtPath:scriptPath toPath:[abSupportFolder stringByAppendingPathComponent:[scriptPath lastPathComponent]] error:&err];
}

@end
