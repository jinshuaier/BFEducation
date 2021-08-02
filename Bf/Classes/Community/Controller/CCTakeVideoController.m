//
//  CCTakeVideoController.m
//  基本框架
//
//  Created by 陈大鹰 on 2017/12/1.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "CCTakeVideoController.h"

#define TIMER_INTERVAL 0.05
#define VIDEO_FOLDER @"videoFolder"
#define SHOOT_TIME_LENGTH 60        //视频默认拍摄时间长度, 默认60s

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);
@interface CCTakeVideoController ()<AVCaptureFileOutputRecordingDelegate>//视频文件输出代理
@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设置之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层
@property (strong,nonatomic)  UIView *viewContainer;//视频容器
@property (strong,nonatomic)  UIImageView *focusCursor; //聚焦光标
@property (strong, nonatomic, readwrite) NSString *vedioMergePath;  //最终视频路径
@property float totalTime; //视频总长度 默认60秒(1分钟)
@end

@implementation CCTakeVideoController
{
    NSMutableArray *arrayVideoUrls;            //保存视频片段的数组
    float currentRecordingTimeLength;          //当前视频长度
    NSTimer *timerCount;                       //计时器
    UIView *progressPreView;                   //进度条
    float progressStep;                        //进度条每次变长的最小单位
    float preLayerWidth;                       //镜头宽
    float preLayerHeight;                      //镜头高
    float preLayerHWRate;                      //高，宽比
    UIButton *buttonShoot;                     //录制按钮
    UIButton *buttonFinish;                    //结束按钮
    UIButton *buttonCancel;                    //取消录制按钮
    UIButton *buttonFlash;                     //闪光灯
    UIButton *buttonCamera;                    //切换摄像头
    UIButton *buttonBack;                      //返回按钮
    BOOL isCanceled;                           //是否取消录制
    BOOL isBeginMerge;                         //是否完成录制
    UIView *topView;                           //顶部视图
    UILabel *timeLabel;                        //录制时间
}
@synthesize totalTime;

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //视频最大时长 默认30秒
    if (totalTime==0)
    {
        totalTime = SHOOT_TIME_LENGTH;
    }
    arrayVideoUrls = [[NSMutableArray alloc] init];
    preLayerWidth = KScreenW;
    preLayerHeight = KScreenH;
    preLayerHWRate =preLayerHeight / preLayerWidth;
    //创建视频文件目录
    [self createVideoFolderIfNotExist];
    //初始化拍摄
    [self initUserfaceAndCapture];
}

-(void)initUserfaceAndCapture {
    self.view.backgroundColor = [UIColor whiteColor];
    //视频高度加进度条（10）高度
    self.viewContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, preLayerWidth, preLayerHeight)];
    [self.view addSubview:self.viewContainer];
    //聚焦图片
    self.focusCursor = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.focusCursor setImage:[UIImage imageNamed:@"focusImg"]];
    self.focusCursor.alpha = 0;
    [self.viewContainer addSubview:self.focusCursor];
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset352x288]) {
        //设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset352x288;
    }
    //获得输入设备,取得后置摄像头
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice=[[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    AVCaptureDeviceInput *audioCaptureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:audioCaptureDevice error:&error];
    //初始化设备输出对象，用于获得输出数据
    _captureMovieFileOutput=[[AVCaptureMovieFileOutput alloc]init];
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput])
    {
        [_captureSession addInput:_captureDeviceInput];
        if (audioCaptureDeviceInput == nil) {
            NSLog(@"摄像头获取失败\n请重新检查您的手机");
        }
        else {
            [_captureSession addInput:audioCaptureDeviceInput];
        }
        AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported ])
        {
            captureConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
        }
    }
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
    }
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    CALayer *layer= self.viewContainer.layer;
    layer.masksToBounds=YES;
    _captureVideoPreviewLayer.frame=  CGRectMake(0, 0, preLayerWidth, preLayerHeight);
    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    [layer insertSublayer:_captureVideoPreviewLayer below:self.focusCursor.layer];
    [self addGenstureRecognizer];
    //拍摄按钮
    buttonShoot = [[UIButton alloc] initWithFrame:CGRectMake((KScreenW - 80)/2, KScreenH - 100 - 80, 80, 80)];
    [buttonShoot setImage:[UIImage imageNamed:@"椭圆1拷贝"] forState:UIControlStateNormal];
