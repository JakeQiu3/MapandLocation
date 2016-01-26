//
//  Annotation.h
//  地图和定位
//
//  Created by 邱少依 on 16/1/26.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
#pragma mark 自定义一个图片属性，创建大头针视图
@property (nonatomic, strong) UIImage *image;
#pragma mark 大头针详情左侧图标
@property (nonatomic,strong) UIImage *icon;
#pragma mark 大头针详情描述
@property (nonatomic,copy) NSString *detail;
#pragma mark 大头针右下方星级评价
@property (nonatomic,strong) UIImage *rate;

@end
