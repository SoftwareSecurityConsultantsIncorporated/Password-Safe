//
//  SecondViewController.h
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPasswordViewController.h"
#import "CoreDataTableViewController.h"
#import "Password.h"
#import "passwordDetailViewController.h"
@interface PasswordViewController : CoreDataTableViewController <AddpasswordControllerDelegate, passwordDetailViewControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Password *selectedPassword;
@end
