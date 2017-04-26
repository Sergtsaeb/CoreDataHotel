//
//  BookViewController.h
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/25/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataClass.h"

@interface BookViewController : UIViewController

@property(strong, nonatomic)Room *selectedRoom;
@property(strong, nonatomic) NSDate *startDate;
@property(strong, nonatomic) NSDate *endDate;

@end
