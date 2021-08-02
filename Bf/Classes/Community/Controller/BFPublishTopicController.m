//
//  BFPublishTopicController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/2.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFPublishTopicController.h"
#import "CCPlayVideoController.h"//视频播放页面
#import "CCTakeVideoController.h"//拍摄视频页面
#import "ZQPublicPhotoCell.h"
#import "ZQPublicAddCell.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"

#define CollectionViewHeight 200
#define ZQPublicPhotoCellIdentifier  @"ZQPublicPhotoCellIdentifier"
#define ZQPublicAddCellIdentifier @"ZQPublicAddCellIdentifier"

@interface BFPublishTopicController ()<UINavigationControllerDelegate,QBImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,ZQPublicPhotoCellDelegate,UITextFieldDelegate,UINavigationControllerDelegate>{
    BOOL _isPostVideo;
}
/*话题标题输入框*/
@property (nonatomic,strong) UITextField *titleField;
/*话题内容输入框*/
@property (nonatomic,strong) UITextView *contentField;
/*创建背景UIScrollView*/
@property (nonatomic,strong) UIScrollView *scrollView;
//视频缩略图
@property (nonatomic,strong) UIImage *image;
/*放置视频的背景位置*/
@property (nonatomic,strong) UIImageView *imgView;
/*添加视频按钮*/
@property (nonatomic,strong) UIButton *videoBtn;
/*添加图片按钮*/
@property (nonatomic,strong) UIButton *photoBtn;
/*视频路径*/
@property (nonatomic,strong) NSString *videoUrl;
/*创建collectionView*/
@property (nonatomic,strong) UICollectionView *photoView;
/*图片缩略图数组*/
@property (nonatomic, strong) NSMutableArray *thumbnailImageArray;
/*图片描述数组*/
@property (nonatomic, strong) NSMutableArray *imgIntroArray;
/*图片沙盒路径*/
@property (nonatomic, strong) NSString * sandBox_url;
/*点击的图片*/
@property (nonatomic,assign) NSInteger photoIndex;
/*点击图片时全屏的图片*/
@property (nonatomic,strong) UIImageView *browseImgView;
/*点击图片时全屏的背景视图*/
@property (nonatomic,strong) UIView *bgView;
/*图片描述*/
@property (nonatomic,copy) NSString *introStr;
/*collection Cell*/
@property (nonatomic,strong) ZQPublicPhotoCell *photoCell;
/*上传视频路径*/
@property (nonatomic,copy) NSString *videoPath;

@property (strong, nonatomic)DWUploadItem *uploadItem;
/*视频id*/
@property (nonatomic,copy) NSString *videoIdStr;
/*图片描述字符串拼接*/
@property (nonatomic,copy) NSString *appendStr;
@end

@implementation BFPublishTopicController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self addVideoFileToUpload];
    
//    [MobClick beginLogPageView:@"发布帖子页"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"发布帖子页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题文字
    self.navigationItem.title = @"发布话题";
    //导航控制器两侧按钮
    [self createNavgationButton];
    //scrollView
    [self createUIScrollView];
    //文本输入框部分
    [self createTextView];
    //图片视频区域
    [self createVideoAndImage];
    //collectionView
    [self createCollectionView];
    //预览视频之后删除视频的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteVideo) name:@"deleteVideo" object:nil];
    //拍摄视频之后视频路径的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveVideoUrl:) name:@"saveVideoUrl" object:nil];
}

#pragma mark - 创建导航栏左右两侧按钮

