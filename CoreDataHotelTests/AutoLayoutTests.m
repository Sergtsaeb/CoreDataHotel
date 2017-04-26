//
//  AutoLayoutTests.m
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/26/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AutoLayout.h"

@interface AutoLayoutTests : XCTestCase

@property(strong, nonatomic) UIViewController *testController;

@property(strong, nonatomic) UIView *testView1;
@property(strong, nonatomic) UIView *testView2;

@end

@implementation AutoLayoutTests

- (void)setUp {
    [super setUp];
    
    self.testController = [[UIViewController alloc] init];
    self.testView1 = [[UIView alloc]init];
     self.testView2 = [[UIView alloc]init];
    
    [self.testController.view addSubview:self.testView1];
    [self.testController.view addSubview:self.testView2];
    
}

- (void)tearDown {
    
    //tearing down properties
    self.testController = nil;
    self.testView1 = nil;
    self.testView2 = nil;
    
    [super tearDown];
    
}



-(void)testgenericConstraintFromtoViewwithAttribute {
    
    
    
    XCTAssertNotNil(self.testController, @"The testController is nil!");
    XCTAssertNotNil(self.testView1, @"self.testView1 is nil!");
    XCTAssertNotNil(self.testView1, @"self.testView2 is nil!");
    
    id constraint = [AutoLayout genericConstraintFrom:self.testView1 toView:self.testView2 withAttribute:NSLayoutAttributeTop];
    
    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"Constraint is not an instance of NSLayoutConstraint");
}


@end
