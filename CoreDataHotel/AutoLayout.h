//
//  AutoLayout.h
//  CoreDataHotel
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/24/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

@import UIKit;

@interface AutoLayout : NSObject

+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *) superVIew
                               withAttribute:(NSLayoutAttribute)attribute
                               andMultiplier:(CGFloat)multiplier;


//helper, calls teh first methods and provides a multiplier of one
+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *) superVIew
                               withAttribute:(NSLayoutAttribute)attribute;

+(NSArray *)fullScreenConstraintsWithVFLForView:(UIView *)view;

+(NSLayoutConstraint *)equalHeightConstraintFromView:(UIView *)view
                                              toView:(UIView *)otherView
                                      withMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)leadingConstraintFrom:(UIView *)view
                                      toView:(UIView *)otherView;

+(NSLayoutConstraint *)trailingConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView;


+(NSLayoutConstraint *)topConstraintFrom:(UIView *)view
                                      toView:(UIView *)otherView;

+(NSLayoutConstraint *)bottomConstraintFrom:(UIView *)view
                                       toView:(UIView *)otherView;

+(NSArray *)constraintsWithVFLForViewDictionary:(NSDictionary *)viewDictionary forMetricsDictionary:(NSDictionary *)metricsDictionary withOptions:(NSLayoutFormatOptions)options withVisualFormat:(NSString *)visualFormat;


@end
