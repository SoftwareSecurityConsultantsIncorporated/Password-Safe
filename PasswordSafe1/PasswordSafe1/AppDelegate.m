//
//  AppDelegate.m
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "AppDelegate.h"
#import "NoteViewController.h"

#import <CoreData/CoreData.h>
#import "PasswordViewController.h"
#import "WebDavAPI.h"
#import "XMLParserDelegate.h"
#import "Password.h"


@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // The Tab Bar
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    // The Two Navigation Controllers attached to the Tab Bar (At Tab Bar Indexes 0 and 1)
    UINavigationController *notesTVCnav = [[tabBarController viewControllers] objectAtIndex:0];
    UINavigationController *passwordsTVCnav = [[tabBarController viewControllers] objectAtIndex:1];
    
    // The Persons Table View Controller (First Nav Controller Index 0)
    NoteViewController *notesTVC = [[notesTVCnav viewControllers] objectAtIndex:0];
    notesTVC.managedObjectContext = self.managedObjectContext;
    
    // The Roles Table View Controller (Second Nav Controller Index 0)
    PasswordViewController *passwordTVC = [[passwordsTVCnav viewControllers] objectAtIndex:0];
    passwordTVC.managedObjectContext = self.managedObjectContext;
    
    //NOTE: Be very careful to change these indexes if you change the tab order
    
    // The following stuff was commented out since we're using a Tab Bar Controller
    //UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    //RolesTVC *controller = (RolesTVC *)navigationController.topViewController;
    //controller.managedObjectContext = self.managedObjectContext;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSMutableString *xml = [[NSMutableString alloc] init];
    [xml appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"];
    [xml appendString:@"<content>"];
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    [xml appendFormat:@"<timestamp>%f</timestamp>", timeStamp];
    
    NSManagedObjectContext *m = [self managedObjectContext];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
	
	[req setEntity:[NSEntityDescription entityForName:@"Password" inManagedObjectContext:m]];
    [req setIncludesPropertyValues:NO];
    NSArray *pw = [m executeFetchRequest:req error:nil];
    for(Password *password in pw){
        [xml appendString:@"<passwordEntry>"];
        [xml appendFormat:@"<passwordTitle>%@</passwordTitle>", password.title];
        [xml appendFormat:@"<username>%@</username>", password.username];
        [xml appendFormat:@"<password>%@</password>", password.password];
        [xml appendFormat:@"<site>%@</site>", password.site];
        [xml appendFormat:@"<description>%@</description>", password.pwDecscription];
        [xml appendString:@"</passwordEntry>"];
    }
    
    [req setEntity:[NSEntityDescription entityForName:@"Note" inManagedObjectContext:m]];
    [req setIncludesPropertyValues:NO];
    NSArray *notes = [m executeFetchRequest:req error:nil];
    for(Note *note in notes){
        [xml appendString:@"<noteEntry>"];
        [xml appendFormat:@"<noteTitle>%@</noteTitle>", note.title];
        [xml appendFormat:@"<content>%@</content>", note.content];
        [xml appendString:@"</noteEntry>"];
    }
    
    [xml appendString:@"</content>"];
    [xml writeToFile:[self getFilepath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    WebDAVAPI *api = [[WebDAVAPI alloc] init];
    downloadDone = FALSE;
    [api download];
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!downloadDone && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    NSData* serverData = [[NSData alloc] initWithContentsOfFile:[self getDownloadedFilepath]];
    NSData* localData = [[NSData alloc] initWithContentsOfFile:[self getFilepath]];
    NSXMLParser *serverParser = [[NSXMLParser alloc] initWithData:serverData];
    NSXMLParser *localParser = [[NSXMLParser alloc] initWithData:localData];
    
    XMLParserDelegate *serverDelegate = [[XMLParserDelegate alloc] init];
    [serverDelegate setJustNeedTimestamp];
    [serverParser setDelegate:serverDelegate];
    [serverParser parse];
    
    XMLParserDelegate *localDelegate = [[XMLParserDelegate alloc] init];
    [localDelegate setJustNeedTimestamp];
    [localParser setDelegate:localDelegate];
    [localParser parse];
    
    double serverTimestamp = [serverDelegate getTimestamp];
    double localTimestamp = [localDelegate getTimestamp];
    
    if(serverTimestamp >= localTimestamp){
        NSLog(@"Server more recent");
        [serverData writeToFile:[self getFilepath] atomically:YES];
        
        NSFetchRequest *fetchPasswords = [[NSFetchRequest alloc] init];
        [fetchPasswords setEntity:[NSEntityDescription entityForName:@"Password" inManagedObjectContext:self.managedObjectContext]];
        NSArray *passwordsToDelete = [self.managedObjectContext executeFetchRequest:fetchPasswords error:nil];
        for(Password *passwordToDelete in passwordsToDelete){
            [self.managedObjectContext deleteObject:passwordToDelete];
        }
        NSFetchRequest *fetchNotes = [[NSFetchRequest alloc] init];
        [fetchNotes setEntity:[NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.managedObjectContext]];
        NSArray *notesToDelete = [self.managedObjectContext executeFetchRequest:fetchNotes error:nil];
        for(Note *noteToDelete in notesToDelete){
            [self.managedObjectContext deleteObject:noteToDelete];
        }
        [self.managedObjectContext save:nil];
        
        NSData* newLocalData = [[NSData alloc] initWithContentsOfFile:[self getFilepath]];
        NSXMLParser *updatedParser = [[NSXMLParser alloc] initWithData:newLocalData];
        XMLParserDelegate *updatedDelegate = [[XMLParserDelegate alloc] init];
        [updatedParser setDelegate:updatedDelegate];
        [updatedParser parse];
        
        [self.managedObjectContext save:nil];
    }else {NSLog(@"Local more recent");}
    
    [api upload];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PasswordSafeData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PasswordSafeData.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)getServerURL
{
    return [NSURL URLWithString:@"https://sync14.omnigroup.com/passwordsync/passwordSync/password.xml"];
}

- (NSString *) getFilepath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    return [cachesDirectory stringByAppendingPathComponent:@"password.xml"];
}

- (NSString *) getDownloadedFilepath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    return [cachesDirectory stringByAppendingPathComponent:@"passwordDownloaded.xml"];
}

- (void) downloadDone
{
    downloadDone = TRUE;
}

@end