//    buttonShoot.layer.cornerRadius = 38;
//    buttonShoot.layer.borderWidth = 3;
    [buttonShoot addTarget:self action:@selector(clickButtonShoot:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContainer addSubview:buttonShoot];
    //顶部view
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 50)];
    topView.backgroundColor = [UIColor blackColor];
    topView.userInteractionEnabled = YES;
    topView.alpha = 0.50f;
    //录制时间
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW - 100)/2, 0, 100, 50)];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.viewContainer addSubview:timeLabel];
    //完成拍摄
    buttonFinish = [[UIButton alloc] initWithFrame:CGRectMake(20, KScreenH - 100 - 60, 60, 60)];
    buttonFinish.layer.cornerRadius = 30.0f;
    [buttonFinish setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
    [buttonFinish addTarget:self action:@selector(onClickButtonFinish) forControlEvents:UIControlEventTouchUpInside];
    buttonFinish.hidden = YES;
    [self.viewContainer addSubview:buttonFinish];
    //返回按钮
    buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    buttonBack.frame = CGRectMake(10, 10, 30, 30);
    [buttonBack addTarget:self action:@selector(onClickButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContainer addSubview:buttonBack];
    //闪光灯
    buttonFlash = [[UIButton alloc] initWithFrame:CGRectMake(KScreenW - 10 - 30, 10, 30, 30)];
    [buttonFlash setImage:[UIImage imageNamed:@"on"] forState:UIControlStateNormal];
    [buttonFlash setAlpha:0.30f];
    buttonFlash.layer.cornerRadius = 15;
    [buttonFlash addTarget:self action:@selector(onClickbuttonFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContainer addSubview:buttonFlash];
    CGPoint centerButtonBack = buttonBack.center;
    CGPoint centerButtonFlash = buttonFlash.center;
    centerButtonBack.y = centerButtonFlash.y;
    buttonBack.center = centerButtonBack;
    //切换前后摄像头
    buttonCamera = [[UIButton alloc]initWithFrame:CGRectMake(KScreenW- 50, KScreenH - 100 - 50, 30, 30)];
    [buttonCamera setAlpha:0.30f];
    [buttonCamera setBackgroundImage:[UIImage imageNamed:@"翻转相机"] forState:UIControlStateNormal];
    buttonCamera.layer.cornerRadius = 17;
    [buttonCamera addTarget:self action:@selector(onClickButtonCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContainer addSubview:buttonCamera];
}

//切换闪光灯
-(void)onClickbuttonFlash:(id)sender {
    UIButton *t_button = (UIButton *)sender;
    if (t_button.selected == YES) {
        t_button.selected = NO;
        //关闭闪光灯
        [t_button setBackgroundImage:[UIImage imageNamed:@"闪光灯-关"] forState:UIControlStateNormal];
        [self setTorchMode:AVCaptureTorchModeOff];
    }
    else {
        t_button.selected = YES;
        //开启闪光灯
        [t_button setBackgroundImage:[UIImage imageNamed:@"on"] forState:UIControlStateNormal];
        [self setTorchMode:AVCaptureTorchModeOn];
    }
}

#pragma mark 切换前后摄像头
- (void)onClickButtonCamera:(UIButton*)bt {
    AVCaptureDevice *currentDevice=[self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition=[currentDevice position];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition=AVCaptureDevicePositionFront;
    if (currentPosition==AVCaptureDevicePositionUnspecified||currentPosition==AVCaptureDevicePositionFront) {
        toChangePosition=AVCaptureDevicePositionBack;
        buttonFlash.hidden = NO;
    }
    else {
        buttonFlash.hidden = YES;
    }
    toChangeDevice=[self getCameraDeviceWithPosition:toChangePosition];
    //获得要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:toChangeDevice error:nil];
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput=toChangeDeviceInput;
    }
    //提交会话配置
    [self.captureSession commitConfiguration];
    //关闭闪光灯
    buttonFlash.selected = NO;
    [buttonFlash setBackgroundImage:[UIImage imageNamed:@"闪光灯-关"] forState:UIControlStateNormal];
    [self setTorchMode:AVCaptureTorchModeOff];
    
}

//开始计时
-(void)startTimer {
    [buttonShoot setImage:[UIImage imageNamed:@"矩形1"] forState:UIControlStateNormal];
    timerCount = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [timerCount fire];
}

//停止计时
-(void)stopTimer
{
    [buttonShoot setImage:[UIImage imageNamed:@"椭圆1拷贝"] forState:UIControlStateNormal];
    
    if (timerCount)
    {
        [timerCount invalidate];
        timerCount = nil;
    }
}

- (void)onTimer:(NSTimer *)timer
{
    currentRecordingTimeLength += TIMER_INTERVAL;
    float progressWidth = progressPreView.frame.size.width+progressStep;
    CGRect rectProgressPreView = progressPreView.frame;
    rectProgressPreView.size.width = progressWidth;
    progressPreView.frame = rectProgressPreView;
    if (currentRecordingTimeLength > 2)
    {
        buttonFinish.hidden = NO;
        buttonCancel.hidden = NO;
    }
    
    //时间到了停止录制视频
    if (currentRecordingTimeLength >= totalTime)
    {
        [timerCount invalidate];
        timerCount = nil;
        [_captureMovieFileOutput stopRecording];
        [self mergeAndExportVideosAtFileURLs:arrayVideoUrls];
        //录制完成,停止计时
        [self stopTimer];

        //如果正在拍摄,那么首先停止
        if (_captureMovieFileOutput.isRecording)
        {
            [_captureMovieFileOutput stopRecording];
        }
        else
        {
            [self mergeAndExportVideosAtFileURLs:arrayVideoUrls];
        }
    }
    
    //将录制时间显示在topview上
    int time = currentRecordingTimeLength;
    int minute = time / 60;
    NSString *minute_str = nil;
    if (minute < 10)
    {
        minute_str = [NSString stringWithFormat:@"0%d", minute];
    }
    else
    {
        minute_str = [NSString stringWithFormat:@"%d", minute];
    }
    
    int second = time % 60;
    NSString *second_str = nil;
    if (second < 10)
    {
        second_str = [NSString stringWithFormat:@"0%d", second];
    }
    else
    {
        second_str = [NSString stringWithFormat:@"%d", second];
    }
    timeLabel.text = [NSString stringWithFormat:@"%@:%@", minute_str, second_str];
//    [buttonShoot setTitle: forState:UIControlStateNormal];
}

#pragma mark 视频录制按钮单击事件
- (void)clickButtonShoot:(id)sender {
    if (currentRecordingTimeLength > self.totalTime)
    {
        NSLog(@"没有录制退出...");
        return;
    }
    NSLog(@"开始录制...");
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection=[self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //根据连接取得设备输出的数据
    if (![self.captureMovieFileOutput isRecording])
    {
        NSLog(@"没有正在录制...");
        if (captureConnection == nil) {
            NSLog(@"没有权限...");
            NSLog(@"请前往设置中开启相机权限");
        }
        else {
            NSLog(@"开始录制...");
            
            //预览图层和视频方向保持一致
            captureConnection.videoOrientation=[self.captureVideoPreviewLayer connection].videoOrientation;
            NSLog(@"视频保存路径:%@",[self getVideoSaveFilePathString]);
            [self.captureMovieFileOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:[self getVideoSaveFilePathString]] recordingDelegate:self];
            NSLog(@"开始录制2...");
        }
    }
    else
    {
        NSLog(@"正在录制...");
        [buttonShoot setImage:[UIImage imageNamed:@"矩形1"] forState:UIControlStateNormal];
        [self stopTimer];
        [self.captureMovieFileOutput stopRecording];//停止录制
    }
}

#pragma mark 取消录制
- (void)onClickButtonCancel:(id)sender
{
    [self cancelShoot];
}

#pragma mark 录制完成
-(void)onClickButtonFinish
{
    if (isBeginMerge)
    {
        return;
    }
    
    isBeginMerge = YES;
    //录制完成,停止计时
    [self stopTimer];
    
    //如果正在拍摄,那么首先停止
    if (_captureMovieFileOutput.isRecording)
    {
        [_captureMovieFileOutput stopRecording];
    }
    else
    {
        [self mergeAndExportVideosAtFileURLs:arrayVideoUrls];
    }
}

//点击返回按钮
- (void)onClickButtonBack
{
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

//页面显示出来启动视频session
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.captureSession startRunning];
}

//点击返回按钮,当页面消失的时候,停止视频session
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [buttonShoot setImage:[UIImage imageNamed:@"椭圆1拷贝"] forState:UIControlStateNormal];
    
    
    //pop界面,停止计时
    [self stopTimer];
    
    //停止视频session
    [self.captureSession stopRunning];
    
    //当前录制长度置为0
    currentRecordingTimeLength = 0.0f;
    
    //进度条长度归0
    CGRect rect = progressPreView.frame;
    rect.size = CGSizeMake(0, 4);
    progressPreView.frame = rect;
    
    //删除数据
    [self deleteAllVideos];
    
    //开始进行视频合成
    isBeginMerge = NO;
    
    buttonCancel.hidden = YES;
    buttonFinish.hidden = YES;
    
}

#pragma mark - 视频输出代理
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    NSLog(@"开始录制-------...");
    NSString *filepath = [fileURL path];
    //录制开始, 开始计时
    [self startTimer];
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    NSString *filepath = [outputFileURL path];
    [arrayVideoUrls addObject:outputFileURL];
    //达到最大拍摄时间
    if ((currentRecordingTimeLength > totalTime) || isBeginMerge)
    {
        //如果录制自动到达最大时间,停止计时,然后自动合成视频
        //录制完成,停止计时
        [self stopTimer];
        
        //如果正在拍摄,那么首先停止
        if (_captureMovieFileOutput.isRecording)
        {
            [_captureMovieFileOutput stopRecording];
        }
        else
        {
            [self mergeAndExportVideosAtFileURLs:arrayVideoUrls];
        }
        
        if (isBeginMerge)
        {
            isBeginMerge = NO;
        }
    }
}

