//
//  NoteViewController.m
//  PasswordSafe
//
//  Created by CSSE Department on 1/22/13.
//  Copyright (c) 2013 Software Security Consultants Incorporated. All rights reserved.
//

#import "NoteViewController.h"

@implementation NoteViewController

NSArray *tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableData = [NSArray arrayWithObjects:@"Music", @"Credit Card", @"Groceries", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"simpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

@end
