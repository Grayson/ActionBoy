//
//  ArrayToStringTransformer.m
//  ActionBoy
//
//  Created by Grayson Hansard on 7/2/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "ArrayToStringTransformer.h"


@implementation ArrayToStringTransformer

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

+(void)load {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	[NSValueTransformer setValueTransformer:[[[self class] new] autorelease] forName:@"ArrayToStringTransformer"];
	[pool drain];
}
+ (Class)transformedValueClass { return [NSString class]; }
+ (BOOL)allowsReverseTransformation { return NO; }
- (id)transformedValue:(id)value {
    return (value == nil) ? nil : [value componentsJoinedByString:@", "];
}

@end