-(void)createNavgationButton {
    //设置返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    [backButton setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //设置导航栏右侧按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"发布" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGBColor(0, 126, 212) forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    [btn1 setFrame:CGRectMake(0, 0, 40, 30)];
    [btn1 addTarget:self action:@selector(clickPublishBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.rightBarButtonItems = @[item1];
}

#pragma mark - 返回按钮的点击事件

-(void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 发布按钮的点击事件

-(void)clickPublishBtn {
    
    if (self.titleField.text == nil || [self.titleField.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入帖子的标题"];
    }
    else if (self.titleField.text.length < 5) {
        [ZAlertView showSVProgressForErrorStatus:@"帖子标题最少5个字"];
    }
    else if (self.contentField.text.length < 20) {
        [ZAlertView showSVProgressForErrorStatus:@"帖子内容最少20个字"];
    }
    else if (self.contentField.text == nil || [self.contentField.text isEqualToString:@""] || [self.contentField.text isEqualToString:@"这里输入详细的描述,附加图片更易于交流哦"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入帖子内容"];
    }
    else {
        [ZAlertView showSVProgressNotClickForStr:@"正在发布中"];
        
        if (self.image != nil) {
            [self videoUploadStatusButtonAction];
        }
        else {
            [self uploadOtherPara];
        }
    }
}

-(void)uploadOtherPara {
    NSString *state = @"0";
    if (self.titleField.text == nil || [self.titleField.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入帖子标题"];
    }
    else if (self.titleField.text.length < 5) {
        [ZAlertView showSVProgressForErrorStatus:@"帖子标题最少5个字"];
    }
    else if (self.contentField.text.length < 20) {
        [ZAlertView showSVProgressForErrorStatus:@"帖子内容最少20个字"];
    }
    else if (self.contentField.text == nil || [self.contentField.text isEqualToString:@""] || [self.contentField.text isEqualToString:@"这里输入详细的描述,附加图片更易于交流哦"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入帖子内容"];
    }
    else {
        if (self.thumbnailImageArray.count == 0 && self.image == nil) {
            NSLog(@"该帖子没有图片和视频");
            state = @"0";
        }
        else if (self.image == nil && self.thumbnailImageArray.count != 0) {
            NSLog(@"该帖子有图片,没有视频");
            state = @"1";
        }
        else if (self.image != nil && self.thumbnailImageArray.count == 0) {
            NSLog(@"该帖子没有图片,有视频");
            state = @"2";
        }
        else {
            state = @"3";
        }
        NSString *userId = GetFromUserDefaults(@"uId");//用户id
        NSString *pSatate = state;//帖子类型 (0:文本内容 -- 1:图片类型 -- 2:视频类型 -- 3:图片视频)
        NSString *pTitle = self.titleField.text;//帖子标题
        NSString *pCcont = self.contentField.text;//帖子内容
        if (self.image != nil) {
            [self.thumbnailImageArray insertObject:self.image atIndex:0];
        }
        NSString *pVideo = [NSString stringWithFormat:@"%@",self.videoIdStr];//上传视频id
        
        
        for (int i = 0; i < self.imgIntroArray.count; i++) {
            
            if ([_imgIntroArray[i] isKindOfClass:[UIImage class]]) {//
                //是测试备用的图片
                NSLog(@"这是张图片,不作处理");
            }
            else {
                NSString *str = [NSString stringWithFormat:@"%@",self.imgIntroArray[i]];
                [self.imgIntroArray removeObject:self.imgIntroArray[i]];
                [self.imgIntroArray insertObject:str atIndex:i];
                NSString *string = [self.imgIntroArray componentsJoinedByString:@"?"];
                self.appendStr = string;
                NSLog(@"最后显示的图片描述数据为:%@",self.appendStr);
            }
        }
        NSString *pPContString = self.appendStr;//图片描述字符串拼接
        NSMutableDictionary *publishDic = [[NSMutableDictionary alloc] init];
        [publishDic setValue:userId forKey:@"uId"];
        [publishDic setValue:pSatate forKey:@"pState"];
        [publishDic setValue:pTitle forKey:@"pTitle"];
        [publishDic setValue:pCcont forKey:@"pCcont"];
        [publishDic setValue:pPContString forKey:@"pPContString"];
        [publishDic setValue:pVideo forKey:@"pVideo"];

        //发送网络请求
        [NetworkRequest sendImagesWithUrl:PublishTips parameters:publishDic imageArray:self.thumbnailImageArray successResponse:^(id data) {
            NSLog(@"请求成功!");
            [ZAlertView showSVProgressForSuccess:@"发布成功!"];
//            [MobClick event:@"publishTopic"];
            
            [self.navigationController popViewControllerAnimated:YES];
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"发布失败!"];
            NSLog(@"请求失败!");
        }];
    }
}
#pragma mark - 创建UIScrollView

-(void)createUIScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0f];
    self.scrollView.contentSize = CGSizeMake(KScreenW,1.1 * KScreenH);
    self.scrollView.bounces = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
}

#pragma mark - 创建collectionView

-(void)createCollectionView {
    CGFloat photoViewX = 0;
    //    CGFloat photoViewY = self.photoBtn.bottom + 10;
    CGFloat photoViewW = KScreenW - 2 * photoViewX;
    //    CGFloat photoViewH = 300;
    CGRect photoViewFrame = CGRectMake(0, KScreenH, KScreenW - 2 * photoViewX, photoViewW + 60);
    UICollectionViewFlowLayout *dynamicLayout = [[UICollectionViewFlowLayout alloc] init];
    [dynamicLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置最小行、列间距，内边距
    dynamicLayout.minimumLineSpacing = 10;
    dynamicLayout.minimumInteritemSpacing = 5;
    dynamicLayout.itemSize = CGSizeMake((photoViewW - 40)/3, (photoViewW - 40)/3);
    UICollectionView *photoView = [[UICollectionView alloc] initWithFrame:photoViewFrame collectionViewLayout:dynamicLayout];
    photoView.backgroundColor = RGBColor(243, 243, 243);
    self.photoView = photoView;
    self.photoView.delegate = self;
    self.photoView.dataSource = self;
    [self.photoView registerNib: [UINib nibWithNibName:@"ZQPublicAddCell" bundle:nil] forCellWithReuseIdentifier:@"ZQPublicAddCellIdentifier"];
    //长按进行拖拽
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.photoView addGestureRecognizer:longPressGesture];
    
    [self.scrollView addSubview:self.photoView];
}

#pragma mark - 长按拖拽collectionView中的图片

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:self.photoView];
    NSIndexPath *indexPath = [self.photoView indexPathForItemAtPoint:point];
    //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            [self.photoView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            [self.photoView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            [self.photoView endInteractiveMovement];
            break;
        default:
            //取消移动
            [self.photoView cancelInteractiveMovement];
            break;
    }
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
    /* 两个indexpath参数, 分别代表源位置, 和将要移动的目的位置*/
    //-1 是为了不让最后一个可以交换位置
    if (proposedIndexPath.item == (_thumbnailImageArray.count)) {
        //初始位置
        return originalIndexPath;
    } else {
        //-1 是为了不让最后一个可以交换位置
        if (originalIndexPath.item == (_thumbnailImageArray.count)) {
            return originalIndexPath;
        }
        //      移动后的位置
        return proposedIndexPath;
    }
}

#pragma mark - 在开始移动时会调用此代理方法

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexpath判断单元格是否可以移动，如果都可以移动，直接就返回YES ,不能移动的返回NO
    if (indexPath.row == self.thumbnailImageArray.count) {
        return NO;
    }
    return YES;
}

