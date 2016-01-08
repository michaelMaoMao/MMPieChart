//
//  MMPieView.m
//  MMPieChart
//
//  Created by MichaelMaoMao on 16/1/6.
//  Copyright © 2016年 MichaelMaoMao. All rights reserved.
//

#import "MMPieChartView.h"

@interface MMPieChartView()
@property (nonatomic,strong)MMRotatedView *rotatedView;
@property (nonatomic,strong) UIButton *centerView;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *title;
@end

@implementation MMPieChartView

- (void)dealloc
{
    self.rotatedView.delegate = nil;
    self.rotatedView = nil;
    self.centerView = nil;
    self.amountLabel = nil;
}

- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)valueArr withColor:(NSMutableArray *)colorArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if ([valueArr count] > 0 && [colorArr count] > 0) {
            [self sortValueArr:valueArr colorArr:colorArr];
            self.rotatedView = [[MMRotatedView alloc]initWithFrame:self.bounds];
            self.rotatedView.mValueArray = valueArr;
            self.rotatedView.mColorArray = colorArr;
            self.rotatedView.delegate = self;
            [self addSubview:self.rotatedView];
            
        }
        
        //中心view
        self.centerView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.centerView removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addTarget:self action:@selector(changeInOut:) forControlEvents:UIControlEventTouchUpInside];
        int titleWidth = 65;
        //那张图片宽度为254
        self.centerView.frame = CGRectMake((frame.size.width- 254/2)/2, (frame.size.height - 254/2)/2, 254/2, 254/2);
        self.title = [[UILabel alloc]initWithFrame:CGRectMake((254/2 - titleWidth)/2, 35 + 45, 254/2 - titleWidth, 17)];
        //变成白色圆形
        self.centerView.backgroundColor = [UIColor whiteColor];
        self.centerView.layer.cornerRadius  = CGRectGetHeight(self.centerView.bounds)/2;
        self.centerView.layer.borderColor = RGBCOLOR(231, 231, 231).CGColor;
        self.centerView.layer.borderWidth = 4.0;
        
        //上部大标题
        int amountWidth = 75;
        self.amountLabel = [[UILabel alloc]initWithFrame:CGRectMake((254/2 - amountWidth)/2, 50, amountWidth, 22)];
        
        self.amountLabel.backgroundColor = [UIColor clearColor];
        self.amountLabel.textAlignment = NSTextAlignmentCenter;
        self.amountLabel.font = [UIFont boldSystemFontOfSize:21];
        self.amountLabel.textColor = [UIColor darkGrayColor];
        [self.amountLabel setAdjustsFontSizeToFitWidth:YES];
        [self.centerView addSubview:self.amountLabel];
        
        //下部小标题
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:14.0];
        self.title.textColor = [self colorFromHexRGB:@"cecece"];
        self.title.text = @"";
        [self.centerView addSubview:self.title];
        
        [self addSubview:self.centerView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)sortValueArr:(NSMutableArray *)valueArr colorArr:(NSMutableArray *)colorArr
{
    float sum = 0.0;
    int maxIndex = 0;
    int maxValue = 0;
    for (int i = 0; i < [valueArr count]; i++) {
        float curValue = [[valueArr objectAtIndex:i] floatValue];
        if (curValue > maxValue) {
            maxValue = curValue;
            maxIndex = i;
        }
        sum += curValue;
    }
    float frac = 2.0 * M_PI / sum;
    int changeIndex = 0;
    sum = 0.0;
    for (int i = 0; i < [valueArr count]; i++) {
        float curValue = [[valueArr objectAtIndex:i] floatValue];
        sum += curValue;
        if(sum*frac > M_PI/2){
            changeIndex = i;
            break;
        }
    }
    if (maxIndex != changeIndex) {
        [valueArr exchangeObjectAtIndex:maxIndex withObjectAtIndex:changeIndex];
        [colorArr exchangeObjectAtIndex:maxIndex withObjectAtIndex:changeIndex];
    }
}

- (void)changeInOut:(id)sender
{
    if ([self.pieDelegate respondsToSelector:@selector(onCenterClick:)]) {
        [self.pieDelegate onCenterClick:self];
    }
}

- (void)setTitleText:(NSString *)text
{
    [self.title setText:text];
}
- (void)setAmountText:(NSString *)text
{
    [self.amountLabel setText:text];
}

- (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}


#pragma mark - delegate

- (void)reloadChart
{
    [self.rotatedView reloadPie];
}

- (void)selectedFinish:(MMRotatedView *)rotatedView index:(NSInteger)index percent:(float)per
{
    [self.pieDelegate selectedFinish:self index:index percent:per];
}


@end
