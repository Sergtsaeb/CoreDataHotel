//
//  DatePickerViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/25/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AvailabilityViewController.h"
#import "AppDelegate.h"

@interface DatePickerViewController ()

@property(strong, nonatomic) UIDatePicker *endDate;

@end

@implementation DatePickerViewController

-(void)loadView {
    [super loadView];
    
    [self setupDatePickers];
    [self setupDoneBUtton];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)setupDoneBUtton{
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    
}

-(void)doneButtonPressed{
    
    NSDate *endDate = self.endDate.date;
    
    if ([[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        self.endDate.date = [NSDate date];
        return;
    }
    
    AvailabilityViewController *availabilityController = [[AvailabilityViewController alloc]init];
    
    [self.navigationController pushViewController:availabilityController animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
                      
-(void)setupDatePickers{
    
    self.endDate = [[UIDatePicker alloc]init];
    self.endDate.datePickerMode = UIDatePickerModeDate;
    
    
    //Redefine this into autolayout
    self.endDate.frame = CGRectMake(0, 84.0, self.view.frame.size.width, 200.0);
    
    [self.view addSubview:self.endDate];
                          
}

@end
