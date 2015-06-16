//
//  ViewController.m
//  MoltinSDK iOS Example
//
//  Created by Gasper Rebernak on 08/06/15.
//  Copyright (c) 2015 Gasper Rebernak. All rights reserved.
//

#import "ViewController.h"
#import "Moltin.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *categories;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Categories";
    
    [Moltin sharedInstance].publicId = @"umRG34nxZVGIuCSPfYf8biBSvtABgTR8GMUtflyE";
    
    __weak ViewController *weakSelf = self;
    [[Moltin sharedInstance].category listingWithParameters:@{@"status" : @1} success:^(NSDictionary *response) {
        NSLog(@"RESPONSE (category listing): %@", response);
        weakSelf.categories = [response objectForKey:@"result"];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Category listing ERROR!!! %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    NSDictionary *category = [self.categories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [category valueForKey:@"title"];
    
    return cell;
}

@end
