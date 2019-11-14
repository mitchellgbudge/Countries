//
//  CountriesTableViewController.m
//  Countries-Solution
//
//  Created by Mitchell Budge on 11/14/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import "CountriesTableViewController.h"
#import "Countries_Solution-Swift.h"
#import "Country.h"

@interface CountriesTableViewController ()

@property (nonatomic, strong) CountryController *countryController;

@end

@implementation CountriesTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _countryController = [[CountryController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.countryController fetchCountriesWithCompletion:^(NSArray<Country *> * countries, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countryController.countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell" forIndexPath:indexPath];
    Country *country = self.countryController.countries[indexPath.row];
    cell.textLabel.text = country.name;
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
