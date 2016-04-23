//
//  FloorView.m
//  HotelDemo
//
//  Created by huangyibiao on 16/4/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "FloorView.h"
#import "UIGestureRecognizer+HDFGesture.h"

#define kItemHeight 17
static NSUInteger kNormalWidth = 209;
static NSUInteger kBigWidth = 257;

@interface FloorViewModel : NSObject

@property (nonatomic, assign) NSUInteger floor;
@property (nonatomic, assign) BOOL shouldZoomBig;
@property (nonatomic, assign) BOOL isTop;

@end

@implementation FloorViewModel

@end

@interface FloorView () <UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) FloorViewDidTap didTap;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSources;

@end

@implementation FloorView

- (instancetype)initWithFrame:(CGRect)frame didTap:(FloorViewDidTap)didTap {
  if (self = [super initWithFrame:frame]) {
    self.didTap = didTap;
    
    kBigWidth = frame.size.width;
    kNormalWidth = kBigWidth - 20;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
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
    
    UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc] init];
    [self.collectionView addGestureRecognizer:ges];
    ges.hdf_longGestureBlock = ^(UILongPressGestureRecognizer *sender) {
      CGPoint point = [sender locationInView:self.collectionView];
      NSUInteger index = (point.y - 50) / kItemHeight;
      
      if (index < self.dataSources.count) {
        FloorViewModel *model = [self.dataSources objectAtIndex:index];
        if (!model.isTop && !model.shouldZoomBig) {
          if (self.didTap) {
            self.didTap(model.floor);
          }
          
          [self zoomFloor:model.floor];
        }
      }
    };

  }
  
  return self;
}

- (NSMutableArray *)dataSources {
  if (_dataSources == nil) {
    _dataSources = [[NSMutableArray alloc] init];
    for (NSUInteger i = 19; i >= 4; --i) {
      FloorViewModel *model = [[FloorViewModel alloc] init];
      model.floor = i;
      model.shouldZoomBig = i == 18 ? YES : NO;
      model.isTop = i == 19;
      [_dataSources addObject:model];
    }
  }
  
  return _dataSources;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
  FloorViewModel *model = self.dataSources[indexPath.item];
  
  UIImageView *imageView = [cell.contentView viewWithTag:100];
  UIImageView *bigImageView = [cell.contentView viewWithTag:101];
  if (imageView == nil) {
    imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    [cell.contentView addSubview:imageView];
    imageView.frame = CGRectMake((kBigWidth - kNormalWidth) / 2, 0, kNormalWidth, kItemHeight);
    imageView.tag = 100;
    
    bigImageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    [cell.contentView addSubview:bigImageView];
    bigImageView.tag = 101;
    bigImageView.image = [UIImage imageNamed:@"floor_big_zoom"];
    bigImageView.hidden = YES;
    bigImageView.frame = CGRectMake(0, 0, kBigWidth, kItemHeight);
  }
  
  if (model.isTop) {
    imageView.frame = CGRectMake((cell.contentView.frame.size.width - kNormalWidth) / 2, 0, kNormalWidth, 50);
    imageView.image = [UIImage imageNamed:@"floor_top"];
    bigImageView.hidden = YES;
    imageView.hidden = NO;
  } else if (model.shouldZoomBig) {
    imageView.hidden = YES;
    bigImageView.hidden = NO;
    bigImageView.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, kItemHeight);
  } else {
    imageView.frame = CGRectMake((cell.contentView.frame.size.width - kNormalWidth) / 2,
                                 0,
                                 kNormalWidth,
                                 kItemHeight);
    bigImageView.hidden = YES;
    imageView.hidden = NO;
    imageView.image = [UIImage imageNamed:@"floor_mid"];
  }
  
  return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.dataSources.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item == 0) {
    return CGSizeMake(kNormalWidth, 50);
  } else {
      return CGSizeMake(kBigWidth, kItemHeight);
  }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  FloorViewModel *model = self.dataSources[indexPath.item];
  if (model.isTop) {
    return;
  }
  
  if (!model.shouldZoomBig) {
    [self zoomFloor:model.floor];
    
    if (self.didTap) {
      self.didTap(model.floor);
    }
  }
}

- (void)zoomFloor:(NSUInteger)floor {
  [self.dataSources enumerateObjectsUsingBlock:^(FloorViewModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (obj.floor == floor) {
      obj.shouldZoomBig = YES;
    } else {
      obj.shouldZoomBig = NO;
    }
  }];
  
  [self.collectionView reloadData];
}

@end
