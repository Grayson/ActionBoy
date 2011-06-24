//
//  MainWindowController.h
//  ActionBoy
//
//  Created by Grayson Hansard on 6/23/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSAppleScript+FCSAdditions.h"


@interface MainWindowController : NSObject {
@private
	NSAppleScript *_folderActionsStatusScript;
	IBOutlet NSWindow *_window;
}
@property (assign) BOOL folderActionsAreEnabled;
@property (retain) NSAppleScript *folderActionsStatusScript;
@property (assign) NSWindow *window;

@end
