//
//  SecondViewController.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "PasswordViewController.h"

@interface passwordDetailViewController()

@end

@implementation PasswordViewController
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize selectedPassword;
- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Password";
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    
    //     3 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 4 - Fetch it
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Password Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Password *password = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = password.title;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Add Password Segue"])
	{
        NSLog(@"Setting passwordViewController as a delegate of AddpasswordViewController");
        
        AddpasswordViewController *addPasswordViewController = segue.destinationViewController;
        addPasswordViewController.delegate = self;
        addPasswordViewController.managedObjectContext = self.managedObjectContext;
	}
    else if ([segue.identifier isEqualToString:@"Edit Password Segue"])
    {
        passwordDetailViewController *passwordDetailController = segue.destinationViewController;
        passwordDetailController.delegate = self;
        passwordDetailController.managedObjectContext = self.managedObjectContext;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedPassword = [self.fetchedResultsController objectAtIndexPath:indexPath];
        passwordDetailController.password = self.selectedPassword;
    }
    else{
        NSLog(@"Unidentified Sugue Attempted");
    }
}

- (void)theSaveButtonOnTheAddpasswordViewControllerWasTapped:(AddpasswordViewController *)controller
{
    // do something here like refreshing the table or whatever
    
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];
}
- (void) theSaveButtonOnTheEditpasswordViewControllerWasTapped:(passwordDetailViewController *)controller
{
    // do something here like refreshing the table or whatever
    
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
        
        // Delete the role object that was swiped
        Password *passwordToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Deleting (%@)",  passwordToDelete.title);
        [self.managedObjectContext deleteObject:passwordToDelete];
        [self.managedObjectContext save:nil];
        
        // Delete the (now empty) row on the table
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performFetch];
        
        [self.tableView endUpdates];
    }
}


@end