#pragma mark - 在移动结束的时候调用此代理方法

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    UIImage *img = _thumbnailImageArray[sourceIndexPath.row];
    [_thumbnailImageArray removeObjectAtIndex:sourceIndexPath.row];
    [_thumbnailImageArray insertObject:img atIndex:destinationIndexPath.row];
    if(![_imgIntroArray[sourceIndexPath.row] isKindOfClass:[UIImage class]]){
        NSString *  Intro = _imgIntroArray[sourceIndexPath.row];
        [_imgIntroArray removeObjectAtIndex:sourceIndexPath.row];
        NSString *newStr = [NSString stringWithFormat:@"0%ld",destinationIndexPath.row + 1];
        NSString *introPlace = [Intro stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:newStr];
        [_imgIntroArray insertObject:introPlace atIndex:destinationIndexPath.row];
    }else{
//        UIImage *  Introimg = _imgIntroArray[sourceIndexPath.row];
//        [_imgIntroArray removeObjectAtIndex:sourceIndexPath.row];
//        [_imgIntroArray insertObject:Introimg atIndex:destinationIndexPath.row];
    }
    self.photoIndex = destinationIndexPath.row;
}

#pragma mark - CollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (_communityType == BFCommunityType_Send) {
//        return self.thumbnailImageArray.count >= 9 ? 9 : self.thumbnailImageArray.count + 1;
//    }else{
//        return self.thumbnailImageArray.count >= 9 ? 9 : self.thumbnailImageArray.count + 1;
//    }
    return self.thumbnailImageArray.count >= 9 ? 9 : self.thumbnailImageArray.count + 1;
}

#pragma mark - 将动态数组中的图片赋值给cell

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.thumbnailImageArray.count) {
        ZQPublicAddCell *addCell = [collectionView dequeueReusableCellWithReuseIdentifier:ZQPublicAddCellIdentifier forIndexPath:indexPath];
        return  addCell;
    } else {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        [self.photoView registerNib:[UINib nibWithNibName:@"ZQPublicPhotoCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
        ZQPublicPhotoCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        self.photoCell = photoCell;
        photoCell.photoView.image = self.thumbnailImageArray[indexPath.row];
        NSLog(@"现在点击的图片是第%ld张 ---- 图片index.row是第%ld张",self.photoIndex,indexPath.row);
        [_imgIntroArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row){
                NSLog(@"%ld图片描述obj%@",(long)indexPath.row,obj);
                if(_imgIntroArray.count >=indexPath.row && ![_imgIntroArray[indexPath.row] isKindOfClass:[UIImage class]]){
                    photoCell.introLabel.backgroundColor = [UIColor blackColor];
                    photoCell.introLabel.alpha = 0.60f;
                    photoCell.introLabel.font = [UIFont fontWithName:BFfont size:13.0f];
                    photoCell.introLabel.textColor = [UIColor whiteColor];
                    photoCell.introLabel.textAlignment = NSTextAlignmentCenter;
                    NSString *s = [_imgIntroArray[idx] substringFromIndex:2];
                    photoCell.introLabel.text = s;
                }else{
                    photoCell.introLabel.backgroundColor = [UIColor clearColor];
                    photoCell.introLabel.text = @"";
                }
            }
        }];
        photoCell.delegate = self;
        return photoCell;
    }
}

#pragma mark - 图片的选择事件

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.contentField canResignFirstResponder]) {
        [self.contentField resignFirstResponder];
    }
    
    if (indexPath.row == self.thumbnailImageArray.count) {
        [self onClickButtonAddPicture];
    }
    else {
        NSLog(@"点击的是第%ld张图片",indexPath.row);
        self.photoIndex = indexPath.row;
        _isPostVideo = NO;
        ZQDialogueViewController *controller = [[ZQDialogueViewController alloc] initWithActions:@[@"查看大图",@"编辑图片"] block:^(int index) {
            if (index == 0) {
                //点击取消的响应事件
            }
            else if(index == 1) {
                //查看大图
                [self getBigPhoto];
            }
            else if (index == 2) {
                //编辑图片
                [self editorPhoto];
            }
            else {
            }
        }];
        [controller show];
    }
}

