//
//  FolderAction+Applescript.m
//  ActionBoy
//
//  Created by Grayson Hansard on 7/6/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "FolderAction+Applescript.h"
#import "NSApplication+ActionBoy.h"


@implementation FolderAction (Applescript)
- (BOOL)isEnabled
{
	NSAppleEventDescriptor *args = [NSAppleEventDescriptor listDescriptor];
	[args insertDescriptor:[NSAppleEventDescriptor descriptorWithString:self.folderPath] atIndex:1];
    NSAppleEventDescriptor *result = [[NSApp folderActionStatusScript] callHandler:@"folderHasAction"
                                                                     withArguments:args
                                                                         errorInfo:nil];
	return (BOOL)[result booleanValue];
}

- (void)setIsEnabled:(BOOL)aValue
{
	NSDictionary *err = nil;
	NSAppleEventDescriptor *args = [NSAppleEventDescriptor listDescriptor];
	[args insertDescriptor:[NSAppleEventDescriptor descriptorWithString:self.folderPath] atIndex:1];
	[[NSApp folderActionStatusScript] callHandler:aValue ? @"attachAction" : @"detachAction"
                                    withArguments:args
                                        errorInfo:&err];
}
@end
