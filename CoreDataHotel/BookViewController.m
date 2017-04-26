//
//  BookViewController.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/25/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "BookViewController.h"
#import "AutoLayout.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "AppDelegate.h"

@interface BookViewController () <UITextFieldDelegate>

@property(strong, nonatomic)UITextField *firstName;
@property(strong, nonatomic)UITextField *lastName;
@property(strong, nonatomic)UITextField *email;

@end

@implementation BookViewController

-(void)loadView {
    [super loadView];
    
    UITextField *firstName = [[UITextField alloc] initWithFrame:CGRectMake(45, 30, 200, 40)];
    firstName.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    firstName.backgroundColor = [UIColor redColor];
    firstName.text = @"fname";
    
    
    UITextField *lastName = [[UITextField alloc] initWithFrame:CGRectMake(45, firstName.frame.origin.y+75, 200, 40)];
    lastName.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
    lastName.backgroundColor=[UIColor redColor];
    lastName.text=@"lname";
    
    UITextField *email = [[UITextField alloc]initWithFrame:CGRectMake(45, lastName.frame.origin.y+75, 200, 40)];
    email.backgroundColor = [UIColor redColor];
    email.text = @"email";
    
    UIButton *bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bookButton.frame = CGRectMake(80.0, 120.0, 160.0, 40.0);
    
    
    [bookButton addTarget:self action:@selector(bookButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [bookButton setTitle:@"Finish Booking" forState:UIControlStateNormal];
    [self.view addSubview:bookButton];
    bookButton.backgroundColor = [UIColor greenColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 400, 400)];
    //
    //    [AutoLayout leadingConstraintFrom:firstName toView:self.view];
    //    [AutoLayout trailingConstraintFrom:firstName toView:self.view];
    //    [AutoLayout leadingConstraintFrom:lastName toView:self.view];
    //    [AutoLayout trailingConstraintFrom:lastName toView:self.view];
    //    [AutoLayout leadingConstraintFrom:email toView:self.view];
    //    [AutoLayout trailingConstraintFrom:email toView:self.view];
    //
    
    
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:firstName];
    [view addSubview:lastName];
    [view addSubview:email];
    
    [self.view addSubview:view];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
}

-(void)bookButtonPressed {
    NSLog(@"Sup");
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
//    Guest *newGuest = [[Guest alloc]initWithContext:context];
    
    Guest *newGuest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:context];
    
//    newGuest.firstName = self.firstName.text;
//    newGuest.lastName = self.lastName.text;
//    newGuest.email = self.email.text;
    
    [newGuest setFirstName: self.firstName.text];
    [newGuest setLastName: self.lastName.text];
    [newGuest setEmail: self.email.text];
    
    NSError *bookError = nil;
    
    if (![context save:&bookError]) {
        NSLog(@"Can't Save! %@ %@", bookError, [bookError localizedDescription]);
        [bookError userInfo];
    } else {
        NSLog(@"Saved successfully");
        NSLog(@"%@", [newGuest firstName]);
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    if (textField == self.firstName) {
        [self.lastName becomeFirstResponder];
    } else if (textField == self.lastName) {
        [self.email becomeFirstResponder];
    } else if (textField == self.email) {
        [self.firstName becomeFirstResponder];
    }
    
    
    
    //method
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Did end editing: %@", self.firstName);

}


@end