#pragma mark - 点击+按钮的选择事件

-(void)onClickButtonAddPicture {
    _isPostVideo = NO;
    ZQDialogueViewController *controller = [[ZQDialogueViewController alloc] initWithActions:@[@"拍照",@"从本地选择"] block:^(int index) {
        if (index == 0) {
            //点击取消的响应事件
        }
        else if(index == 1) {
            //拍照
            [self getTakePhoto];
        }
        else if (index == 2) {
            //从本地选择
            [self getLocalPhoto];
        }
        else {
        }
    }];
    [controller show];
}

#pragma mark - 图片删除的代理方法

-(void)delegatePhotoFromCell:(UICollectionViewCell *)cell {
    
    if ([self.contentField canResignFirstResponder]) {
        [self.contentField resignFirstResponder];
    }
    
    NSIndexPath *indexPath = [self.photoView indexPathForCell:cell];
    // 数据源
    [self.thumbnailImageArray removeObjectAtIndex:indexPath.row];
    [self.imgIntroArray removeObjectAtIndex:indexPath.row];
    if (self.thumbnailImageArray.count == 0) {
        self.photoView.frame = CGRectMake(0,KScreenH, KScreenW, KScreenW);
    }
    else {
        self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
        self.photoBtn.backgroundColor = [UIColor clearColor];
    }
    [self.photoBtn setBackgroundColor:[UIColor whiteColor]];
    // 图片刷新
    [self.photoView reloadData];
}

#pragma mark - 创建文本输入框

-(void)createTextView {
    //标题
    _titleField = [[UITextField alloc] initWithFrame:CGRectMake(0,0, KScreenW, 45)];
    _titleField.backgroundColor = [UIColor whiteColor];
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(_titleField.frame.origin.x,_titleField.frame.origin.y,22.0, _titleField.frame.size.height)];
    _titleField.leftView = blankView;
    _titleField.leftViewMode =UITextFieldViewModeAlways;
    _titleField.placeholder = @"请输入帖子题目(不少于5个字)";
    _titleField.font = [UIFont fontWithName:BFfont size:14.0f];
    _titleField.textColor = RGBColor(51, 51, 51);
    _titleField.delegate = self;
    [self.scrollView addSubview:_titleField];
    //下划线1
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, _titleField.bottom, KScreenW - 24, 0.50f)];
    line.backgroundColor = RGBColor(231, 229, 229);
    [self.scrollView addSubview:line];
    //内容
    _contentField = [[UITextView alloc] initWithFrame:CGRectMake(0, line.bottom, KScreenW, 133)];
    _contentField.text = @"这里输入详细的描述,附加图片更易于交流哦(不少于20字)";
    _contentField.textContainerInset = UIEdgeInsetsMake(5, 16, 5, 15);
    _contentField.textColor = RGBColor(153, 153, 153);
    _contentField.font = [UIFont fontWithName:BFfont size:13.0f];
    _contentField.delegate = self;
    [self.scrollView addSubview:_contentField];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger maxLength = 30;//设置限制字数
    if (textField == _titleField) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > maxLength && range.length!=1){
            textField.text = [toBeString substringToIndex:maxLength];
            return NO;
        }
    }
    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.contentField.text.length > 30000) {
        self.contentField.text = [textView.text substringToIndex:30000];
        [ZAlertView showSVProgressForInfoStatus:@"发布帖子不超过30000字"];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.contentField.text isEqualToString:@"这里输入详细的描述,附加图片更易于交流哦(不少于20字)"]){
        self.contentField.text=@"";
    }
}

#pragma mark - 创建图片/视频区域

-(void)createVideoAndImage {
    //添加视频
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.frame = CGRectMake(0, _contentField.bottom + 10, KScreenW, 50);
    [videoBtn setTitle:@"+ 添加视频" forState:UIControlStateNormal];
    [videoBtn setTitleColor:RGBColor(153, 153, 153) forState:UIControlStateNormal];
    videoBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [videoBtn setBackgroundColor:[UIColor whiteColor]];
    [videoBtn addTarget:self action:@selector(clickVideoBtn) forControlEvents:UIControlEventTouchUpInside];
    self.videoBtn = videoBtn;
    [self.scrollView addSubview:videoBtn];
    //添加图片
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(0, videoBtn.bottom + 10, KScreenW, 50);
    [photoBtn setTitle:@"+ 添加图片" forState:UIControlStateNormal];
    [photoBtn setTitleColor:RGBColor(153, 153, 153) forState:UIControlStateNormal];
    photoBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [photoBtn setBackgroundColor:[UIColor whiteColor]];
    [photoBtn addTarget:self action:@selector(clickPhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    self.photoBtn = photoBtn;
    [self.scrollView addSubview:photoBtn];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, KScreenW, 200)];
    _imgView.backgroundColor = [UIColor clearColor];
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setImage:[UIImage imageNamed:@"视频-2"] forState:UIControlStateNormal];
    playBtn.frame = CGRectMake((KScreenW - 40)/2, (_imgView.height - 40)/2, 40, 40);
    [playBtn addTarget:self action:@selector(clickPlayBtn) forControlEvents:UIControlEventTouchUpInside];
    [_imgView addSubview:playBtn];
    [self.scrollView addSubview:_imgView];
}

