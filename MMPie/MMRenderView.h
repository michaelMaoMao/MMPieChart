//
//  MMRenderView.h
//  MMPieChart
//
//  Created by MichaelMaoMao on 16/1/6.
//  Copyright © 2016年 MichaelMaoMao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMRenderView;
@protocol MMRenderViewDataSource <NSObject>
@required
- (NSUInteger)numberOfSlicesInPieChart:(MMRenderView *)pieChart;
- (CGFloat)pieChart:(MMRenderView *)pieChart valueForSliceAtIndex:(NSUInteger)index;
@optional
- (UIColor *)pieChart:(MMRenderView *)pieChart colorForSliceAtIndex:(NSUInteger)index;
@end

@protocol MMRenderViewtDelegate <NSObject>
@optional
- (void)pieChart:(MMRenderView *)pieChart willSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(MMRenderView *)pieChart didSelectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(MMRenderView *)pieChart willDeselectSliceAtIndex:(NSUInteger)index;
- (void)pieChart:(MMRenderView *)pieChart didDeselectSliceAtIndex:(NSUInteger)index;
- (void)animateFinish:(MMRenderView *)pieChart;
@end

@interface MMRenderView : UIView

@property (nonatomic, strong) UIView  *pieView;
@property(nonatomic, weak) id<MMRenderViewDataSource> dataSource;
@property(nonatomic, weak) id<MMRenderViewtDelegate> delegate;
@property(nonatomic, assign) CGFloat startPieAngle;
@property(nonatomic, assign) CGFloat animationSpeed;
@property(nonatomic, assign) CGPoint pieCenter;
@property(nonatomic, assign) CGFloat pieRadius;
@property(nonatomic, assign) BOOL    showLabel;
@property(nonatomic, strong) UIFont  *labelFont;
@property(nonatomic, assign) CGFloat labelRadius;
@property(nonatomic, assign) CGFloat selectedSliceStroke;
@property(nonatomic, assign) CGFloat selectedSliceOffsetRadius;
@property(nonatomic, assign) BOOL    showPercentage;




- (id)initWithFrame:(CGRect)frame Center:(CGPoint)center Radius:(CGFloat)radius;
- (void)reloadData;
- (void)setPieBackgroundColor:(UIColor *)color;
- (void)pieSelected:(NSInteger)selIndex;

@end
