//
//  HotelsViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/24/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "HotelsViewController.h"

#import "AppDelegate.h"

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

#import "AutoLayout.h"
#import "RoomsViewController.h"

@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray *allHotels;
@property(strong, nonatomic) UITableView *tableView;


@end

@implementation HotelsViewController

-(void)loadView {
    [super loadView];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self allHotels];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor blackColor];
    //add tableview as subview and apply constraints
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


-(NSArray *)allHotels {
    if (!_allHotels) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSError *fetchError;
        NSArray *hotels = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"There was an error fetching hotels from core data!");
        }
        
        _allHotels = hotels;
    }
    
    return _allHotels;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
    
    NSArray *hotels = _allHotels;
    Hotel *currentHotel = hotels[indexPath.row];
    cell.textLabel.text = currentHotel.name;
    
//    [cell updateConstraints];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RoomsViewController *roomsVC = [[RoomsViewController alloc] init];
    [self.navigationController pushViewController:roomsVC animated:YES];
    
    NSLog(@"selected %ld row", (long)indexPath.row);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_allHotels count];
    NSLog(@"%lu", (unsigned long)_allHotels.count);
}



@end
