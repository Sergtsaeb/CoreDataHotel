//
//  LookupReservationViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/26/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "LookupReservationViewController.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "AppDelegate.h"



@interface LookupReservationViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property(strong, nonatomic)UISearchBar *searchBar;
@property(strong, nonatomic)UISearchController *searchBarController;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSArray *allReservations;

@property(strong, nonatomic)NSMutableArray *filteredList;
@property(strong, nonatomic)NSMutableArray *list;
@property Boolean *isSearching;

@end

@implementation LookupReservationViewController

-(void)loadView {
    [super loadView];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.searchBarController = [[UISearchController alloc] initWithSearchResultsController:self.tableView];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = _searchBar;

    [self setupTableView];
    [self setupSearchBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _list = [[NSMutableArray alloc]initWithObjects:@"iphone", @"ipod",@"macbook", nil];
    _filteredList = [[NSMutableArray alloc]init];
    
    
}

-(void)setupSearchBar {
//    self.searchBar.delegate = self;
//    self.searchBarController.delegate = self;
    
    self.searchBarController.dimsBackgroundDuringPresentation = NO;
    self.searchBarController.searchBar.delegate = self;
    
}


-(void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lookupCell"];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
//    [AutoLayout fullScreenConstraintsWithVFLForView:self.tableView];
}


-(NSArray *)allReservations {
    if (!_allReservations) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        
        NSError *fetchError;
        NSArray *reservations = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"There was an error fetching reservations from core data!");
        }
        
        _allReservations = reservations;
    }
    
    return _allReservations;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_isSearching) {
        return [_filteredList count];
    } else {
        return [_allReservations count];
    }
    
//    return _allReservations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lookupCell" forIndexPath:indexPath];
    
//    Reservation *reservation = self.allReservations[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", reservation.startDate];

    if (_isSearching) {
        cell.textLabel.text = [_filteredList objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [_list objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)searchTableList {
    NSString *searchString = _searchBar.text;
    
    for (NSString *tempStr in _list) {
        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [_filteredList addObject:tempStr];
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _isSearching = YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [_filteredList removeAllObjects];
    
    if([searchText length] != 0) {
        _isSearching = YES;
        [self searchTableList];
    }
    else {
        _isSearching = NO;
    }
    
    
}


- (void)willPresentSearchController:(UISearchController *)searchController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        searchController.searchResultsController.view.hidden = NO;
    });
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    searchController.searchResultsController.view.hidden = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}





@end
