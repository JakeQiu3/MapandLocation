//
//  CoreLocationViewController.m
//  地图和定位
//
//  Created by 邱少依 on 16/1/28.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "CoreLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface CoreLocationViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    MKMapView *_mapView;
    CLGeocoder *_geocoder;//地理位置类
    CLLocationManager *_locationManager;// 定位类
}

@end

@implementation CoreLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//  初始化地图
//    [self addMap];
//  添加定位管理器
    [self addLocation];
// 初始化地理位置和定位
     _geocoder = [[CLGeocoder alloc] init];
    [self getCoordinateByAddress:@"北京"];//地名
    [self getAddressByLatitude:39.54 longitude:116.28];// 经度和纬度
//    
    
}
//初始化地图
- (void)addMap {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
}

- (void)addLocation {
    //    初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位未打开，请打开定位服务");
    }
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse) {
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 10.0;//十米定位一次
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
        
    }

}
#pragma mark 根据地名确定地理坐标
- (void)getCoordinateByAddress:(NSString *)address {
     //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
         //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placeMark = [placemarks firstObject];
        CLLocation *clLocation = placeMark.location;//位置
        CLRegion *clRegion = placeMark.region;//区域
        NSDictionary *clDic = placeMark.addressDictionary;//详细地址信息字典,包含以下部分信息
        NSLog(@"位置:%@,区域:%@,详细信息:%@",clLocation,clRegion,clDic);
    }];
}

#pragma mark 根据经度纬度来确定地理坐标
- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
     //反地理编码
    CLLocation *clLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:clLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        CLRegion *clRegion = placeMark.region;
        CLLocation *clLocation = placeMark.location;
        NSDictionary *dic = placeMark.addressDictionary;
        NSLog(@"位置%@,地区%@,详细信息%@",clLocation,clRegion,dic);
    }];
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //取出第一个位置
    CLLocation *location = [locations firstObject];
    //位置坐标
    CLLocationCoordinate2D  coordinate= location.coordinate;
    //如果不需要实时定位，使用完即使关闭定位服务
     [_locationManager stopUpdatingHeading];
}

@end
