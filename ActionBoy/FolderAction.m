//
//  FolderAction.m
//  ActionBoy
//
//  Created by Grayson Hansard on 7/3/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "FolderAction.h"


@implementation FolderAction
@synthesize folderPath = _folderPath;
@synthesize destinationPath = _destinationPath;
@synthesize action = _action;
@synthesize predicate = _predicate;
@dynamic isEnabled;

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
	self.folderPath = nil;
	self.destinationPath = nil;
	self.action = 0;
	self.predicate = nil;

    [super dealloc];
}

+ (id)action { return [[[self class] new] autorelease]; }

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.folderPath forKey:@"folderPath"];
	[coder encodeObject:self.destinationPath forKey:@"destinationPath"];
	[coder encodeObject:self.predicate forKey:@"predicate"];
	[coder encodeInt:(int)self.action forKey:@"action"];
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [self init];
	if (!self) return nil;
	self.folderPath = [coder decodeObjectForKey:@"folderPath"];
	self.destinationPath = [coder decodeObjectForKey:@"destinationPath"];
	self.predicate = [coder decodeObjectForKey:@"predicate"];
	self.action = (NSUInteger)[coder decodeIntForKey:@"action"];
    return self;
}

- (BOOL)isEnabled
{
	return NO;
}

- (void)setIsEnabled:(BOOL)aValue
{
	NSLog(@"%s", _cmd);
}

@end
