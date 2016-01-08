//
//  ViewController.m
//  MMPieChart
//
//  Created by MichaelMaoMao on 16/1/6.
//  Copyright © 2016年 MichaelMaoMao. All rights reserved.
//

#import "ViewController.h"
#import "MMPieChartView.h"

#define PIE_HEIGHT 280

@interface ViewController () <MMPieChartDelegate>

@property (nonatomic,strong) MMPieChartView *pieChartView;
@property (nonatomic,strong) UIView *pieContainer;
@property (nonatomic,strong) UILabel *selLabel;
@property (nonatomic, strong) UIImageView   *selView;

@property (nonatomic, strong) NSMutableArray *nameMarr;
@property (nonatomic, strong) NSMutableArray *numberMarr;

@end

@implementation ViewController
@synthesize selView;

#pragma mark - view life cycle

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.nameMarr   = [NSMutableArray array];
        self.numberMarr = [NSMutableArray array];
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    self.pieContainer.hidden = NO;
    self.selView.hidden      = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.pieChartView reloadChart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //example
    NSArray *name = @[@"samsung", @"iPhone", @"huawei", @"Lenovo", @"xiaomi"];
    NSArray *number = @[@8300, @7800, @5900, @4690, @3900];

    [self createPieWithName:name AndNumber:number];
    
}

- (void)dealloc{
    
    self.pieContainer = nil;
    self.selLabel = nil;
}

#pragma mark - action

-(void)createPieWithName: (NSArray *)names AndNumber:(NSArray *)numbers{
    
    [self.nameMarr setArray:names];
    [self.numberMarr setArray:numbers];

    //total_num cannot be zero as divisor.
    NSInteger total_num = 1;
    
    // colors
    NSMutableArray * colorMarr = [NSMutableArray array];

    for (int i = 0; i < [numbers count]; i++) {
        
        NSInteger num_int = [[numbers objectAtIndex:i] integerValue];
        total_num = total_num + num_int;
        
        //random color
        UIColor * color = [self returnRandomColor];
        [colorMarr addObject:color];
    }
    
    //number percent
    NSMutableArray *percent_mArr = [NSMutableArray array];
    for (int j = 0; j < [numbers count]; j++) {

        NSInteger num_int = [[numbers objectAtIndex:j] integerValue];
        
        CGFloat per_float =  100*num_int / total_num;
        NSString *per_str = [NSString stringWithFormat:@"%.1f%%", per_float];
        [percent_mArr addObject:per_str];
    }
    
    CGRect pieFrame = CGRectMake((self.view.frame.size.width - PIE_HEIGHT) / 2, 50-10, PIE_HEIGHT, PIE_HEIGHT);
    
    if (self.pieChartView == nil) {
        self.pieContainer = [[UIView alloc]initWithFrame:pieFrame];
    }
    
    self.pieContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pieContainer];
    
    if (self.pieChartView == nil) {

        self.pieChartView = [[MMPieChartView alloc] initWithFrame:self.pieContainer.bounds withValue:percent_mArr withColor:colorMarr];
    }
    
    self.pieChartView.pieDelegate = self;
    [self.pieChartView setAmountText:@"Phone"];
    [self.pieContainer addSubview:self.pieChartView];
    
    //add selected view
    if (selView == nil) {
        selView = [[UIImageView alloc]init];
        [self.view addSubview:selView];
    }
    selView.image = [UIImage imageNamed:@"pie_select"];
    selView.backgroundColor = [UIColor clearColor];
    selView.frame = CGRectMake((self.view.frame.size.width - selView.image.size.width/2)/2, 15 + self.pieContainer.frame.origin.y + self.pieContainer.frame.size.height, selView.image.size.width/2, selView.image.size.height/2);
    
    
    //选择的车辆信息
    if (self.selLabel == nil) {
        
        self.selLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24 + 3, selView.image.size.width/2, 21)];
        [selView addSubview:self.selLabel];
    }
    self.selLabel.backgroundColor = [UIColor clearColor];
    self.selLabel.textAlignment = NSTextAlignmentCenter;
    self.selLabel.font = [UIFont systemFontOfSize:17];
    self.selLabel.textColor = [UIColor whiteColor];
    
    [self.pieChartView setTitleText:@"2015"];

}

//random color
-(UIColor *)returnRandomColor{
    
    CGFloat hue = ( arc4random() % 210 / 256.0  ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.2; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark - implementate pie delegate
/**
 *  set selLabel text
 */
- (void)selectedFinish:(MMPieChartView *)pieChartView index:(NSInteger)index percent:(float)per{
    
    NSString *name  = [self.nameMarr objectAtIndex:index];
    NSString *num   = [self.numberMarr objectAtIndex:index];
    
    self.selLabel.text = [NSString stringWithFormat:@"%@  %@ billion  %2.2f%@", name, num, per*100, @"%"];
    
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
