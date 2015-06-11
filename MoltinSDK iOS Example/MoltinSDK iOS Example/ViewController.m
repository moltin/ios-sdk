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
    
    [[Moltin sharedInstance].category listingWithParameters:@{@"status": @1} callback:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Category listing ERROR!!! %@", error);
        }
        else {
            NSLog(@"RESPONSE (category listing): %@", response);
            self.categories = [response objectForKey:@"result"];
            [self.tableView reloadData];
        }
    }];
    
    /*[[Moltin sharedInstance].product searchWithParameters:nil callback:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"ERROR!!! %@", error);
        }
        else {
            NSLog(@"RESPONSE: %@", response);
        }
    }];*/
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
