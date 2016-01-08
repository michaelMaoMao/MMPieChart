//
//  MMPieView.h
//  MMPieChart
//
//  Created by MichaelMaoMao on 16/1/6.
//  Copyright © 2016年 MichaelMaoMao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMRotatedView.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@class MMPieChartView;

@protocol MMPieChartDelegate <NSObject>

@optional

- (void)selectedFinish:(MMPieChartView *)pieChartView index:(NSInteger)index percent:(float)per;
- (void)onCenterClick:(MMPieChartView *)PieChartView;

@end

@interface MMPieChartView : UIView <MMRotatedViewDelegate>

@property(nonatomic, assign) id<MMPieChartDelegate> pieDelegate;

- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)valueArr withColor:(NSMutableArray *)colorArr;
- (void)reloadChart;
- (void)setAmountText:(NSString *)text;
- (void)setTitleText:(NSString *)text;

@end
