//
//  AddActionController.h
//  ActionBoy
//
//  Created by Grayson Hansard on 6/29/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AddActionController : NSObject {
@private
    IBOutlet NSWindow *_window;
	IBOutlet NSPredicateEditor *_predicateEditor;
	NSString *_filePath;
}
@property (retain) NSWindow *window;
@property (retain) NSPredicateEditor *predicateEditor;
@property (retain) NSString *filePath;
@property (retain) NSArray *files;

- (IBAction)open:(id)sender;
- (IBAction)chooseFolder:(id)sender;

- (IBAction)cancel:(id)sender;
- (IBAction)apply:(id)sender;

- (IBAction)predicateEditorRulesHaveChanged:(id)sender;

@end
