//
//  AppleMapViewController.m
//  地图和定位
//
//  Created by 邱少依 on 16/1/28.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "AppleMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface AppleMapViewController ()
{
    CLGeocoder *_geocoder; //地理编码类
}
@end

@implementation AppleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _geocoder = [[CLGeocoder alloc] init];
//    设置位置点列表
    [self listPlacemark];
    
}

- (void)listPlacemark {
    [_geocoder geocodeAddressString:@"北京市" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //获取第一个地标
        CLPlacemark *placeMark1 = [placemarks firstObject];
        //注意地理编码一次只能定位到一个位置，不能同时定位，所在放到第一个位置定位完成回调函数中再次定位
        MKPlacemark *mkPlacemark1 = [[MKPlacemark alloc] initWithPlacemark:placeMark1];
        [_geocoder geocodeAddressString:@"郑州市"completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获取第一个地标
            CLPlacemark *placeMark2 = [placemarks firstObject];
            MKPlacemark *mkPlacemark2 = [[MKPlacemark alloc] initWithPlacemark:placeMark2];
            
            NSDictionary *optionsDic = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
           
            MKMapItem *mapItem1 = [[MKMapItem alloc] initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2 = [[MKMapItem alloc] initWithPlacemark:mkPlacemark2];
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:optionsDic];
            
        }];
        
    }];
}

@end
