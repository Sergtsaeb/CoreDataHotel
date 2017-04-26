//
//  LookupReservationViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/26/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "LookupReservationViewController.h"
#import "LookupReservationViewController.h"
#import "Reservation+CoreDataClass.h"



@interface LookupReservationViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)Reservation *allReservations;

@end

@implementation LookupReservationViewController

-(void)loadView {
    [super loadView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lookupCell"];
    
    
    return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return NO;
    
}

// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}

@end
