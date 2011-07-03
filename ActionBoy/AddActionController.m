//
//  AddActionController.m
//  ActionBoy
//
//  Created by Grayson Hansard on 6/29/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import "AddActionController.h"


@implementation AddActionController
@synthesize window = _window;
@synthesize predicateEditor = _predicateEditor;
@synthesize predicate = _predicate;
@synthesize filePath = _filePath;
@dynamic files;

- (id)init
{
    self = [super init];
    if (self) {
		[NSBundle loadNibNamed:@"AddActionSheet" owner:self];
    }
    
    return self;
}

- (void)dealloc
{
	self.window = nil;
	self.predicate = nil;
	self.predicateEditor = nil;
	self.filePath = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
	NSArray *keyPaths = [NSArray arrayWithObjects:[NSExpression expressionForKeyPath:@"name"],
	                                              [NSExpression expressionForKeyPath:@"path"],
												  [NSExpression expressionForKeyPath:@"extension"], nil];
	NSArray *operators = [NSArray arrayWithObjects:[NSNumber numberWithInteger:NSEqualToPredicateOperatorType],
	                                               [NSNumber numberWithInteger:NSNotEqualToPredicateOperatorType],
	                                               [NSNumber numberWithInteger:NSBeginsWithPredicateOperatorType],
	                                               [NSNumber numberWithInteger:NSEndsWithPredicateOperatorType],
	                                               [NSNumber numberWithInteger:NSContainsPredicateOperatorType],
	                                               nil];

	NSPredicateEditorRowTemplate *template = [[NSPredicateEditorRowTemplate alloc] initWithLeftExpressions:keyPaths
	                                                                          rightExpressionAttributeType:NSStringAttributeType
	                                                                                              modifier:NSDirectPredicateModifier 
	                                                                                             operators:operators 
	                                                                                               options:(NSCaseInsensitivePredicateOption | NSDiacriticInsensitivePredicateOption)];

	NSArray *compoundTypes = [NSArray arrayWithObjects:[NSNumber numberWithInteger:NSAndPredicateType],
	                                                   [NSNumber numberWithInteger:NSOrPredicateType],
													   [NSNumber numberWithInteger:NSNotPredicateType],
	                                                   nil];
	NSPredicateEditorRowTemplate *compound = [[NSPredicateEditorRowTemplate alloc] initWithCompoundTypes:compoundTypes];

	NSArray *rowTemplates = [NSArray arrayWithObjects:template, compound, nil];
	[template release];
	[compound release];

	[self.predicateEditor setRowTemplates:rowTemplates];
}

+(NSSet *)keyPathsForValuesAffectingFiles {
	return [NSSet setWithObject:@"filePath"];
}

- (NSArray *)files
{
	if (self.filePath == nil) return nil;
	NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.filePath error:nil];
	if (fileNames == nil) return nil;
	
	NSMutableArray *files = [NSMutableArray array];
	for (NSString *fileName in fileNames) {
		NSString *name = [fileName stringByDeletingPathExtension];
		NSString *ext = [fileName pathExtension];
		if (ext == nil) ext = @"";
		[files addObject:[NSDictionary dictionaryWithObjectsAndKeys:name, @"name", ext, @"extension", nil]];
	}
	return files;
}

- (IBAction)chooseFolder:(id)sender {
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setCanChooseFiles:NO];
	[op setCanChooseDirectories:YES];
	if ([op runModal] != NSOKButton) return;
	self.filePath = [op filename];
}

- (IBAction)open:(id)sender {
	self.filePath = NSHomeDirectory();
	[NSApp beginSheet:self.window modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:nil contextInfo:nil];
	[self.predicateEditor addRow:self];
}

- (IBAction)cancel:(id)sender {
	[NSApp endSheet:self.window];
	[self.window orderOut:sender];
}

- (IBAction)apply:(id)sender {
	NSLog(@"%@", self.predicate);
	
	[NSApp endSheet:self.window];
	[self.window orderOut:sender];
}


@end
