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
    NSAppleEventDescriptor *result = [[NSApp folderActionStatusScript] callHandler:@"folderHasAction"
                                                                     withArguments:[NSArray arrayWithObject:self.folderPath]
                                                                         errorInfo:nil];
	return (BOOL)[result booleanValue];
}

- (void)setIsEnabled:(BOOL)aValue
{
	[[NSApp folderActionStatusScript] callHandler:aValue ? @"attachAction" : @"detachAction"
                                    withArguments:[NSArray arrayWithObjects:self.folderPath, nil]
                                        errorInfo:nil];
}
@end
