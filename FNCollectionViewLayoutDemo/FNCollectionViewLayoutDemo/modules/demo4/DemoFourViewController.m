//
//  DemoFourViewController.m
//  FNCollectionViewLayoutDemo
//
//  Created by 冯宁 on 2017/8/10.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "DemoFourViewController.h"
#import "FNCollectionViewReorderableLayout.h"
#import "DemoCollectionViewCell.h"
#import "DemoModel.h"

@interface DemoFourViewController () <FNCollectionViewReorderableLayoutDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView* collection;
@property (nonatomic, strong) FNCollectionViewReorderableLayout* layout;
@property (nonatomic, strong) NSArray<DemoModel*>* modelArray;
@end

#define kCellDemo @"kCellDemo"

@implementation DemoFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拖动排序";
    [self setupSubviews];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubviews {
    self.layout = [FNCollectionViewReorderableLayout new];
    self.layout.layoutDirection = FNLayoutDirectionHorizontal;
    self.layout.itemSpace = 12;
    self.layout.LineSpacing = 12;
    self.layout.lineBreak = YES;
    self.layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    self.layout.delegate = self;
    
    self.collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    [self.collection registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:kCellDemo];
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
    
    DemoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellDemo forIndexPath:indexPath];
    
    cell.model = self.modelArray[indexPath.item];
    
    return cell;
}

- (CGSize)layout:(FNCollectionViewLayout *)layout sizeForCellAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(floor(([UIScreen mainScreen].bounds.size.width - (12 * 8)) / 7) + self.modelArray[indexPath.item].randomNumber.integerValue % 40, 50 );
}

- (CGFloat)layout:(FNCollectionViewLayout *)layout absoluteSideForSection:(NSUInteger)section {
    return 50;
}


- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableArray* mArray = [self.modelArray mutableCopy];
    DemoModel* from = self.modelArray[fromIndexPath.item];
    [mArray removeObjectAtIndex:fromIndexPath.item];
    [mArray insertObject:from atIndex:toIndexPath.item];
    self.modelArray = mArray.copy;
}

#pragma mark - data
- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [DemoModel loadDataWithPage:@(1) withCallBack:^(NSArray<DemoModel *> *modelArray1) {
        [DemoModel loadDataWithPage:@(2) withCallBack:^(NSArray<DemoModel *> *modelArray2) {
            [DemoModel loadDataWithPage:@(3) withCallBack:^(NSArray<DemoModel *> *modelArray3) {
                NSMutableArray* mArray = [NSMutableArray array];
                [mArray addObjectsFromArray:modelArray1];
                [mArray addObjectsFromArray:modelArray2];
                [mArray addObjectsFromArray:modelArray3];
                weakSelf.modelArray = mArray.copy;
                [weakSelf.collection reloadData];
            }];
        }];
    }];
}


@end
