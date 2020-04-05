//
//  CititesViewController.m
//  PanicButton
//
//  Created by Елена Грачева on 06.04.15.
//  Copyright (c) 2015 BACCA. All rights reserved.
//

#import "CitiesViewController.h"
#import "CoreData+MagicalRecord.h"
#import "City.h"
#import "Const.h"

@interface CitiesViewController () {
    NSArray *cities;
}

@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cities = [City MR_findAllSortedBy:NSLocalizedString(@"LOCALE", @"") ascending:YES];
    self.titleLabel.text = NSLocalizedString(@"CHOOSE_COUNTRY", @"");
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TableView Datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CityCell"];
    }
    City *city = [cities objectAtIndex:indexPath.row];
    cell.textLabel.text = [city valueForKey:NSLocalizedString(@"LOCALE", @"")];
    cell.detailTextLabel.text = city.code;
    UIView *bg = [[UIView alloc] initWithFrame:cell.frame];
    bg.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = bg;
    return cell;
}


#pragma mark -
#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    City *city = [cities objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:city.code forKey:NAME_CODE];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Search Bar Delegate
//
//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ BEGINSWITH[cd] %@", NSLocalizedString(@"LOCALE", @""), searchString];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"en = 'Abkhazia'"];
//    cities = [City MR_findAllSortedBy:NSLocalizedString(@"LOCALE", @"") ascending:YES withPredicate:predicate];
//    return YES;
//}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSLocalizedString(@"LOCALE", @"") stringByAppendingString:@"  CONTAINS[cd] %@"], searchText];
    cities = [City MR_findAllSortedBy:NSLocalizedString(@"LOCALE", @"") ascending:YES withPredicate:predicate];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    cities = [City MR_findAllSortedBy:NSLocalizedString(@"LOCALE", @"") ascending:YES];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    
}

@end
