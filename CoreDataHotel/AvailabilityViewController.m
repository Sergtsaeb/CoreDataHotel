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
#import "BookViewController.h"

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"


@interface AvailabilityViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSFetchedResultsController *availableRooms;



@end

@implementation AvailabilityViewController

-(NSArray *)availableRooms{
    
    if(!_availableRooms) {
        
        //instantiate app delegate
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        //create fetch request for Reservation entity
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
        
        NSSortDescriptor *roomSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES];
        NSSortDescriptor *roomNumberSort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
        
        roomRequest.sortDescriptors = @[roomSortDescriptor];
        roomRequest.sortDescriptors = @[roomNumberSort];
        
        NSError *availableRoomError;
        
//        _availableRooms = [appDelegate.persistentContainer.viewContext executeFetchRequest:roomRequest error:&availableRoomError];
        
        _availableRooms = [[NSFetchedResultsController alloc]initWithFetchRequest:roomRequest managedObjectContext:appDelegate.persistentContainer.viewContext sectionNameKeyPath:@"hotel.name" cacheName:nil];
        
        [_availableRooms performFetch:&availableRoomError];
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
    
    NSLog(@"%@", _startDate);
    NSLog(@"%@", _endDate);
   
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [AutoLayout fullScreenConstraintsWithVFLForView:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections] objectAtIndex:section];
    
    
    return sectionInfo.numberOfObjects;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    Room *currentRoom = self.availableRooms[indexPath.row];
    Room *currentRoom = [self.availableRooms objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i", currentRoom.number];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Room *room = [_availableRooms objectAtIndexPath:indexPath];
    
    BookViewController *bookVC = [[BookViewController alloc]init];
    bookVC.selectedRoom = [self.availableRooms objectAtIndexPath:indexPath];
    
    bookVC.startDate = self.startDate;
    bookVC.endDate = self.endDate;
    bookVC.selectedRoom = room;
    
    [self.navigationController pushViewController:bookVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.availableRooms.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[_availableRooms sections] objectAtIndex:section];
    
    return sectionInfo.name;
}

@end
