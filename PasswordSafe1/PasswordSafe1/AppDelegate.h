//
//  AppDelegate.h
//  PasswordSafe1
//
//  Created by CSSE Department on 2/12/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BOOL downloadDone;
    BOOL loggedIn;
    User *user;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (AppDelegate *)sharedAppDelegate;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)getServerURL;
- (void)setServerURL: (NSString *) input;
- (NSString *)getUsername;
- (void)setUsername: (NSString *) input;
- (NSString *)getPassword;
- (void)setPassword: (NSString *) input;
- (NSString *) getFilepath;
- (NSString *) getDownloadedFilepath;
- (void) downloadDone;
- (void) loggedIn;
- (BOOL) getLoggedIn;
- (void) setUser:(User *)theUser;
- (User *) getUser;
- (void)syncFiles;
- (void) sync;

@end
