//
//  RoomsViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/24/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "RoomsViewController.h"
#import "Room+CoreDataProperties.h"
#import "Room+CoreDataClass.h"

#import "AutoLayout.h"
#import "AppDelegate.h"

#import "Hotel+CoreDataClass.h"


@interface RoomsViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) NSArray *allRooms;
@property(strong, nonatomic)UITableView *roomTableView;

@end

@implementation RoomsViewController

-(void)loadView {
    [super loadView];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.roomTableView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.roomTableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RoomCell"];
    self.allRooms = [self.selectedHotel.rooms allObjects];
    
}

-(NSArray *)allRooms {
    if (!_allRooms) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        
        NSError *fetchError;
        NSArray *rooms = [context executeFetchRequest:request error:&fetchError];
        
        if (fetchError) {
            NSLog(@"There was an error fetching hotels from core data!");
        }
        
        _allRooms = rooms;
    }
    
    return _allRooms;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_allRooms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell" forIndexPath:indexPath];

    Room *room = self.allRooms[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%hd", room.number];
    
    return cell;
}


@end
