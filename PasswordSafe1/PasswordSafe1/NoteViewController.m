//
//  NoteViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()

@end

@implementation NoteViewController
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize selectedNote;
- (void)setupFetchedResultsController
{
    NSString *entityName = @"Note"; 
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self performFetch];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Note Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = note.title;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Add Note Segue"])
	{
        AddNoteViewController *addNoteViewController = segue.destinationViewController;
        addNoteViewController.delegate = self;
        addNoteViewController.managedObjectContext = self.managedObjectContext;
	}
    else if ([segue.identifier isEqualToString:@"Edit Note Segue"])
    {
        noteDetailViewController *noteDetailController = segue.destinationViewController;
        noteDetailController.delegate = self;
        noteDetailController.managedObjectContext = self.managedObjectContext;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedNote = [self.fetchedResultsController objectAtIndexPath:indexPath];
        noteDetailController.note = self.selectedNote;
    }
    else{
        NSLog(@"Unidentified Sugue Attempted");
    }
}


- (void)theSaveButtonOnTheAddNoteViewControllerWasTapped:(AddNoteViewController *)controller
{
    
    [controller.navigationController popViewControllerAnimated:YES];
}
- (void) theSaveButtonOnTheEditNoteViewControllerWasTapped:(noteDetailViewController *)controller
{
    
    [controller.navigationController popViewControllerAnimated:YES];

    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView beginUpdates]; 
        
        Note *noteToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Deleting (%@)",  noteToDelete.title);
        [self.managedObjectContext deleteObject:noteToDelete];
        [self.managedObjectContext save:nil];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performFetch];
        
        [self.tableView endUpdates];
    }
}


@end
