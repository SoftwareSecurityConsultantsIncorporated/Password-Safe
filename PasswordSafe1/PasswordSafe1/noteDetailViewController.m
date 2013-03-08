//
//  noteDetailViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/13/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "noteDetailViewController.h"
#import "NoteViewController.h"
@interface AddNoteViewController ()

@end

@implementation noteDetailViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize noteTitleTextField = __noteTitleTextField;
@synthesize noteContentTextField = __noteContentTextField;
@synthesize note = __note;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Setting the value of fields in this static table to that of the passed Note");
    self.noteTitleTextField.text = self.note.title;
    self.noteContentTextField.text = self.note.content;
    [super viewDidLoad];
    
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the EditNoteController");
    [self.note setTitle:__noteTitleTextField.text];
    [self.note setContent:__noteContentTextField.text];
    [self.managedObjectContext save:nil];  // write to database
    
    [self.delegate theSaveButtonOnTheEditNoteViewControllerWasTapped:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
