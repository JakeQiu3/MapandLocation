//
//  MapKitViewController.m
//  地图和定位
//
//  Created by 邱少依 on 16/1/26.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "MapKitViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "CalloutAnnotation.h"
#import "CalloutAnnotationView.h"
@interface MapKitViewController ()<MKMapViewDelegate> {
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}

@end

@implementation MapKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGUI];
    
}
#pragma mark 添加地图控件
- (void)initGUI {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    //添加大头针
    [self addAnnotation];
    
    //请求定位服务
    _locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark 添加2个大头针
- (void)addAnnotation {
//
//   经纬度位置
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(39.95, 116.35);
    
    Annotation *annotation1 = [[Annotation alloc]init];
    annotation1.title = @"WuNa Studio";
    annotation1.subtitle = @"WuNa Studio Happy";
    annotation1.coordinate = location1;
    annotation1.image = [UIImage imageNamed:@"icon_pin_floating"];
    annotation1.icon = [UIImage imageNamed:@"icon_mark1"];
    annotation1.detail = @"要房子不重要，重要的是心安";
    annotation1.rate = [UIImage imageNamed:@"icon_Movie_Star_rating"];
    [_mapView addAnnotation:annotation1];
//   经纬度位置
    CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(39.87, 116.35);
    Annotation *annotation2=[[Annotation alloc]init];
    annotation2.title=@"Qiushao";
    annotation2.subtitle=@"Qiushao House";
    annotation2.coordinate=location2;
    annotation2.image=[UIImage imageNamed:@"icon_paopao_waterdrop_streetscape.png"];
    annotation2.icon=[UIImage imageNamed:@"icon_mark2.png"];
    annotation2.detail=@"买不起房子不要紧，要紧是买不起还硬买";
    annotation2.rate=[UIImage imageNamed:@"icon_Movie_Star_rating.png"];
    [_mapView addAnnotation:annotation2];
}

#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象


//我这次就是要看看
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//     //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
//    if ([annotation isKindOfClass:[Annotation class]]) {
//    }
//    
//}
















@end
