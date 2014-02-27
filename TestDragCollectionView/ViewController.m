//
//  ViewController.m
//  TestDragCollectionView
//
//  Created by shouian on 2013/11/30.
//  Copyright (c) 2013年 shouian. All rights reserved.
//

#import "ViewController.h"
// Draggable Collection View, you must at least import the following two header files
#import "DraggableCollectionViewFlowLayout.h"
#import "UICollectionView+Draggable.h"

@interface ViewController () <UICollectionViewDataSource_Draggable, UICollectionViewDelegate>
{
    NSMutableArray *data;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    /* Initialize Layout */
    DraggableCollectionViewFlowLayout *flowLayout = [[DraggableCollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    
    /* Initialize the collection view */
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate =  self;
    collectionView.draggable = YES; /* Set the property to be draggable */
    collectionView.backgroundColor = [UIColor blackColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:collectionView];
    
    /* Set up data source */
    data = [[NSMutableArray alloc] initWithCapacity:20];
    for(int i = 0; i < 20; i++) {
        [data addObject:@(i)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSNumber *index = [data objectAtIndex:indexPath.item];
    
    for (UIView *subview in cell.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            [subview removeFromSuperview];
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.text = [NSString stringWithFormat:@"%d", [index intValue]];
    label.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label];
    
    return cell;
}

- (BOOL)collectionView:(LSCollectionViewHelper *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(LSCollectionViewHelper *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSNumber *index = [data objectAtIndex:fromIndexPath.item];
    [data removeObjectAtIndex:fromIndexPath.item];
    [data insertObject:index atIndex:toIndexPath.item];
}


@end
