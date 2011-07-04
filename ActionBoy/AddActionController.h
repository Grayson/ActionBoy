//
//  AddActionController.h
//  ActionBoy
//
//  Created by Grayson Hansard on 6/29/11.
//  Copyright 2011 From Concentrate Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FolderAction.h"
#import "common.h"

@interface AddActionController : NSObject {
@private
    IBOutlet NSWindow *_window;
	IBOutlet NSPredicateEditor *_predicateEditor;
	IBOutlet NSTabView *_tabView;
	IBOutlet NSPopUpButton *_actionButton;
	IBOutlet NSButton *_chooseLocationButton;
	NSString *_filePath;
	NSString *_actionPath;
}
@property (retain) NSWindow * window;
@property (retain) NSPredicateEditor * predicateEditor;
@property (retain) NSTabView * tabView;
@property (retain) NSPopUpButton * actionButton;
@property (retain) NSButton * chooseLocationButton;
@property (retain) NSString * filePath;
@property (retain) NSString * actionPath;

- (IBAction)open:(id)sender;
- (IBAction)chooseFolder:(id)sender;
- (IBAction)chooseLocation:(id)sender;

- (IBAction)cancel:(id)sender;
- (IBAction)apply:(id)sender;
- (IBAction)changeTabView:(id)sender;

- (IBAction)predicateEditorRulesHaveChanged:(id)sender;

@end
