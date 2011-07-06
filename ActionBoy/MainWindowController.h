//
//  MainWindowController.h
//  ActionBoy
//
//  Created by Grayson Hansard on 6/23/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSAppleScript+FCSAdditions.h"
#import "ToggleView.h"
#import "AddActionController.h"
#import "FolderAction.h"
#import "common.h"

@interface MainWindowController : NSObject {
@private
	IBOutlet NSWindow *_window;
	IBOutlet ToggleView *_toggleView;

	AddActionController *_addActionController;

	NSAppleScript *_folderActionsStatusScript;
	
	NSArray *_folderActions;
}
@property (assign) BOOL folderActionsAreEnabled;
@property (retain) NSAppleScript *folderActionsStatusScript;
@property (assign) NSWindow *window;
@property (retain) ToggleView *toggleView;
@property (retain) AddActionController *addActionController;
@property (retain) NSArray *folderActions;

- (IBAction)toggleFolderActionStatus:(id)sender;
- (IBAction)addAction:(id)sender;
- (IBAction)saveActions:(id)sender;

@end
