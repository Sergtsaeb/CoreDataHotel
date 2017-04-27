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

@interface LookupReservationViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property(strong, nonatomic)UISearchBar *searchBar;
@property(strong, nonatomic)UISearchController *searchBarController;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSFetchedResultsController *allReservations;

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
    
//    self.searchBarController.dimsBackgroundDuringPresentation = NO;
//    self.searchBarController.searchBar.delegate = self;
//    _searchBarController.searchBar.sizeToFit()
//    self.tableView.tableHeaderView = searchController.searchBar;
    
    _searchBarController.searchResultsUpdater = self;
    _searchBarController.hidesNavigationBarDuringPresentation = false;
    _searchBarController.dimsBackgroundDuringPresentation = false;

}

-(void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lookupCell"];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
}

-(NSFetchedResultsController *)allReservations {
    if (!_allReservations) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSFetchRequest *reservationRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        
        NSSortDescriptor *hotelDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES];
        NSSortDescriptor *roomNumberDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"room.number" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:hotelDescriptor, roomNumberDescriptor, nil];
        
        reservationRequest.sortDescriptors = @[hotelDescriptor];
        reservationRequest.sortDescriptors = @[roomNumberDescriptor];
        
        _allReservations = [[NSFetchedResultsController alloc]initWithFetchRequest:reservationRequest managedObjectContext:appDelegate.persistentContainer.viewContext sectionNameKeyPath:@"reservation.guest.firstName" cacheName:nil];
        
        NSError *reservationError;
        [_allReservations performFetch:&reservationError];
        
    }
    
    return _allReservations;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.allReservations.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.allReservations sections] objectAtIndex:section];
    
    return sectionInfo.numberOfObjects;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lookupCell" forIndexPath:indexPath];
    Reservation *reservation = [self.allReservations objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", reservation.room];
    
    return cell;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _isSearching = YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    
}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    
//    [_filteredList removeAllObjects];
//    
//    if([searchText length] != 0) {
//        _isSearching = YES;
//    }
//    else {
//        _isSearching = NO;
//    }
//    
//    
//}





@end
