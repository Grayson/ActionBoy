//
//  ActionBoyAppDelegate.h
//  ActionBoy
//
//  Created by Grayson Hansard on 6/23/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"

@interface ActionBoyAppDelegate : NSObject <NSApplicationDelegate> {
@private
	MainWindowController *_mainWindowController;
}
@property (retain) MainWindowController *mainWindowController;
@end
