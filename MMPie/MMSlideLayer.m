//
//  MMSlideLayer.m
//  MMPieChart
//
//  Created by MichaelMaoMao on 16/1/6.
//  Copyright © 2016年 MichaelMaoMao. All rights reserved.
//

#import "MMSlideLayer.h"

@implementation MMSlideLayer

@synthesize value = _value;
@synthesize percentage = _percentage;
@synthesize startAngle = _startAngle;
@synthesize endAngle = _endAngle;
@synthesize isSelected = _isSelected;
- (NSString*)description
{
    return @"";
}
+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"]) {
        return YES;
    }
    else {
        return [super needsDisplayForKey:key];
    }
}
- (id)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer])
    {
        if ([layer isKindOfClass:[MMSlideLayer class]]) {
            self.startAngle = [(MMSlideLayer *)layer startAngle];
            self.endAngle = [(MMSlideLayer *)layer endAngle];
        }
    }
    return self;
}
- (void)createArcAnimationForKey:(NSString *)key fromValue:(NSNumber *)from toValue:(NSNumber *)to Delegate:(id)delegate
{
    CABasicAnimation *arcAnimation = [CABasicAnimation animationWithKeyPath:key];
    NSNumber *currentAngle = [[self presentationLayer] valueForKey:key];
    if(!currentAngle) currentAngle = from;
    [arcAnimation setFromValue:currentAngle];
    [arcAnimation setToValue:to];
    [arcAnimation setDelegate:delegate];
    [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self addAnimation:arcAnimation forKey:key];
    [self setValue:to forKey:key];
}

@end