//#pragma mark - 录制完视频之后获取本地视频文件
//
//-(void)saveVideoUrl:(NSNotification *)notification {
//    NSDictionary *dic = [notification object];
//    NSLog(@"数据为:%@",dic);
//    //设置视频原路径
//    NSString *str = [NSString stringWithFormat:@"%@",dic[@"videoPath"]];
//    NSString *newStr = [NSString stringWithFormat:@"file:%@",str];
//    NSURL *u = [NSURL URLWithString:newStr];
//    self.videoUrl = newStr;
//    //获取视频缩略图
//    UIImageView *videoImage = [[UIImageView alloc] init];
//    videoImage.image = [self thumbnailImageForVideo:u atTime:0.5];
//    self.image = videoImage.image;
//
//    _imgView.frame = CGRectMake(10, _contentField.bottom + 10, KScreenW - 20, 162);
//    [_videoBtn setBackgroundColor:[UIColor clearColor]];
//    [_imgView setContentMode:UIViewContentModeScaleAspectFill];
//    _imgView.clipsToBounds = YES;
//    _imgView.userInteractionEnabled = YES;
//    _imgView.image = self.image;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        _photoBtn.frame = CGRectMake(20, _imgView.bottom + 10, KScreenW - 40, 50);
//        NSLog(@"此时图片个数为:%ld",self.thumbnailImageArray.count);
//        if (self.thumbnailImageArray.count == 0) {
//            self.photoView.frame = CGRectMake(0,KScreenH, KScreenW, KScreenW);
//        }
//        else {
//            self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
//            self.photoBtn.backgroundColor = [UIColor clearColor];
//        }
//    });
//}

#pragma mark - 删除视频的通知事件

-(void)deleteVideo {
    
    [_imgView removeFromSuperview];
    self.videoBtn.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        _photoBtn.frame = CGRectMake(0, self.videoBtn.bottom + 10, KScreenW, 50);
        NSLog(@"此时图片个数为:%ld",self.thumbnailImageArray.count);
        if (self.thumbnailImageArray.count == 0) {
            self.photoView.frame = CGRectMake(0,KScreenH, KScreenW, KScreenW);
        }
        else {
            self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
            self.photoBtn.backgroundColor = [UIColor clearColor];
        }
    });
}

#pragma mark - 点击跳转到视频播放页面

-(void)clickPlayBtn {
    CCPlayVideoController *liveVC = [[CCPlayVideoController alloc] init];
    liveVC.videoUrl = [NSString stringWithFormat:@"file://%@",self.videoPath];
    UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:liveVC];
    navigation.modalPresentationStyle = 0;
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - 添加视频的点击事件

-(void)clickVideoBtn {
    _isPostVideo = YES;
    ZQDialogueViewController *controller = [[ZQDialogueViewController alloc] initWithActions:@[@"从本地选择"] block:^(int index) {
        if (index == 0) {
            //点击取消的响应事件
        }
        else {
            //从本地选择
            [self getLocalVideo];
        }
    }];
    [controller show];
}

#pragma mark - 查看大图

-(void)getBigPhoto {
    self.navigationController.navigationBarHidden = YES;
    //创建一个黑色背景
    //初始化一个用来当做背景的View。
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [bgView setBackgroundColor:[UIColor colorWithRed:0/250.0 green:0/250.0 blue:0/250.0 alpha:1.0]];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    //创建显示图像的视图
    //初始化要显示的图片内容的imageView
    UIImageView *browseImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    browseImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.browseImgView = browseImgView;
    //要显示的图片，即要放大的图片
    _browseImgView.image = self.thumbnailImageArray[self.photoIndex];
    [bgView addSubview:browseImgView];
    browseImgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    [browseImgView addGestureRecognizer:tapGesture];
    //放大过程中的动画
    [self shakeToShow:bgView];
}

#pragma mark - 点击关闭放大的全屏图片

-(void)closeView{
    self.navigationController.navigationBarHidden = NO;
    [self.bgView removeFromSuperview];
}

#pragma mark - 点击放大图片的动画

- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

#pragma mark - 编辑图片

-(void)editorPhoto {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加图片描述" message:nil preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.  
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        alertController.textFields.firstObject.delegate = self;
        NSString *str = alertController.textFields.firstObject.text;
        self.introStr = str;
        NSLog(@"此时点击的是第%ld张图片",self.photoIndex);
        NSString *imgIntro = [NSString stringWithFormat:@"0%ld%@",self.photoIndex + 1,self.introStr];
        [self.imgIntroArray removeObjectAtIndex:self.photoIndex];
        [self.imgIntroArray insertObject:imgIntro atIndex:self.photoIndex];
        [self.photoView reloadData];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    }];
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 拍摄视频

