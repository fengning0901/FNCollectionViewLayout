//
//  DemoThreeViewController.m
//  FNCollectionViewLayoutDemo
//
//  Created by 冯宁 on 2017/8/10.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "DemoThreeViewController.h"
#import "FNCollectionViewLayout.h"
#import "DemoCollectionViewCell.h"
#import "DemoModel.h"

@interface DemoThreeViewController () <FNCollectionViewLayoutDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView* collection;
@property (nonatomic, strong) FNCollectionViewLayout* layout;
@property (nonatomic, strong) NSArray<DemoModel*>* modelArray;
@end

#define kCellDemo @"kCellDemo"

@implementation DemoThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"瀑布流排列";
    [self setupSubviews];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubviews {
    self.layout = [FNCollectionViewLayout new];
    self.layout.layoutDirection = FNLayoutDirectionVertical;
    self.layout.itemSpace = 12;
    self.layout.LineSpacing = 12;
    self.layout.sectionSpacing = 12;
    self.layout.absoluteSize = YES;
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
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 2) {
        return self.modelArray.count - (self.modelArray.count / 3) * 2;
    } else {
        return self.modelArray.count / 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellDemo forIndexPath:indexPath];
    
    cell.model = self.modelArray[indexPath.item * 3 + indexPath.section];
    
    return cell;
}

- (CGSize)layout:(FNCollectionViewLayout *)layout sizeForCellAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(floor(([UIScreen mainScreen].bounds.size.width - (12 * 4)) / 3) , 100 + self.modelArray[indexPath.item * 3 + indexPath.section].randomNumber.integerValue % 100);
}

- (CGFloat)layout:(FNCollectionViewLayout *)layout absoluteSideForSection:(NSUInteger)section{
    return ([UIScreen mainScreen].bounds.size.width - 48) / 3;
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