- (void)mergeAndExportVideosAtFileURLs:(NSMutableArray *)fileURLArray
{
    NSError *error = nil;
    //渲染尺寸
    CGSize renderSize = CGSizeMake(0, 0);
    NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
    //用来合成视频
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    CMTime totalDuration = kCMTimeZero;
    //先取assetTrack 也为了取renderSize
    NSMutableArray *assetTrackArray = [[NSMutableArray alloc] init];
    NSMutableArray *assetArray = [[NSMutableArray alloc] init];
    
    for (NSURL *fileURL in fileURLArray)
    {
        //AVAsset：素材库里的素材
        AVAsset *asset = [AVAsset assetWithURL:fileURL];
        if (!asset) {
            continue;
        }
        [assetArray addObject:asset];
        //素材的轨道
        NSArray* tmpAry =[asset tracksWithMediaType:AVMediaTypeVideo];//返回一个数组AVAssetTracks资产
        if (tmpAry.count>0)
        {
            AVAssetTrack *assetTrack = [tmpAry objectAtIndex:0];
            [assetTrackArray addObject:assetTrack];
            renderSize.width = MAX(renderSize.width, assetTrack.naturalSize.height);
            renderSize.height = MAX(renderSize.height, assetTrack.naturalSize.width);
        }
    }
    
    //CGFloat renderW = MIN(renderSize.width, renderSize.height);
    CGFloat renderW = 320;
    
    for (int i = 0; i < [assetArray count] && i < [assetTrackArray count]; i++)
    {
        AVAsset *asset = [assetArray objectAtIndex:i];
        AVAssetTrack *assetTrack = [assetTrackArray objectAtIndex:i];
        //文件中的音频轨道，里面可以插入各种对应的素材
        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        NSArray*dataSourceArray= [asset tracksWithMediaType:AVMediaTypeAudio];//获取声道，即麦克风相关信息
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:([dataSourceArray count]>0)?[dataSourceArray objectAtIndex:0]:nil
                             atTime:totalDuration
                              error:nil];
        //工程文件中的轨道，有音频轨，里面可以插入各种对应的素材
        AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:assetTrack
                             atTime:totalDuration
                              error:&error];
        //视频轨道中的一个视频，可以缩放、旋转等
        AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        totalDuration = CMTimeAdd(totalDuration, asset.duration);
        
        CGFloat rate;
        rate = renderW / MIN(assetTrack.naturalSize.width, assetTrack.naturalSize.height);
        
        CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a, assetTrack.preferredTransform.b, assetTrack.preferredTransform.c, assetTrack.preferredTransform.d, assetTrack.preferredTransform.tx * rate, assetTrack.preferredTransform.ty * rate);
        //layerTransform = CGAffineTransformConcat(layerTransform, CGAffineTransformMake(1, 0, 0, 1, 0, -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0+preLayerHWRate*(preLayerHeight-preLayerWidth)/2));//向上移动取中部影相
        
        layerTransform = CGAffineTransformConcat(layerTransform, CGAffineTransformMake(1, 0, 0, 1, 0, -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0));//向上移动取中部影相
        
        layerTransform = CGAffineTransformScale(layerTransform, rate, rate);//放缩，解决前后摄像结果大小不对称
        [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
        [layerInstruciton setOpacity:0.0 atTime:totalDuration];
        [layerInstructionArray addObject:layerInstruciton];
    }
    
    NSString *path = self.vedioMergePath;
    NSURL *mergeFileURL = [NSURL fileURLWithPath:path];
    
    AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    
    int videoDurationSeconds = CMTimeGetSeconds(totalDuration);
    if (videoDurationSeconds == 0)
    {
        totalDuration = CMTimeMakeWithSeconds(180.00f, 30);
        NSLog(@"此刻videoDurationSeconds的值为 %d",videoDurationSeconds);
        videoDurationSeconds = CMTimeGetSeconds(totalDuration);
    }
    else
    {
        
    }
    NSLog(@"现在videoDurationSeconds的值为 %d",videoDurationSeconds);
    mainInstruciton.timeRange = CMTimeRangeMake(kCMTimeZero, totalDuration);
    mainInstruciton.layerInstructions = layerInstructionArray;
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.instructions = @[mainInstruciton];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);// 设置最大，最小帧速率
    mainCompositionInst.renderSize = CGSizeMake(renderW, renderW * 0.75);//4:3比列
    mainCompositionInst.renderScale = 1.0;//清晰度 越高越清晰
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
    exporter.videoComposition = mainCompositionInst;
    exporter.outputURL = mergeFileURL;
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //将视频保存到本地(异步线程)
            NSString *videoPathLocal = self.videoPath;
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:videoPathLocal] completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    NSLog(@"save video failed :%@",error);
                }
                else {
                    NSLog(@"save video success");
                }
            }];
            NSDictionary *dict = @{@"videoPath":videoPathLocal};
            //视频录制完成.发送通知返回到上一个页面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"saveVideoUrl" object:@{@"videoPath":videoPathLocal}];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