-(void)getTakeVideo {
    CCTakeVideoController *takeVideoVC = [[CCTakeVideoController alloc] init];
    takeVideoVC.modalPresentationStyle = 0;
    [self presentViewController:takeVideoVC animated:YES completion:nil];
}

#pragma mark - 从本地获取视频

-(void)getLocalVideo {
    //    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    //    imagePickerController.delegate = self;
    //    imagePickerController.assetCollectionSubtypes = @[@(PHAssetCollectionSubtypeSmartAlbumVideos)];
    //    imagePickerController.mediaType = QBImagePickerMediaTypeVideo;
    //    imagePickerController.allowsMultipleSelection = YES;
    //    imagePickerController.minimumNumberOfSelection = 1;
    //    imagePickerController.maximumNumberOfSelection =  1;
    //    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    DWVideoCompressController *imagePicker = [[DWVideoCompressController alloc] initWithQuality: DWUIImagePickerControllerQualityTypeMedium andSourceType:DWUIImagePickerControllerSourceTypePhotoLibrary andMediaType:DWUIImagePickerControllerMediaTypeMovie];
    imagePicker.delegate = self;
    imagePicker.modalPresentationStyle = 0;
    [self presentViewController:imagePicker animated:NO completion:nil];
    
    
}

#pragma mark - 添加图片的点击事件

-(void)clickPhotoBtn {
    _isPostVideo = NO;
    ZQDialogueViewController *controller = [[ZQDialogueViewController alloc] initWithActions:@[@"拍照",@"从本地选择"] block:^(int index) {
        if (index == 0) {
            //点击取消的响应事件
        }
        else if(index == 1) {
            //拍照
            [self getTakePhoto];
        }
        else if (index == 2) {
            //从本地选择
            [self getLocalPhoto];
        }
        else {
        }
    }];
    [controller show];
}

#pragma mark - 拍摄照片

-(void)getTakePhoto {
    UIImagePickerController * pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerVC.allowsEditing = YES;
    pickerVC.delegate = self;
    pickerVC.modalPresentationStyle = 0;
    [self presentViewController:pickerVC animated:YES completion:nil];
}

#pragma mark - 拍完照之后点击use调用的方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        // 获取照片
        UIImage *getImg = info[UIImagePickerControllerEditedImage];
        NSArray *documentsArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsArr objectAtIndex:0];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"file"];
        _sandBox_url = filePath;
        [UIImagePNGRepresentation(getImg) writeToFile:filePath atomically:YES];
        [self.thumbnailImageArray addObject:getImg];
        if(self.thumbnailImageArray.count >_imgIntroArray.count){
            [self.imgIntroArray addObject:getImg];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
            self.photoBtn.backgroundColor = [UIColor clearColor];
            [self.photoView reloadData];
        });

        // 退出相册
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        loginfo(@"info: %@", info);
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        self.videoPath = [videoURL path];
        loginfo(@"moviePath: %@", self.videoPath);
        [picker dismissViewControllerAnimated:YES completion:nil];
        NSURL *u = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",self.videoPath]];
//        self.videoPath = [NSString stringWithContentsOfURL:u];
        //获取视频缩略图
        self.image = [self thumbnailImageForVideo:u atTime:0.5];
        NSLog(@"self.image : %@",self.image);
        dispatch_async(dispatch_get_main_queue(), ^{
            _imgView.frame = CGRectMake(10, _contentField.bottom + 10, KScreenW - 20, 162);
            [_videoBtn setBackgroundColor:[UIColor clearColor]];
            [_imgView setContentMode:UIViewContentModeScaleAspectFill];
            _imgView.clipsToBounds = YES;
            _imgView.userInteractionEnabled = YES;
            _imgView.image = self.image;
            _photoBtn.frame = CGRectMake(0, _imgView.bottom + 10, KScreenW, 50);
            NSLog(@"此时图片个数为:%ld",self.thumbnailImageArray.count);
            if (self.thumbnailImageArray.count == 0) {
                self.photoView.frame = CGRectMake(0,KScreenH, KScreenW, KScreenW);
            }
            else {
                self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
                self.photoBtn.backgroundColor = [UIColor clearColor];
            }
        });
        
    }
}

# pragma mark - processer

