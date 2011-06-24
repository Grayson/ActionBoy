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
    // Insert code here to initialize your application
}

@end
