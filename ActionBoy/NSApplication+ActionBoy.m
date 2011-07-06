//
//  NSApplication+ActionBoy.m
//  ActionBoy
//
//  Created by Grayson Hansard on 7/5/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "NSApplication+ActionBoy.h"


@implementation NSApplication (ActionBoy)

-(NSAppleScript *)folderActionStatusScript {
	static NSAppleScript *script = nil;
	if (!script) {
		NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"FolderActionStatus" ofType:@"scpt"]];
		script = [[NSAppleScript alloc] initWithContentsOfURL:url error:nil];
	}
	return script;
}

@end
