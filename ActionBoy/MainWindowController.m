//
//  MainWindowController.m
//  ActionBoy
//
//  Created by Grayson Hansard on 6/23/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "MainWindowController.h"


@implementation MainWindowController
@dynamic folderActionsAreEnabled;
@synthesize folderActionsStatusScript = _folderActionsStatusScript;
@synthesize window = _window;

- (id)init
{
    self = [super init];
    if (self) {
		self.folderActionsStatusScript = [NSAppleScript appleScriptWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FolderActionStatus" ofType:@"scpt"]];

		[NSBundle loadNibNamed:@"MainWindow" owner:self];
		[NSTimer scheduledTimerWithTimeInterval:2. target:self selector:@selector(_pollForFolderActionStatus) userInfo:nil repeats:YES];
    }
    
    return self;
}

- (void)dealloc
{
	self.folderActionsStatusScript = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
	NSLog(@"%@", self.folderActionsStatusScript);
	NSLog(@"%@", [self.folderActionsStatusScript callHandler:@"areFolderActionsEnabled" withArguments:nil errorInfo:nil]);
}

- (BOOL)folderActionsAreEnabled
{
    NSAppleEventDescriptor *result = [self.folderActionsStatusScript callHandler:@"areFolderActionsEnabled" withArguments:nil errorInfo:nil];
	return (BOOL)[result booleanValue];
}

- (void)setFolderActionsAreEnabled:(BOOL)aValue
{
	// setFolderActionsEnabled
	NSAppleEventDescriptor *args = [NSAppleEventDescriptor listDescriptor];
	[args insertDescriptor:[NSAppleEventDescriptor descriptorWithBoolean:aValue] atIndex:0];
	[self.folderActionsStatusScript callHandler:@"setFolderActionsEnabled" withArguments:args errorInfo:nil];
}

@end
