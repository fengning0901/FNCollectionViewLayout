//
//  DemoOneViewController.m
//  FNCollectionViewLayoutDemo
//
//  Created by 冯宁 on 2017/8/10.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "DemoOneViewController.h"
#import "FNCollectionViewLayout.h"
#import "DemoConCollectionViewCell.h"
#import "DemoModel.h"

@interface DemoOneViewController () <FNCollectionViewLayoutDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView* collection;
@property (nonatomic, strong) FNCollectionViewLayout* layout;
@property (nonatomic, strong) NSArray<DemoModel*>* modelArray;

@end

#define kCellDemo @"kCellDemo"

@implementation DemoOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"横竖排列";
    [self setupSubviews];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubviews {
    self.layout = [FNCollectionViewLayout new];
    self.layout.layoutDirection = FNLayoutDirectionVertical;
    self.layout.itemSpace = 12;
    self.layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    self.layout.delegate = self;
    
    self.collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    [self.collection registerClass:[DemoConCollectionViewCell class] forCellWithReuseIdentifier:kCellDemo];
    self.collection.dataSource = self;
    self.collection.backgroundView = [UIView new];
    self.collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collection];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoConCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellDemo forIndexPath:indexPath];
    return cell;
}

- (CGSize)layout:(FNCollectionViewLayout *)layout sizeForCellAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
}


#pragma mark - data
- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [DemoModel loadDataWithPage:@(1) withCallBack:^(NSArray<DemoModel *> *modelArray) {
        weakSelf.modelArray = modelArray;
        [weakSelf.collection reloadData];
    }];
}


@end
