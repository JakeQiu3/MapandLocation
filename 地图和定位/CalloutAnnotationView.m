//
//  CalloutAnnotationView.m
//  地图和定位
//
//  Created by 邱少依 on 16/1/26.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "CalloutAnnotationView.h"
#import "CalloutAnnotation.h"
#define kSpacing 5
#define kDetailFontSize 12
#define kViewOffset 80

@interface CalloutAnnotationView(){
    UIView *_backgroundView;
    UIImageView *_iconView;
    UILabel *_detailLabel;
    UIImageView *_rateView;
}

@end
@implementation CalloutAnnotationView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        [self layoutUI];//布局UI
    }
    return self;
}

- (void)layoutUI {
//   背景
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundView];
    
//    左侧图标
    _iconView = [[UIImageView alloc] init];
    [self addSubview:_iconView];
    
//   详情
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _detailLabel.font = [UIFont systemFontOfSize:kDetailFontSize];
    [self addSubview:_detailLabel];
    
//    下方星级图标
    _rateView = [[UIImageView alloc] init];
    [self addSubview:_rateView];
    
    
}

+ (instancetype)calloutViewWithMapView:(MKMapView *)mapView {
    static NSString *calloutKey = @"calloutKey";
    CalloutAnnotationView *calloutView = (CalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:calloutKey];
    if (!calloutView) {
        calloutView = [[CalloutAnnotationView alloc] init];
    }
    return calloutView;
}
#pragma mark 当给大头针视图设置大头针模型时可以在此根据模型设置视图内容
- (void)setAnnotation:(CalloutAnnotation *)annotation {
    [super setAnnotation:annotation];
//    根据模型调整布局
    _iconView.image = annotation.icon;
    _iconView.frame = CGRectMake(kSpacing, kSpacing,annotation.icon.size.width, annotation.icon.size.height);
    
    _detailLabel.text = annotation.detail;
    float detailW = 150.0f;
    CGSize detailSize = [annotation.detail boundingRectWithSize:CGSizeMake(detailW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kDetailFontSize]} context:nil].size;
    _detailLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+kSpacing, kSpacing, detailSize.width, detailSize.height);
    
    _rateView.image = annotation.rate;
    _rateView.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+kSpacing, CGRectGetMaxY(_detailLabel.frame), annotation.rate.size.width, annotation.rate.size.height);
    
    _backgroundView.frame = CGRectMake(0, 0,CGRectGetMaxX(_detailLabel.frame)+kSpacing, _iconView.frame.size.height+2*kSpacing);
    
    
    
    
    
}
@end
