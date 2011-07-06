//
//  FolderActionToStringTransformer.m
//  ActionBoy
//
//  Created by Grayson Hansard on 7/4/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "FolderActionToStringTransformer.h"


@implementation FolderActionToStringTransformer

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

+(void)initialize {
	[NSValueTransformer setValueTransformer:[[[self class] new] autorelease] forName:@"FolderActionToStringTransformer"];
}
+ (Class)transformedValueClass { return [NSString class]; }
+ (BOOL)allowsReverseTransformation { return NO; }
- (id)transformedValue:(FolderAction *)value {
	if (value == nil) return nil;
	
	if (value.action == kScriptAction) {
		return [NSString stringWithFormat:NSLocalizedString(@"Run script %@ on files in %@.", @"Label transformer string"), 
			value.destinationPath.lastPathComponent, 
			value.folderPath.lastPathComponent,
			nil];
	}
	
	return [NSString stringWithFormat:NSLocalizedString(@"%@ files in %@ to %@.", @"Label transformer string"),
		value.action == kCopyAction ? NSLocalizedString(@"Copy", @"Label transformer component") : NSLocalizedString(@"Move", @"Label transformer component"),
		value.folderPath.lastPathComponent,
		value.destinationPath.lastPathComponent,
		nil];
}

@end
