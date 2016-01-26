//
//  CalloutAnnotationView.m
//  地图和定位
//
//  Created by 邱少依 on 16/1/26.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "CalloutAnnotationView.h"

@implementation CalloutAnnotationView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self layout];
    }
    return self;
}
    
- (void)layout {
    
}

+ (instancetype)calloutViewWithMapView:(MKMapView *)mapView {
    return self;
}

@end
