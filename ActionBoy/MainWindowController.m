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
@synthesize toggleView = _toggleView;
@synthesize addActionController = _addActionController;

- (id)init
{
    self = [super init];
    if (self) {
		self.folderActionsStatusScript = [NSAppleScript appleScriptWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FolderActionStatus" ofType:@"scpt"]];

		[NSBundle loadNibNamed:@"MainWindow" owner:self];
		[NSTimer scheduledTimerWithTimeInterval:2. target:self selector:@selector(_pollForFolderActionStatus) userInfo:nil repeats:YES];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newActionNotification:) name:kNewActionNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
	self.folderActionsStatusScript = nil;
	self.toggleView = nil;
	self.window = nil;
	self.addActionController = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
	self.folderActionsAreEnabled = self.folderActionsAreEnabled;
}

- (BOOL)folderActionsAreEnabled
{
    NSAppleEventDescriptor *result = [self.folderActionsStatusScript callHandler:@"areFolderActionsEnabled" withArguments:nil errorInfo:nil];
	return (BOOL)[result booleanValue];
}

- (void)setFolderActionsAreEnabled:(BOOL)aValue
{
	NSAppleEventDescriptor *args = [NSAppleEventDescriptor listDescriptor];
	[args insertDescriptor:[NSAppleEventDescriptor descriptorWithBoolean:aValue] atIndex:0];
	[self.folderActionsStatusScript callHandler:@"setFolderActionsEnabled" withArguments:args errorInfo:nil];
	self.toggleView.state = !aValue;
}

- (IBAction)toggleFolderActionStatus:(id)sender {
	self.folderActionsAreEnabled = !self.toggleView.state;
}

- (IBAction)addAction:(id)sender {
	if (!self.addActionController) self.addActionController = [[AddActionController new] autorelease];
	[self.addActionController open:self];
}

@end
