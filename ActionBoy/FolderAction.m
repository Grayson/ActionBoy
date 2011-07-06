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
@synthesize isEnabled = _isEnabled;

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
	[coder encodeBool:self.isEnabled forKey:@"isEnabled"];
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [self init];
	if (!self) return nil;
	self.folderPath = [coder decodeObjectForKey:@"folderPath"];
	self.destinationPath = [coder decodeObjectForKey:@"destinationPath"];
	self.predicate = [coder decodeObjectForKey:@"predicate"];
	self.action = (NSUInteger)[coder decodeIntForKey:@"action"];
	self.isEnabled = [coder decodeBoolForKey:@"isEnabled"];
    return self;
}

- (NSArray *)matchedFiles {
	// Get master list of files
	NSMutableArray *files = [NSMutableArray array];
	for (NSString *fileName in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.folderPath error:nil])
		[files addObject:[self.folderPath stringByAppendingPathComponent:fileName]];
	
	return [files filteredArrayUsingPredicate:self.predicate];
}

- (void)performActions {
	NSFileManager *fm = [NSFileManager defaultManager];
	for (NSString *file in [self matchedFiles]) {
		if (self.action == kCopyAction) [fm copyItemAtPath:file toPath:[self.destinationPath stringByAppendingPathComponent:[file lastPathComponent]] error:nil];
		else if (self.action == kMoveAction) [fm moveItemAtPath:file toPath:self.destinationPath error:nil];
		else if (self.action == kScriptAction) {
			// Should code this...
		}
		else if (self.action == kLogAction) NSLog(@"[FolderAction LogAction]: %@", file);
	}
}

@end
