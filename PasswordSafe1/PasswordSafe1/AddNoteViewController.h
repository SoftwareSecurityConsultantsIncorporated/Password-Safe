//
//  AddNoteViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@class AddNoteViewController;

@protocol AddNoteControllerDelegate

- (void)theSaveButtonOnTheAddNoteViewControllerWasTapped:(AddNoteViewController *)controller;

@end

@interface AddNoteViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (strong, nonatomic) IBOutlet UITextField *noteContentTextField;
@property (nonatomic, weak) id <AddNoteControllerDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)save:(id)sender;

@end
