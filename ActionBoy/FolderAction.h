//
//  FolderAction.h
//  ActionBoy
//
//  Created by Grayson Hansard on 7/3/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
	kCopyAction = 0,
	kMoveAction,
	kScriptAction,
	kLogAction = 0xFE,
	kNoAction = 0xFF
};


@interface FolderAction : NSObject<NSCoding> {
@private
	NSString *_folderPath;
	NSString *_destinationPath;
	NSUInteger _action;
	NSPredicate *_predicate;
}
@property (retain) NSString * folderPath;
@property (retain) NSString * destinationPath;
@property (assign) NSUInteger action;
@property (retain) NSPredicate * predicate;

+ (id)action;

- (NSArray *)matchedFiles;
- (void)performActions;

@end
