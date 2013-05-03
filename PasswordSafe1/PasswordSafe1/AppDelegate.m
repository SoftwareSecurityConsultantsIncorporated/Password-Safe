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
#import "LoginViewController.h"
#import "TabBarViewController.h"

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
    TabBarViewController *tabBarController = (TabBarViewController *)self.window.rootViewController;
    
    UINavigationController *notesTVCnav = [[tabBarController viewControllers] objectAtIndex:0];
    UINavigationController *passwordsTVCnav = [[tabBarController viewControllers] objectAtIndex:1];
    
    NoteViewController *notesTVC = [[notesTVCnav viewControllers] objectAtIndex:0];
    notesTVC.managedObjectContext = self.managedObjectContext;
    
    PasswordViewController *passwordTVC = [[passwordsTVCnav viewControllers] objectAtIndex:0];
    passwordTVC.managedObjectContext = self.managedObjectContext;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    loggedIn = FALSE;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    loggedIn = false;
    
    NSMutableString *xml = [[NSMutableString alloc] init];
    [xml appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"];
    [xml appendString:@"<content>"];
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    [xml appendFormat:@"<timestamp>%f</timestamp>", timeStamp];
    
    NSManagedObjectContext *m = [self managedObjectContext];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
	
	[req setEntity:[NSEntityDescription entityForName:@"Password" inManagedObjectContext:m]];
    [req setIncludesPropertyValues:NO];
    NSArray *pws = [m executeFetchRequest:req error:nil];
    for(Password *pw in pws){
        [xml appendString:@"<passwordEntry>"];
        [xml appendFormat:@"<passwordTitle>%@</passwordTitle>", pw.title];
        [xml appendFormat:@"<username>%@</username>", pw.username];
        [xml appendFormat:@"<password>%@</password>", pw.password];
        [xml appendFormat:@"<site>%@</site>", pw.site];
        [xml appendFormat:@"<description>%@</description>", pw.pwDecscription];
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
    loggedIn = FALSE;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    loggedIn = FALSE;
    TabBarViewController *tabBarController = (TabBarViewController *)self.window.rootViewController;
    [tabBarController LoginScreePopUp];
    


}

- (void) sync
{
    WebDAVAPI *api = [[WebDAVAPI alloc] init];
    downloadDone = FALSE;
    [api download];
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (![api connectionDone] && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    if([api validCredentials]){
        [self syncFiles];
        [api upload];
    }
}

- (void)syncFiles
{
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack


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

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PasswordSafeData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PasswordSafeData.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
               NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)getServerURL
{
    return [NSURL URLWithString:user.serverURL];
}

- (void)setServerURL: (NSString *) input
{
    user.serverURL = input;
}

- (NSString *)getUsername
{
    return user.serverUsername;
}

- (void)setUsername: (NSString *) input
{
    user.serverUsername = input;
}

- (NSString *)getPassword
{
    return user.serverPassword;
}
- (void)setPassword: (NSString *) input
{
    user.serverPassword = input;
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

- (void) loggedIn
{
    loggedIn = TRUE;
}

- (BOOL) getLoggedIn
{
    return loggedIn;
}

- (void) setUser:(User *)theUser
{
    user = theUser;
}

- (User *) getUser
{
    return user;
}


@end
