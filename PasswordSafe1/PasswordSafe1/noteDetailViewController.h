//
//  noteDetailViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "Note.h"
@class noteDetailViewController;

@protocol noteDetailViewControllerDelegate

- (void)theSaveButtonOnTheEditNoteViewControllerWasTapped:(noteDetailViewController *)controller;

@end

@interface noteDetailViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (strong, nonatomic) IBOutlet UITextField *noteContentTextField;
@property (nonatomic, weak) id <noteDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Note *note;
- (IBAction)save:(id)sender;

@end