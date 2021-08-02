//
//  BFCarTalentsViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

//屏幕宽和高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

//字体大小
#define kfont 15

#import "PickerChoiceView.h"
#import "Masonry.h"

@interface PickerChoiceView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *bgV;

@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,strong)UILabel *middleLabel;

@property (nonatomic,strong)UIButton *conpleteBtn;


@property (nonatomic,strong)UIPickerView *pickerV;

@property (nonatomic, strong) UIDatePicker * datePicker;

@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation PickerChoiceView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.array = [NSMutableArray array];
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 260*hScale)];
        self.bgV.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgV];
        
        [self showAnimation];
        
        //取消
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(50);
  
        }];
        
        //中间文字
        self.middleLabel = [UILabel new];
        [self.bgV addSubview:self.middleLabel];
        [self.middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(70);
            make.width.mas_equalTo(KScreenW - 140);
            make.height.mas_equalTo(50);
        }];
//        self.middleLabel.text = @"选择出生日期";
        self.middleLabel.textColor = [UIColor blackColor];
        self.middleLabel.textAlignment = NSTextAlignmentCenter;

        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitleColor:RGBA(0, 122, 255, 1) forState:UIControlStateNormal];
        //完成
        self.conpleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.conpleteBtn];
        [self.conpleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(50);
            
        }];
        self.conpleteBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.conpleteBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.conpleteBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.conpleteBtn setTitleColor:RGBA(0, 122, 255, 1) forState:UIControlStateNormal];
        
        //选择titi
        self.selectLb = [UILabel new];
        [self.bgV addSubview:self.selectLb];
        [self.selectLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.bgV.mas_centerX).offset(0);
            make.centerY.mas_equalTo(self.conpleteBtn.mas_centerY).offset(0);
            
        }];  
        self.selectLb.font = [UIFont systemFontOfSize:kfont];
        self.selectLb.textAlignment = NSTextAlignmentCenter;
        
        //线
        UIView *line = [UIView new];
        [self.bgV addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(0.5);
            
        }];
        line.backgroundColor = RGBA(224, 224, 224, 1);
        
        //选择器
        self.pickerV = [UIPickerView new];
        self.pickerV.hidden = YES;
        [self.bgV addSubview:self.pickerV];
        [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        self.pickerV.delegate = self;
        self.pickerV.dataSource = self;
        
        self.datePicker = [UIDatePicker new];
        self.datePicker.hidden = YES;
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        
        //设置显示格式
        //默认根据手机本地设置显示为中文还是其他语言
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        self.datePicker.locale = locale;
        
        //当前时间创建NSDate
        NSDate *localDate = [NSDate date];
        //在当前时间加上的时间：格里高利历
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        //设置时间
        [offsetComponents setYear:50];
        [offsetComponents setMonth:12];
        [offsetComponents setDay:365];
        [offsetComponents setHour:24];
        [offsetComponents setMinute:60];
        [offsetComponents setSecond:60];
        //设置最大值时间
        NSDate *maxDate = [gregorian dateByAddingComponents:offsetComponents toDate:localDate options:0];
        
        //设置最小值时间
        //那么如何设置倒数的时间呢？你可以通过设置UIDataPicker的倒数时长来做到这点。
        
        
        //设置属性
        //如果设置过去日期不可选 改为localDate 即可
        self.datePicker.minimumDate = localDate;
        self.datePicker.maximumDate = maxDate;
        
        [self.bgV addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        
    }
    return self;
}


-(void)dateChanged:(id)sender{
    
//    UIDatePicker *control = (UIDatePicker*)sender;
//    NSDate* date = control.date;
//    //添加你自己响应代码
//    NSLog(@"dateChanged响应事件：%@",date);
    
    
    
}
- (void)setCustomArr:(NSArray *)customArr{
    
    _customArr = customArr;
    [self.array addObject:customArr];
    
}

