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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                               inManagedObjectContext:self.managedObjectContext];
    
    note.title = __noteTitleTextField.text;
    note.content = __noteContentTextField.text;
    [self.managedObjectContext save:nil];  // write to database
    
    [self.delegate theSaveButtonOnTheAddNoteViewControllerWasTapped:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
