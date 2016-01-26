//
//  CalloutAnnotationView.h
//  地图和定位
//
//  Created by 邱少依 on 16/1/26.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@class CalloutAnnotation;
@interface CalloutAnnotationView : MKAnnotationView
@property (nonatomic, strong) CalloutAnnotation *annotation;
#pragma mark 从缓存取出标示视图
+ (instancetype)calloutViewWithMapView:(MKMapView *)mapView;
@end