- (void)addVideoFileToUpload {
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *videoTitle = self.titleField.text;
    NSString *videoTag = @"北方职教";
    NSString *videoDescription = self.contentField.text;
    
    DWUploadItem *item = [[DWUploadItem alloc] init];
    item.videoUploadStatus = DWUploadStatusWait;
    item.videoPath = self.videoPath;
    item.videoTitle = videoTitle;
    item.videoTag = videoTag;
    item.videoDescripton = videoDescription;
    item.videoUploadProgress = 0.0f;
    item.videoUploadedSize = 0;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.videoPath]) {
        item.videoUploadStatus = DWUploadStatusLoadLocalFileInvalid;
        goto done;
    }
    
    // 文件不存在则不设置
    item.videoThumbnailPath = [NSString stringWithFormat:@"%@/%@.png", documentDirectory, videoTitle];
    [DWTools saveVideoThumbnailWithVideoPath:self.videoPath toFile:item.videoThumbnailPath Error:&error];
    if (error) {
        item.videoUploadStatus = DWUploadStatusLoadLocalFileInvalid;
        loginfo(@"save thumbnail %@ failed: %@", self.videoPath, [error localizedDescription]);
        goto done;
    }
    
    item.videoFileSize = [DWTools getFileSizeWithPath:self.videoPath Error:&error];
    if (error) {
        item.videoUploadStatus = DWUploadStatusLoadLocalFileInvalid;
        loginfo(@"get videoPath %@ failed: %@", self.videoPath, [error localizedDescription]);
        item.videoFileSize = 0;
        goto done;
    }
    
done:
    self.uploadItem = item;
    logdebug(@"add item: %@", item);
}

#pragma mark - upload

- (void)videoUploadStatusButtonAction
{
    DWUploadItem *item = self.uploadItem;
    NSLog(@"item为:%@",item);
    switch (item.videoUploadStatus) {
        case DWUploadStatusWait:
            // 状态转为 开始上传
            [self videoUploadStartWithItem:item];
            break;
            
        case DWUploadStatusStart:
            // 状态转为 暂停上传
            [self videoUploadPauseWithItem:item];
            break;
            
        case DWUploadStatusUploading:
            // 状态转为 暂停上传
            [self videoUploadPauseWithItem:item];
            break;
            
        case DWUploadStatusPause:
            // 状态转为 开始上传
            
            [self videoUploadResumeWithItem:item];
            break;
            
        case DWUploadStatusResume:
            // 状态转为 暂停上传
            
            [self videoUploadPauseWithItem:item];
            break;
            
        case DWUploadStatusLoadLocalFileInvalid:
            // 报警 告知用户 "本地文件不存在，删除任务重新添加文件"
            [self videoUploadFailedAlert:@"本地文件不存在，删除任务重新添加文件"];
            break;
            
        case DWUploadStatusFail:
            // 状态转为 继续上传
            
            [self videoUploadResumeWithItem:item];
            break;
            
        case DWUploadStatusFinish:
            // 在 DWUploadStatusStart 和 DWUploadStatusResume 状态中
            // 如果上传完成，则至 cell.statusButton.userInteractionEnabled = NO 不在接收交互事件。
            // 所以这里不需要做处理。
            break;
            
        default:
            break;
    }
}

- (void)videoUploadFailedAlert:(NSString *)info
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:info
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)setUploadBlockWithItem:(DWUploadItem *)item
{
    DWUploader *uploader = item.uploader;
    
    uploader.progressBlock = ^(float progress, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        item.videoUploadProgress = progress;
        [ZAlertView showSVProgressNotClickForStr:[NSString stringWithFormat:@"上传进度:%2.0f%%", progress * 100]];
        item.videoUploadedSize = totalBytesWritten;
        NSString *str = [NSString stringWithFormat:@"%f",progress];
        int intStr = [str intValue];
        if (intStr == 1) {
            [self uploadOtherPara];
        }
    };
    
    uploader.finishBlock = ^() {
        loginfo(@"finish");
        item.videoUploadStatus = DWUploadStatusFinish;
        
    };
    
    uploader.failBlock = ^(NSError *error) {
        loginfo(@"error: %@", [error localizedDescription]);
        item.uploader = nil;
        item.videoUploadStatus = DWUploadStatusFail;
        
    };
    
    uploader.pausedBlock = ^(NSError *error) {
        loginfo(@"error: %@", [error localizedDescription]);
        item.videoUploadStatus = DWUploadStatusPause;
    };
    
    uploader.videoContextForRetryBlock = ^(NSDictionary *videoContext) {
        loginfo(@"context: %@", videoContext);
        item.uploadContext = videoContext;
        self.videoIdStr = videoContext[@"videoid"];
        
    };
}

- (void)videoUploadStartWithItem:(DWUploadItem *)item
{
    item.uploader = [[DWUploader alloc] initWithUserId:DWACCOUNT_USERID
                                                andKey:DWACCOUNT_APIKEY
                                      uploadVideoTitle:item.videoTitle
                                      videoDescription:item.videoDescripton
                                              videoTag:item.videoTag
                                             videoPath:item.videoPath
                                             notifyURL:@"http://www.bokecc.com/"];
    
    item.videoUploadStatus = DWUploadStatusUploading;
    
    DWUploader *uploader = item.uploader;
    
    uploader.timeoutSeconds = 20;
    
    [self setUploadBlockWithItem:item];
    
    [uploader start];
}

- (void)videoUploadResumeWithItem:(DWUploadItem *)item
{
    if (item.uploadContext) {
        if (!item.uploader) {
            item.uploader = [[DWUploader alloc] initWithVideoContext:item.uploadContext];
        }
        item.videoUploadStatus  = DWUploadStatusUploading;
        item.uploader.timeoutSeconds = 20;
        [self setUploadBlockWithItem:item];
        
        [item.uploader resume];
        
        return;
    }
    item.uploader = nil;
    [self videoUploadStartWithItem:item];
}

