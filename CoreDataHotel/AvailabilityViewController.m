//
//  AvailabilityViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/25/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AutoLayout.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

#import "AppDelegate.h"

@interface AvailabilityViewController ()<UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSArray *availableRooms;

@end

@implementation AvailabilityViewController

-(NSArray *)availableRooms{
    
    if(!_availableRooms) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                                    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, self.startDate]; //reference self.startDate for lab 
        
        NSError *roomError;
        NSArray *results = [appDelegate.persistentContainer.viewContext executeFetchRequest:request error:&roomError];
        
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
        
        for (Reservation *reservation in results) {
            [unavailableRooms addObject:reservation.room];
        }
        
        NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        
        NSError *availableRoomError;
        _availableRooms = [appDelegate.persistentContainer.viewContext executeFetchRequest:roomRequest error:&availableRoomError];
        
    }
    
    return _availableRooms;
}


-(void)loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [AutoLayout fullScreenConstraintsWithVFLForView:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableRooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Room *currentToom = self.availableRooms[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i", currentToom.number];
    
    return cell;
}


@end
