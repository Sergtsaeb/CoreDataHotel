//
//  ViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/24/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "ViewController.h"
#import "AutoLayout.h"
#import "HotelsViewController.h"
#import "DatePickerViewController.h"
#import "LookupReservationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLayout];
    
}

-(void)setupLayout {
    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse"];
    browseButton.backgroundColor = [UIColor colorWithRed: 0.33 green: 0.5 blue: 0.51 alpha: 1];
    [AutoLayout leadingConstraintFrom:browseButton toView:self.view];
    [AutoLayout trailingConstraintFrom:browseButton toView:self.view];
    
    
    UIButton *bookButton = [self createButtonWithTitle:@"Book"];
    bookButton.backgroundColor = [UIColor colorWithRed: .23 green: 0.17 blue: 0.21 alpha: 1];
    [AutoLayout leadingConstraintFrom:bookButton toView:self.view];
    [AutoLayout trailingConstraintFrom:bookButton toView:self.view];
    
    UIButton *lookupButton  = [self createButtonWithTitle:@"Look up"];
    lookupButton.backgroundColor = [UIColor colorWithRed: 0.45 green: 0.56 blue: 0.33 alpha: 1];
    [AutoLayout leadingConstraintFrom:lookupButton toView:self.view];
    [AutoLayout trailingConstraintFrom:lookupButton toView:self.view];
    
    float navBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    CGFloat statusBarHeight = 20.0;
    CGFloat topMargin = navBarHeight + statusBarHeight;
    CGFloat windowHeight = self.view.frame.size.height;
    CGFloat buttonHeight = ((windowHeight - topMargin) / 3);
    
    NSDictionary *viewDictionary = @{@"browseButton": browseButton, @"bookButton": bookButton, @"lookUpButton": lookupButton};
    NSDictionary *metricsDictionary = @{@"topMargin": [NSNumber numberWithFloat:topMargin], @"buttonHeight": [NSNumber numberWithFloat:buttonHeight]};
    NSString *visualFormatString = @"V:|-topMargin-[browseButton(==buttonHeight)][bookButton(==browseButton)][lookUpButton(==browseButton)]|";
    
    [AutoLayout constraintsWithVFLForViewDictionary: viewDictionary forMetricsDictionary: metricsDictionary withOptions: 0 withVisualFormat: visualFormatString];
    
    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [bookButton addTarget:self action:@selector(bookButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [lookupButton addTarget:self action:@selector(lookupButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)browseButtonSelected {
    
    HotelsViewController *hotelVC =[[HotelsViewController alloc] init];
    [self.navigationController pushViewController: hotelVC animated:YES];
}

-(void)bookButtonSelected {
    
    DatePickerViewController *datePickerController = [[DatePickerViewController alloc]init];
    [self.navigationController pushViewController:datePickerController animated:YES];
    
}

-(void)lookupButtonSelected {
    
    //transition to  the LookUpReservationController
    
    LookupReservationViewController *ResLookup = [[LookupReservationViewController alloc]init];
    [self.navigationController pushViewController:ResLookup animated:YES];
    
}


-(UIButton *)createButtonWithTitle:(NSString *)title {
    
    UIButton *button = [[UIButton alloc]init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:button];
    
    return button;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
