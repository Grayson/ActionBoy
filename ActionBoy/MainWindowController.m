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
@dynamic visibleActions;
@synthesize folderActionsStatusScript = _folderActionsStatusScript;
@synthesize window = _window;
@synthesize foldersWithActionsController = _foldersWithActionsController;
@synthesize toggleView = _toggleView;
@synthesize addActionController = _addActionController;
@synthesize folderActions = _folderActions;

- (id)init
{
    self = [super init];
    if (self) {
		self.folderActionsStatusScript = [NSAppleScript appleScriptWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FolderActionStatus" ofType:@"scpt"]];

		[NSBundle loadNibNamed:@"MainWindow" owner:self];
		[NSTimer scheduledTimerWithTimeInterval:2. target:self selector:@selector(_pollForFolderActionStatus) userInfo:nil repeats:YES];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newActionNotification:) name:kNewActionNotification object:nil];
		
		NSData *actionData = [[NSUserDefaults standardUserDefaults] objectForKey:kPrefsActionDataKey];
		if (!actionData) goto skipUnarchiveActions;
		NSArray *actions = [NSKeyedUnarchiver unarchiveObjectWithData:actionData];
		if (!actions) goto skipUnarchiveActions;
		self.folderActions = actions;
		
		skipUnarchiveActions:;
    }
    
    return self;
}

- (void)dealloc
{
	self.folderActionsStatusScript = nil;
	self.toggleView = nil;
	self.window = nil;
	self.addActionController = nil;
	self.foldersWithActionsController = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
	NSToolbar *tb = [[[NSToolbar alloc] initWithIdentifier:@"com.fromconcentratesoftware.actionboy.maintoolbar"] autorelease];
	tb.delegate = self;
	self.window.toolbar = tb;
	
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

- (NSArray *)visibleActions
{	
	NSString *path = [[self.foldersWithActionsController selectedObjects] lastObject];
	return [self.folderActions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"folderPath == %@", path]];
}

- (void)setVisibleActions:(NSArray *)aValue
{
	// noop
}

#pragma mark -
#pragma mark IBActions

- (IBAction)toggleFolderActionStatus:(id)sender {
	self.folderActionsAreEnabled = !self.toggleView.state;
}

- (IBAction)addAction:(id)sender {
	if (!self.addActionController) self.addActionController = [[AddActionController new] autorelease];
	[self.addActionController open:self];
}

- (IBAction)saveActions:(id)sender {
	NSData *actionData = [NSKeyedArchiver archivedDataWithRootObject:self.folderActions];
	if (!actionData) {
		// FIXME: Show an error here.
		return;
	}
	[[NSUserDefaults standardUserDefaults] setObject:actionData forKey:kPrefsActionDataKey];
}

#pragma mark -
#pragma mark Notifications

- (void)newActionNotification:(NSNotification *)aNotification
{
	FolderAction *action = [[aNotification userInfo] objectForKey:@"action"];
	if (!action) return;
	
	NSMutableArray *actions = [NSMutableArray arrayWithArray:self.folderActions];
	[actions addObject:action];
	self.folderActions = actions;
	[self saveActions:nil];
}

#pragma mark -
#pragma mark Delegate methods

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
	NSToolbarItem *item = [[[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier] autorelease];
	item.target = self;
	if ([itemIdentifier isEqualToString:@"toggle"]) {
		item.label = NSLocalizedString(@"Folder Action Status", @"toolbar label");
		item.view = self.toggleView;
		item.maxSize = NSMakeSize(92., 32.);
	}
	else if ([itemIdentifier isEqualToString:@"add"]) {
		item.label = NSLocalizedString(@"Add", @";");
		item.target = self;
		item.action = @selector(addAction:);
		item.image = [NSImage imageNamed:@"NSAddTemplate"];
	}
	else if ([itemIdentifier isEqualToString:@"remove"]) {
		item.label = NSLocalizedString(@"Remove", @";");
		item.target = self;
		item.image = [NSImage imageNamed:@"NSRemoveTemplate"];
	}
	item.paletteLabel = item.label;
	return item;
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
	return [NSArray arrayWithObjects:@"add", @"remove", @"toggle", NSToolbarCustomizeToolbarItemIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarSpaceItemIdentifier, NSToolbarSeparatorItemIdentifier, nil];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
	return [NSArray arrayWithObjects:@"toggle", NSToolbarSeparatorItemIdentifier, @"add", NSToolbarFlexibleSpaceItemIdentifier, nil];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
	return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
	self.visibleActions = nil;
}

@end