//设置并获取最后合成为mp4
- (NSString *)vedioMergePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileAbPath = [[path stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@"merge.mp4"];
    
    self.videoPath = fileAbPath;
    
    return fileAbPath;
}

//设置视频录制的文件路径，并获取该路径，格式为mov
- (NSString *)getVideoSaveFilePathString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[path stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@".mov"];
    
    return fileName;
}

//创建保存录制的视频的目录
- (void)createVideoFolderIfNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建保存视频文件夹失败");
        }
    }
}

//删除所有的录制的视频段
- (void)deleteAllVideos
{
    for (NSURL *videoFileURL in arrayVideoUrls)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *filePath = [[videoFileURL absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath]) {
                NSError *error = nil;
                [fileManager removeItemAtPath:filePath error:&error];
                
                if (error) {
                    NSLog(@"delete All Video 删除视频文件出错:%@", error);
                }
            }
        });
    }
    
    [arrayVideoUrls removeAllObjects];
}

- (void)cancelShoot
{
    //重置录制按钮
    [buttonShoot setImage:[UIImage imageNamed:@"椭圆1拷贝"] forState:UIControlStateNormal];
    
    //timer停止计时
    if (timerCount)
    {
        [self stopTimer];
    }
    
    //停止录制
    if ([_captureMovieFileOutput isRecording])
    {
        [_captureMovieFileOutput stopRecording];
    }
    
    //当前录制时间长置为0
    currentRecordingTimeLength = 0.0f;
    
    //进度条长度归0
    CGRect rect = progressPreView.frame;
    rect.size = CGSizeMake(0, 4);
    progressPreView.frame = rect;
    
    //删除视频数据,以及存放视频地址的数组的内容
    [self deleteAllVideos];
    
    buttonCancel.hidden = YES;
    buttonFinish.hidden = YES;
}

