//
//  MMSlideLayer.h
//  MMPieChart
//
//  Created by MichaelMaoMao on 16/1/6.
//  Copyright © 2016年 MichaelMaoMao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface MMSlideLayer : CAShapeLayer

@property (nonatomic, assign) CGFloat   value;
@property (nonatomic, assign) CGFloat   percentage;
@property (nonatomic, assign) double    startAngle;
@property (nonatomic, assign) double    endAngle;
@property (nonatomic, assign) BOOL      isSelected;

@property (nonatomic, assign) BOOL      isTouchMoved;
@property (nonatomic, assign) BOOL      isTapped;

@property (nonatomic, assign) CGAffineTransform  layerTransform;

- (void)createArcAnimationForKey:(NSString *)key fromValue:(NSNumber *)from toValue:(NSNumber *)to Delegate:(id)delegate;

@end
