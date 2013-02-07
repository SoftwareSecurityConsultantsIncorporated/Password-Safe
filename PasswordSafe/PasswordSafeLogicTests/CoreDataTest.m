//
//  CoreDataTest.m
//  PasswordSafe
//
//  Created by CSSE Department on 1/24/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "CoreDataTest.h"
#import <SenTestingKit/SenTestingKit.h>
#import <CoreData/CoreData.h>
@implementation CoreDataTest
-(void) setUp{
    NSArray *bundles = [NSArray arrayWithObject:[NSBundle bundleForClass:[self class]]];
    NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:bundles];
    STAssertNotNil(mom, @"ManangedObjectModel is nil");
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    STAssertTrue([psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL] ? YES : NO, @"Should be able to add in-memory store");
    context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = psc;
    free(&mom);
    free(&psc);
    
}
-(void) testPasswordCreation{
    NSManagedObject *password = [NSEntityDescription insertNewObjectForEntityForName: @"Password" inManagedObjectContext:context];
    [password setValue:[NSNumber numberWithInt:17] forKey:@"id"];
    [password setValue:@"password" forKey:@"password"];
    NSError *error = nil;
    if (![context save:&error]) {
        STFail(@"Failed the test: %@, %@", error, [error userInfo]);
        }
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id==17"];
    [request setPredicate:predicate];
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array !=nil){
        STAssertEquals([array count], (NSUInteger) 1, @"There is not 1 object in the database");
    }else{
        STFail(@"Something went wrong");
    }
}
-(void) testGettingPasswordFromCoreData{
 
}

@end
