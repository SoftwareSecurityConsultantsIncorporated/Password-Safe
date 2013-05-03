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
    NSString *entityName = @"Password";
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
        [controller.navigationController popViewControllerAnimated:YES];
}
- (void) theSaveButtonOnTheEditpasswordViewControllerWasTapped:(passwordDetailViewController *)controller
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView beginUpdates];         Password *passwordToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Deleting (%@)",  passwordToDelete.title);
        [self.managedObjectContext deleteObject:passwordToDelete];
        [self.managedObjectContext save:nil];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performFetch];
        
        [self.tableView endUpdates];
    }
}


@end
