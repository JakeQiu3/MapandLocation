//
//  LocationViewController.m
//  地图和定位
//
//  Created by 邱少依 on 16/9/29.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController ()<CLLocationManagerDelegate>
{
    CLGeocoder *geocoder;
}
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocation];
    // Do any additional setup after loading the view.
}
- (void)startLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    geocoder = [[CLGeocoder alloc] init];
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"requestWhenInUseAuthorization");
        //        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    NSLog(@"start gps");
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    NSLog(@"查看location： %@",location);
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
//    self.longitute = [NSNumber numberWithDouble:coordinate.longitude];
//    self.latitude = [NSNumber numberWithDouble:coordinate.latitude];
#pragma mark 根据经度纬度来确定地理坐标
     CLLocation *clLocation = [[CLLocation alloc] initWithLatitude:37.785334 longitude:116.284535];
    [geocoder reverseGeocodeLocation:clLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        CLRegion *clRegion = placeMark.region;
        CLLocation *clLocation = placeMark.location;
        NSDictionary *dic = placeMark.addressDictionary;
        NSLog(@"位置%@,地区%@,详细信息%@",clLocation,clRegion,dic);
    }];
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
