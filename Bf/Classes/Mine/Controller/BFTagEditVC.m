//
//  BFTagEditVC.m
//  Bf
//
//  Created by 春晓 on 2018/5/31.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFTagEditVC.h"
#import "BFAlertViewController.h"
#import "BFTagEditCell.h"

@interface BFTagEditVC ()<UICollectionViewDelegate,UICollectionViewDataSource,BFTagEditCellDelegate>
// Collect
@property (nonatomic , strong) UICollectionView *collectionView;
// 个数Label
@property (nonatomic , strong) UILabel *countLabel;
@end

static NSString *tagEditCell = @"tagEditCell";

@implementation BFTagEditVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"标签编辑页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"标签编辑页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_tagArray) {
        _tagArray = [NSMutableArray array];
    }
    [self setupUI];
    self.title = @"授课标签";
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitleColor:RGBColor(51,150,252) forState:(UIControlStateNormal)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(commitTag) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rigthItem;
}

- (void)setupUI {
    
    UIView *topBGView = [[UIView alloc] init];
    [self.view addSubview:topBGView];
    
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = RGBColor(204, 204, 204);
    [topBGView addSubview:topLineView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.attributedText =
    [NSMutableAttributedString new]
    .add(@"授课标签  ",@{
                NSForegroundColorAttributeName:RGBColor(51, 51, 51),
                NSFontAttributeName :[UIFont systemFontOfSize:14],
                })
    .add(@"每个标签最多五个字，最多添加6个标签",@{
                                         NSForegroundColorAttributeName:RGBColor(204, 204, 204),
                                         NSFontAttributeName :[UIFont systemFontOfSize:12],
                                         });
    [topBGView addSubview:titleLabel];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.attributedText =
    [NSMutableAttributedString new]
    .add(@"0",@{
                     NSForegroundColorAttributeName:RGBColor(51,150,252),
                     NSFontAttributeName :[UIFont systemFontOfSize:12],
                     })
    .add(@"/6",@{
                                 NSForegroundColorAttributeName:RGBColor(102,102,102),
                                 NSFontAttributeName :[UIFont systemFontOfSize:12],
                                 });
    [topBGView addSubview:_countLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BFTagEditCell class] forCellWithReuseIdentifier:tagEditCell];
    [self.view addSubview:_collectionView];
    
    topBGView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, 64)
    .heightIs(50);
    
    topLineView.sd_layout
    .leftEqualToView(topBGView)
    .rightEqualToView(topBGView)
    .topEqualToView(topBGView)
    .heightIs(10);
    
    titleLabel.sd_layout
    .leftSpaceToView(topBGView, 15)
    .rightSpaceToView(topBGView, 35)
    .topSpaceToView(topLineView, 0)
    .bottomEqualToView(topBGView);
    
    _countLabel.sd_layout
    .leftSpaceToView(titleLabel, 0)
    .rightSpaceToView(topBGView, 15)
    .topSpaceToView(topLineView, 0)
    .bottomEqualToView(topBGView);
    
    _collectionView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(topBGView, 10)
    .bottomEqualToView(self.view);
}

#pragma mark -collectionView-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_tagArray.count == 6) {
        return 6;
    }else{
        return _tagArray.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFTagEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tagEditCell forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.item == _tagArray.count) {
        cell.tagType = 0;
    }else{
        cell.tagType = 1;
        cell.tagLabel.text = _tagArray[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == _tagArray.count) {
        BFAlertViewController *alertVC = [BFAlertViewController BFAlertViewControllerWithTitle:@"添加标签" sureAction:^(NSString *str, BOOL isLegal, ReasonType resaon) {
            if (!isLegal) {
                switch (resaon) {
                    case ReasonType_LengthUnLegal:
                        [ZAlertView showSVProgressForErrorStatus:@"请输入长度正确的标签"];
                        break;
                    case ReasonType_SymbolUnLegal:
                        [ZAlertView showSVProgressForErrorStatus:@"不可使用标点符号"];
                        break;
                    default:
                        break;
                }
            }else{
                NSLog(@"%@",str);
                NSLog(@"%@",[NSThread currentThread]);
                [_tagArray addObject:str];
                _countLabel.attributedText =
                [NSMutableAttributedString new]
                .add([NSString stringWithFormat:@"%ld",_tagArray.count],@{
                            NSForegroundColorAttributeName:RGBColor(51,150,252),
                            NSFontAttributeName :[UIFont systemFontOfSize:12],
                            })
                .add(@"/6",@{
                             NSForegroundColorAttributeName:RGBColor(102,102,102),
                             NSFontAttributeName :[UIFont systemFontOfSize:12],
                             });
                [_collectionView reloadData];
            }
        }];
        //把当前控制器作为背景
        self.definesPresentationContext = YES;
        
        //设置模态视图弹出样式
        alertVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        //创建动画
        CATransition * transition = [CATransition animation];
        
        //设置动画类型（这个是字符串，可以搜索一些更好看的类型）
        transition.type = @"moveOut";
        
        //动画出现类型
        transition.subtype = @"fromCenter";
        
        //动画时间
        transition.duration = 0.3;
        
        //移除当前window的layer层的动画
        [self.view.window.layer removeAllAnimations];
        
        //将定制好的动画添加到当前控制器window的layer层
        [self.view.window.layer addAnimation:transition forKey:nil];
        
        [self presentViewController:alertVC animated:NO completion:nil];
    }
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tagArray.count == 6 || indexPath.item < _tagArray.count) {
        return [self getSizeWithText:_tagArray[indexPath.row]];
    }else{
        return CGSizeMake(100, 35);
    }
}

- (CGSize) getSizeWithText:(NSString*)text
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width + 60, 35);
}

#pragma mark -BFTagEditCellDelegate-

- (void)deleteTagWith:(BFTagEditCell *)cell{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    [_tagArray removeObjectAtIndex:indexPath.item];
    _countLabel.attributedText =
    [NSMutableAttributedString new]
    .add([NSString stringWithFormat:@"%ld",_tagArray.count],@{
                                                              NSForegroundColorAttributeName:RGBColor(51,150,252),
                                                              NSFontAttributeName :[UIFont systemFontOfSize:12],
                                                              })
    .add(@"/6",@{
                 NSForegroundColorAttributeName:RGBColor(102,102,102),
                 NSFontAttributeName :[UIFont systemFontOfSize:12],
                 });
    [_collectionView reloadData];
}

#pragma mark -提交按钮-

- (void)commitTag{
    _block(_tagArray);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
