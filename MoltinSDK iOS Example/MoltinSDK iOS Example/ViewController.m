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
            NSLog(@"Search without params ERROR!!! %@", error);
        }
        else {
            NSLog(@"RESPONSE (product search): %@", response);
        }
    }];*/
    
    [[Moltin sharedInstance].product getModifiersWithId:@"1004136473257050831" callback:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Product modifiers ERROR!!! %@", error);
        }
        else {
            NSLog(@"RESPONSE (product modifiers): %@", response);
        }
    }];
    
    [[Moltin sharedInstance].customer listingWithParameters:nil callback:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Customers listing ERROR!!! %@", error);
        }
        else {
            NSLog(@"RESPONSE (customer listings): %@", response);
        }
    }];
    
    /*
     DEMO CUSTOMER:
     {
     "created_at" = "2015-06-14 22:49:14";
     email = "mmmm@ggg.bbb";
     "first_name" = "CD cd";
     group = "<null>";
     history =     {
     addresses = 2;
     orders = 1;
     value = "28.01";
     };
     id = 1007489686488220132;
     "last_name" = gdc;
     order = "<null>";
     "updated_at" = "2015-06-14 22:49:14";
     },
     */
    
    [[Moltin sharedInstance].address findWithCustomerId:@"1007489686488220132" andParameters:nil callback:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Address find ERROR!!! %@", error);
        }
        else {
            NSLog(@"RESPONSE (address find with customer id): %@", response);
        }
    }];
    
    [[Moltin sharedInstance].collection listingWithParameters:@{@"slug" : @"lacko"} callback:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Collection listing ERROR!!! %@", error);
        }
        else {
            NSLog(@"RESPONSE (collection listing): %@", response);
        }
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
