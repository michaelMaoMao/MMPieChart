//
//  MMRotatedView.h
//  MMPieChart
//
//  Created by MichaelMaoMao on 16/1/6.
//  Copyright © 2016年 MichaelMaoMao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMRenderView.h"

@class MMRotatedView;
@protocol MMRotatedViewDelegate <NSObject>
@optional
- (void)selectedFinish:(MMRotatedView *)rotatedView index:(NSInteger)index percent:(float)per;
@end

@interface MMRotatedView : UIView<MMRotatedViewDelegate,MMRotatedViewDelegate> {
    float               mZeroAngle;
    NSMutableArray     *mValueArray;
    NSMutableArray     *mColorArray;
    NSMutableArray     *mThetaArray;
    
    BOOL                isAnimating;
    BOOL                isTapStopped;
    BOOL                isAutoRotation;
    float               mAbsoluteTheta;
    float               mRelativeTheta;
    UITextView         *mInfoTextView;
    
    float               mDragSpeed;
    NSDate             *mDragBeforeDate;
    float               mDragBeforeTheta;
    NSTimer            *mDecelerateTimer;
}
@property(nonatomic, assign) id<MMRotatedViewDelegate> delegate;
@property (nonatomic)float fracValue;
@property (nonatomic)         float           mZeroAngle;
@property (nonatomic)         BOOL            isAutoRotation;
@property (nonatomic, retain) NSMutableArray *mValueArray;
@property (nonatomic, retain) NSMutableArray *mColorArray;
@property (nonatomic, retain) UITextView     *mInfoTextView;

- (void)startedAnimate;
- (void)reloadPie;

@end
