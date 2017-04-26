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
    
}

- (void)tearDown {
    [super tearDown];
    
    [super tearDown];
    
}

-(void)testViewControllerNotNil {
    XCTAssertNotNil(self.testController, @"The testController is nil!");
}


@end
