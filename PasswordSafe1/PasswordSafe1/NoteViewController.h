//
//  NoteViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNoteViewController.h"
#import "CoreDataTableViewController.h"
#import "Note.h"
#import "noteDetailViewController.h"

@interface NoteViewController : CoreDataTableViewController <AddNoteControllerDelegate, noteDetailViewControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Note *selectedNote;
@end
