//
//  RoomsViewController.h
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/24/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel+CoreDataClass.h"

@interface RoomsViewController : UITableViewController

@property(strong, nonatomic) Hotel *selectedHotel;

@end
