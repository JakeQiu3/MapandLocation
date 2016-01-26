//
//  CalloutAnnotation.h
//  地图和定位
//
//  Created by 邱少依 on 16/1/26.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CalloutAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy,readonly) NSString *title;
@property (nonatomic, copy,readonly) NSString *subtitle;

#pragma mark 左侧图标
@property (nonatomic,strong) UIImage *icon;
#pragma mark 详情描述
@property (nonatomic,copy) NSString *detail;
#pragma mark 星级评价图标
@property (nonatomic,strong) UIImage *rate;

@end
