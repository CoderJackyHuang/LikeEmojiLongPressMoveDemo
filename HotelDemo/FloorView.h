//
//  FloorView.h
//  HotelDemo
//
//  Created by huangyibiao on 16/4/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FloorViewDidTap)(NSUInteger floor);

// 楼层具体
@interface FloorView : UIView

- (instancetype)initWithFrame:(CGRect)frame didTap:(FloorViewDidTap)didTap;

// 放大
- (void)zoomFloor:(NSUInteger)floor;

@end
