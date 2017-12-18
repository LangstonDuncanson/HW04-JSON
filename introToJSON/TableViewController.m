//
//  TableViewController.m
//  introToJSON
//
//  Created by Lanjoudun on 12/18/17.
//  Copyright © 2017 cop2658.mdc.edu. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSArray * dataList;

@end

@implementation TableViewController
BOOL searchEnabled;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self readDataFromFile];
    
    [self.tableView reloadData];
}

-(void)readDataFromFile
{
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"ricardo" ofType:@"json"];
    
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    
    if(error)
    {
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    
    
    self.dataList = (NSArray *)[NSJSONSerialization
                                JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                options:0 error:NULL];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return [_dataList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"accountCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"%ld",indexPath.row);
    id keyValuePair;
    keyValuePair =self.dataList[indexPath.row];
    
    
    cell.number.text = [@"Number: " stringByAppendingString: keyValuePair[@"accountNumber"]];
    cell.type.text = [@"Type: " stringByAppendingString: keyValuePair[@"accountType"]];
    cell.currency.text = [@"Currency: " stringByAppendingString: keyValuePair[@"accountCurrency"]];
    cell.balance.text = [@"Balance: " stringByAppendingString: keyValuePair[@"accountBalance"]];
    cell.available.text = [@"Available: " stringByAppendingString: keyValuePair[@"accountAvailable"]];
    
    return cell;
}
@end