- (void)setArrayType:(ARRAYTYPE)arrayType
{
    _arrayType = arrayType;
    self.pickerV.hidden = YES;
    self.datePicker.hidden = YES;
    switch (arrayType) {
          
        case jobStyleArray:
        {
            
        }
            break;
            
            
        case guimoArray:
        {
            self.selectLb.text = @"选择公司规模";
            [self.array removeAllObjects];
            [self.array addObject:@[@"少于15人",@"15-50人",@"50-150人",@"150-500人",@"500-1000人",@"1000人以上"]];
            self.pickerV.hidden = NO;
        }
            break;
            
        case xingzhiArray:
        {
            self.selectLb.text = @"选择公司性质";
            [self.array removeAllObjects];
            [self.array addObject:@[@"民营",@"国有",@"外商独资/办事处",@"中外合资/合作",@"事业单位"]];
            self.pickerV.hidden = NO;
        }
            break;
        
        case quanzhiArray:
        {
            self.selectLb.text = @"选择工作性质";
            [self.array removeAllObjects];
            [self.array addObject:@[@"全职",@"兼职",@"实习"]];
            self.pickerV.hidden = NO;
        }
            break;
            
        case moneyArray:
        {
            self.selectLb.text = @"选择薪资范围";
            [self.array removeAllObjects];
            [self.array addObject:@[@"面议",@"3千以下",@"3千-5千",@"5千-7千",@"7千-1万",@"1万-1.5万",@"1.5万以上"]];
            self.pickerV.hidden = NO;
        }
            break;
            
        case jingyanArray:
        {
            self.selectLb.text = @"选择经验要求";
            [self.array removeAllObjects];
            [self.array addObject:@[@"应届生",@"1-3年",@"3-5年",@"5-10年",@"10年以上"]];
            self.pickerV.hidden = NO;
        }
            break;
            
        case xueliArray:
        {
            self.selectLb.text = @"选择学历要求";
            [self.array removeAllObjects];
            [self.array addObject:@[@"不限",@"中专及以下",@"高中",@"大专",@"本科"]];
            self.pickerV.hidden = NO;
        }
            break;
//
//        case GenderArray:
//        {
//            self.selectLb.text = @"选择性别";
//            [self.array addObject:@[@"男",@"女"]];
//            self.pickerV.hidden = NO;
//        }
//            break;
//        case HeightArray:
//        {
//            self.selectLb.text = @"选择身高";
//            NSMutableArray *arr = [NSMutableArray array];
//            for (int i = 100; i <= 250; i++) {
//
//                NSString *str = [NSString stringWithFormat:@"%d",i];
//                [arr addObject:str];
//            }
//            [self.array addObject:(NSArray *)arr];
//            self.pickerV.hidden = NO;
//        }
//            break;
//        case weightArray:
//        {
//            self.selectLb.text = @"选择体重";
//            NSMutableArray *arr = [NSMutableArray array];
//            for (int i = 30; i <= 200; i++) {
//
//                NSString *str = [NSString stringWithFormat:@"%d",i];
//                [arr addObject:str];
//            }
//            [self.array addObject:(NSArray *)arr];
//            self.pickerV.hidden = NO;
//        }
//            break;
        case Default:
        {
            self.pickerV.hidden = NO;
        }
//            break;
//        case DateYear:
//        {
//
//            self.datePicker.hidden = NO;
//             _datePicker.datePickerMode = UIDatePickerModeDate;
//        }
//            break;
//
        case agoDate:
        {

            self.datePicker.hidden = NO;
            _datePicker.datePickerMode = UIDatePickerModeDate;

            NSDate *localDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy"];
            NSDate *setlocalDate = [dateFormatter dateFromString:@"06-06-2012"];
            self.datePicker.minimumDate = [dateFormatter dateFromString:@"01-01-1971"];
            self.datePicker.maximumDate = localDate;
            [self.datePicker setDate:setlocalDate];
        }
            break;

            
        default:
            break;
    }
}


#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.array.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
 
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    if (self.arrayType == DeteArray) {
        
        return arr.count*100;
        
    }else{
        
        return arr.count;
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return label;
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
    return [arr objectAtIndex:row % arr.count];
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
   
    if (self.arrayType == DeteArray) {
        
        return 60;
        
    }else{
        
        return 200;
    }
    
}

#pragma mark-----点击方法

- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

- (void)completeBtnClick{
    
    NSString *fullStr = [NSString string];
    NSInteger selectIndex = 0;
    if (self.arrayType == agoDate) {
        
        //NSDate格式转换为NSString格式
        NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
        //        [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)   HH:mm:ss"];
        [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
        fullStr = [pickerFormatter stringFromDate:pickerDate];
        
    }else if (self.arrayType == DeteArray) {
        
        //NSDate格式转换为NSString格式
        NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
//        [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)   HH:mm:ss"];
        [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        fullStr = [pickerFormatter stringFromDate:pickerDate];
        
    }else if (self.arrayType == DateYear) {
        //NSDate格式转换为NSString格式
        NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
        //        [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)   HH:mm:ss"];
        [pickerFormatter setDateFormat:@"yyyyMMdd"];
        fullStr = [pickerFormatter stringFromDate:pickerDate];
    }else{
        for (int i = 0; i < self.array.count; i++) {
            NSArray *arr = [self.array objectAtIndex:i];
            NSString *str = [arr objectAtIndex:[self.pickerV selectedRowInComponent:i]];
            fullStr = [fullStr stringByAppendingString:str];
            selectIndex = i;
        }

        
    }
    
    [self.delegate PickerSelectorIndixString:fullStr andIndex:selectIndex];
    
    [self hideAnimation];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}

//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.bgV.frame;
        frame.origin.y = kScreenHeight;
        self.bgV.frame = frame;
        
    } completion:^(BOOL finished) {
        [self.bgV removeFromSuperview];
        [self removeFromSuperview];
    }];
}

//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.1 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = kScreenHeight-260*hScale;
        self.bgV.frame = frame;
    }];
    
}


@end
