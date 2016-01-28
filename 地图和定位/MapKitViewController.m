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
@interface MapKitViewController ()<MKMapViewDelegate,CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}

@end
#warning 少 注意必须添加下面这个字段到info.plist文件中
// NSLocationWhenInUseUsageDescription
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
    _mapView.showsUserLocation = YES;
    _mapView.zoomEnabled = YES;
    
    //请求定位服务
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
     //定位 最小距离
    _locationManager.distanceFilter = 1.0f;
    //定位 精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse) {
        
       [_locationManager requestWhenInUseAuthorization];
     
    }
    //    开始定位
    [_locationManager startUpdatingLocation];

    //添加大头针
    [self addAnnotation];
}

#pragma mark 添加2个大头针
- (void)addAnnotation {
//
//   经纬度位置
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(39.95, 116.35);
    
    Annotation *annotation1 = [[Annotation alloc]init];
    annotation1.title = @"WuNa Studio";
    annotation1.subtitle = @"WuNa Studio Happy";
    annotation1.coordinate = location1;//大头针位置
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
    annotation2.coordinate=location2;//大头针位置
    annotation2.image=[UIImage imageNamed:@"icon_paopao_waterdrop_streetscape.png"];
    annotation2.icon=[UIImage imageNamed:@"icon_mark2.png"];
    annotation2.detail=@"买不起房子不要紧，要紧是买不起还硬买";
    annotation2.rate=[UIImage imageNamed:@"icon_Movie_Star_rating.png"];
    [_mapView addAnnotation:annotation2];
}

#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
     //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[Annotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.calloutOffset = CGPointMake(0, 1);
            annotationView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//定义详情左侧视图
    }
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((Annotation *)annotation).image;//设置大头针视图的图片
        return annotationView;
    
    } else if ([annotation isKindOfClass:[CalloutAnnotation class]]){
  //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
        CalloutAnnotationView *calloutView=[CalloutAnnotationView calloutViewWithMapView:mapView];
        calloutView.annotation = annotation;
        return calloutView;
   } else {
        return nil;
    }
}

#pragma mark 选中大头针时触发
//点击一般的大头针Annotation时添加一个大头针作为所点大头针的弹出详情视图

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
//    获取视图的annotation
    Annotation *annotation = view.annotation;
    if ([view.annotation isKindOfClass:[Annotation class]]) {
        //点击一个大头针时移除其他弹出详情视图
        [self removeCustomAnnotation];
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
        CalloutAnnotation *callOUtAnnomation = [[CalloutAnnotation alloc] init];
        callOUtAnnomation.icon = annotation.icon;
        callOUtAnnomation.detail = annotation.detail;
        callOUtAnnomation.rate = annotation.rate;
        callOUtAnnomation.coordinate = annotation.coordinate;
        [_mapView addAnnotation:callOUtAnnomation];
    }
}
#pragma mark 取消选中时触发
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    [self removeCustomAnnotation];
}
#pragma mark 移除所用自定义大头针
- (void)removeCustomAnnotation {
    [_mapView.annotations enumerateObjectsUsingBlock:^(id<MKAnnotation>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CalloutAnnotation class]]) {
            [_mapView removeAnnotation:obj];
        }
    }];
}
#pragma mark location的协议方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"%@",locations);
}


@end