- (void)videoUploadPauseWithItem:(DWUploadItem *)item
{
    if (!item.uploader) {
        return;
    }
    [item.uploader pause];
    item.videoUploadStatus = DWUploadStatusPause;
}


#pragma mark - 从本地获取照片

-(void)getLocalPhoto {
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.assetCollectionSubtypes = @[@(PHAssetCollectionSubtypeSmartAlbumUserLibrary)];
    imagePickerController.mediaType = QBImagePickerMediaTypeImage;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection =  9 - self.thumbnailImageArray.count;
    imagePickerController.modalPresentationStyle = 0;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - QBImagePickerDelegate

-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    for (PHAsset *set in assets) {
        
        if (_isPostVideo == YES) {//如果选择的是视频
            PHVideoRequestOptions *optionss = [[PHVideoRequestOptions alloc] init];
            optionss.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            [[PHImageManager defaultManager] requestAVAssetForVideo:set options:optionss resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                //设置视频原路径
                NSString *str = [NSString stringWithFormat:@"%@",asset];
                NSRange range = [str rangeOfString:@"file:"];
                if (range.length == 0) {
                    [ZAlertView showSVProgressForErrorStatus:@"请您选择未经过加速或减速处理的视频"];
                }
                else {
                    NSString *result = [str substringFromIndex:range.location];
                    NSString *newStr = [result substringWithRange:NSMakeRange(0, [result length] - 1)];
                    self.videoUrl = newStr;
                    //获取视频路径
                    NSURL *u = [NSURL URLWithString:newStr];
                    self.videoPath = [u path];
                    //获取视频时间长度
                    //                NSInteger timeInt = [self durationWithVideo:u];
                    //获取视频缩略图
                    self.image = [self thumbnailImageForVideo:u atTime:0.5];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _imgView.frame = CGRectMake(10, _contentField.bottom + 10, KScreenW - 20, 162);
                        [_videoBtn setBackgroundColor:[UIColor clearColor]];
                        [_imgView setContentMode:UIViewContentModeScaleAspectFill];
                        _imgView.clipsToBounds = YES;
                        _imgView.userInteractionEnabled = YES;
                        _imgView.image = self.image;
                        _photoBtn.frame = CGRectMake(0, _imgView.bottom + 10, KScreenW, 50);
                        NSLog(@"此时图片个数为:%ld",self.thumbnailImageArray.count);
                        if (self.thumbnailImageArray.count == 0) {
                            self.photoView.frame = CGRectMake(0,KScreenH, KScreenW, KScreenW);
                        }
                        else {
                            self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
                            self.photoBtn.backgroundColor = [UIColor clearColor];
                        }
                    });
                }
            }];
        }
        else {//如果选择的是图片
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            [[PHImageManager defaultManager] requestImageForAsset:set targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                NSLog(@"%@",result);
                NSLog(@"%@",info);
                [self.thumbnailImageArray addObject:result];
                if(self.thumbnailImageArray.count >_imgIntroArray.count){
                    [self.imgIntroArray addObject:result];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
                    self.photoBtn.backgroundColor = [UIColor clearColor];
                    [self.photoView reloadData];
                });
            }];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 取消图片选择

-(void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获取视频的缩略图

-(UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    return thumbnailImage;
}

#pragma mark - 获取视频的长度

-(NSInteger)durationWithVideo:(NSURL *)videoUrl {
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts];
    NSUInteger second = 0;
    second = urlAsset.duration.value / urlAsset.duration.timescale;//获取视频总时长.单位是秒
    return second;
}

#pragma mark - lazy Loading

- (NSMutableArray *)thumbnailImageArray {
    if (_thumbnailImageArray == nil) {
        _thumbnailImageArray = [NSMutableArray arrayWithCapacity:9];
    }
    return _thumbnailImageArray;
}

-(NSMutableArray *)imgIntroArray {
    if (_imgIntroArray == nil) {
        _imgIntroArray = [NSMutableArray array];
        [_thumbnailImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_imgIntroArray addObject:obj];
        }];
    }
    return _imgIntroArray;
}

#pragma  mark - 屏幕点击事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //点击任何处,回收键盘,搜索框不在View上,不能用self.view只能用window上
    [self.view.window endEditing:YES];
}

#pragma mark - 移除通知

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:@"deleteVideo"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"saveVideoUrl"];
}

- (void)setModel:(BFCommunityModel *)model{
    _model = model;
    _communityType = BFCommunityType_Edit;
    _titleField.text = _model.pTitle;
    _contentField.text = _model.pCcont;
    if (_model.haveVideo) {
        _imgView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_model.pVUrl];
    }
    if (_model.haveImg) {
        for (NSDictionary *dic in _model.postPhotoList) {
            [self.thumbnailImageArray addObject:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:dic[@"pPUrl"]]];
            
        }
        [self.photoView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