#pragma mark - 私有方法
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position
{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras)
    {
        if ([camera position]==position)
        {
            return camera;
        }
    }
    return nil;
}

-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange
{
    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error])
    {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }
    else
    {
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

-(void)setTorchMode:(AVCaptureTorchMode )torchMode
{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice)
     {
         if ([captureDevice isTorchModeSupported:torchMode])
         {
             [captureDevice setTorchMode:torchMode];
         }
     }];
}

-(void)setFocusMode:(AVCaptureFocusMode )focusMode
{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice)
     {
         if ([captureDevice isFocusModeSupported:focusMode])
         {
             [captureDevice setFocusMode:focusMode];
         }
     }];
}

-(void)setExposureMode:(AVCaptureExposureMode)exposureMode
{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice)
     {
         if ([captureDevice isExposureModeSupported:exposureMode])
         {
             [captureDevice setExposureMode:exposureMode];
         }
     }];
}

-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point
{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice)
     {
         if ([captureDevice isFocusModeSupported:focusMode])
         {
             [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
         }
         if ([captureDevice isFocusPointOfInterestSupported])
         {
             [captureDevice setFocusPointOfInterest:point];
         }
         if ([captureDevice isExposureModeSupported:exposureMode])
         {
             [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
         }
         if ([captureDevice isExposurePointOfInterestSupported])
         {
             [captureDevice setExposurePointOfInterest:point];
         }
     }];
}

-(void)addGenstureRecognizer
{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapScreen:)];
    [self.viewContainer addGestureRecognizer:tapGesture];
}

-(void)onTapScreen:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point= [tapGesture locationInView:self.viewContainer];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint= [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

-(void)setFocusCursorWithPoint:(CGPoint)point
{
    self.focusCursor.center=point;
    self.focusCursor.transform=CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursor.alpha=1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursor.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        self.focusCursor.alpha=0;
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
