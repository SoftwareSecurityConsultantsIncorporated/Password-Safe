//
//  AddNoteViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "AddNoteViewController.h"
#import "NoteViewController.h"
@interface AddNoteViewController ()

@end

@implementation AddNoteViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize noteTitleTextField = __noteTitleTextField;
@synthesize noteContentTextField = __noteContentTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                               inManagedObjectContext:self.managedObjectContext];
    
    note.title = __noteTitleTextField.text;
    note.content = __noteContentTextField.text;
    [self.managedObjectContext save:nil]; 
    
    [self.delegate theSaveButtonOnTheAddNoteViewControllerWasTapped:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
