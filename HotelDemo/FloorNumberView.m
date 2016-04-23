//
//  FloorNumberView.m
//  HotelDemo
//
//  Created by huangyibiao on 16/4/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "FloorNumberView.h"


@interface FloorNumberViewModel : NSObject

@property (nonatomic, assign) NSUInteger floor;
@property (nonatomic, assign) BOOL zoomBig;

@end

@implementation FloorNumberViewModel

@end

@interface FloorNumberView () <UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, copy) FloorNumberViewDidTap didTap;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation FloorNumberView

- (instancetype)initWithFrame:(CGRect)frame didTap:(FloorNumberViewDidTap)didTap {
  if (self = [super initWithFrame:frame]) {
    self.didTap = didTap;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(frame.size.width,
                                 frame.size.height / self.dataSources.count);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                             collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
  }
  
  return self;
}

- (NSMutableArray *)dataSources {
  if (_dataSources == nil) {
    _dataSources = [[NSMutableArray alloc] init];
    for (NSUInteger i = 18; i >= 4; --i) {
      FloorNumberViewModel *model = [[FloorNumberViewModel alloc] init];
      model.floor = i;
      model.zoomBig = i == 18;
      [_dataSources addObject:model];
    }
  }
  
  return _dataSources;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
  UIImageView *imageView = [cell.contentView viewWithTag:100];
  if (imageView == nil) {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height + 0.5)];
    [cell.contentView addSubview:imageView];
    imageView.tag = 100;
  }
  
  UILabel *label = [cell.contentView viewWithTag:101];
  if (label == nil) {
    label = [[UILabel alloc] initWithFrame:CGRectMake(-10, -10, cell.contentView.bounds.size.width + 20, cell.contentView.bounds.size.height + 20)];
    [cell.contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.tag = 101;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
  }
  
  FloorNumberViewModel *model = self.dataSources[indexPath.item];
  if (model.floor == 18) {
    label.text = @"";
    imageView.image = [UIImage imageNamed:@"floor_num_top"];
  } else if (model.floor == 4) {
    label.text = @"";
      imageView.image = [UIImage imageNamed:@"floor_num_bottom"];
  } else {
    imageView.image = [UIImage imageNamed:@"floor_num_mid"];
  }
  
  label.text = [NSString stringWithFormat:@"%@", @(model.floor)];
  if (model.zoomBig) {
    label.font = [UIFont boldSystemFontOfSize:19];
  } else {
    label.font = [UIFont systemFontOfSize:10];
  }
  
  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.dataSources.count;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  FloorNumberViewModel *model = self.dataSources[indexPath.item];
  if (!model.zoomBig) {
    [self zoomFloor:model.floor];
    
    if (self.didTap) {
      self.didTap(model.floor);
    }
  }
}

- (void)zoomFloor:(NSUInteger)floor {
  [self.dataSources enumerateObjectsUsingBlock:^(FloorNumberViewModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (obj.floor == floor) {
      obj.zoomBig = YES;
    } else {
      obj.zoomBig = NO;
    }
  }];
  
  [self.collectionView reloadData];
}

@end
