//
//  ViewController.m
//  CoreLocationDemo
//
//  Created by aitaomama-ios on 15/8/20.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *locManager;
}
@property (strong, nonatomic) IBOutlet UILabel *lonLabel;
@property (strong, nonatomic) IBOutlet UILabel *latLable;
@property (strong, nonatomic) CLLocationManager *locManager;

@end

@implementation ViewController
@synthesize lonLabel;
@synthesize latLable;
@synthesize locManager;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    locManager = [[CLLocationManager alloc]init];
    //设置代理
    locManager.delegate = self;
    //设置位置经度
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locManager requestAlwaysAuthorization];//添加这句
    //设置每隔100米更新位置
    locManager.distanceFilter = 100;
    //开始定位服务
    [locManager startUpdatingLocation];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



//协议中的方法，作用是每当位置发生更新时会调用的委托方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * loc = [locations firstObject];
    float longitude = loc.coordinate.longitude;
    float latitude = loc.coordinate.latitude;
    self.lonLabel.text = [NSString stringWithFormat:@"%f",longitude];
    self.latLable.text = [NSString stringWithFormat:@"%f",latitude];
}



//当位置获取或更新失败会调用的方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorMsg = nil;
    if ([error code] == kCLErrorDenied) {
        errorMsg = @"访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        errorMsg = @"获取位置信息失败";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Location"
                                                      message:errorMsg delegate:self cancelButtonTitle:@"Ok"otherButtonTitles:nil, nil];
    [alertView show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
