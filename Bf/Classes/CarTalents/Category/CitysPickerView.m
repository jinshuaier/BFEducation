//
//  BFCarTalentsViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "CitysPickerView.h"

@interface CitysPickerView ()
@property (nonatomic, copy) NSDictionary * citysDic;
@property (nonatomic, copy) NSArray * provincesArray;
@property (nonatomic, copy) NSArray * citysArray;
@property (nonatomic, copy) NSArray * districtsArray;

@property (nonatomic, copy) UIPickerView * citysPickerView;

@property (nonatomic, copy) NSString * selectedProvince;
@property (nonatomic, copy) UIView * groundView;

@end

@implementation CitysPickerView

-(instancetype)initWithFrame:(CGRect)frame pickerStyle:(CitysPickerStyle)style;
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setCityspickerStyle:style];
        [self data];
        [self creatPickerView];
        [self.delegate selectCityString:@""];
    }
    return self;
}

-(void)setCityspickerStyle:(CitysPickerStyle)cityspickerStyle
{
    _cityspickerStyle = cityspickerStyle;
}

-(void)data
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    _citysDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    NSArray *components = [_citysDic allKeys];
    NSArray *sortedArray = [components
                            sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[_citysDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    _provincesArray = [NSArray arrayWithArray:provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [_provincesArray objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:
                         [[_citysDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary:
                             [dic objectForKey: [cityArray objectAtIndex:0]]];
    
    _citysArray = [NSArray arrayWithArray:[cityDic allKeys]];
    
    
    NSString *selectedCity = [_citysArray objectAtIndex: 0];
    _districtsArray = [NSArray arrayWithArray:
                       [cityDic objectForKey:selectedCity]];
    
    _selectedProvince = [_provincesArray objectAtIndex: 0];
}

-(void)creatPickerView
{
    _groundView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenH - 230, KScreenW, 230)];
    self.groundView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self addSubview:_groundView];
    
    UIView * lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 0.5)];
    lineTop.backgroundColor = [UIColor lightGrayColor];
    [_groundView addSubview:lineTop];
    
//    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.frame = CGRectMake(10, 10, 40, 30);
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [cancelButton setTitleColor:ColorRGBValue(0x359acc) forState:UIControlStateNormal];
//    [_groundView addSubview:cancelButton];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(KScreenW - 50, 0.5, 40, 29);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureButton setTitleColor:ColorRGBValue(0x359acc) forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_groundView addSubview:sureButton];
    
    UIView * lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, KScreenW, 0.5)];
    lineBottom.backgroundColor = [UIColor lightGrayColor];
    [_groundView addSubview:lineBottom];
    
    CGRect pickerRect = CGRectMake(0, _groundView.height - 200, KScreenW, 200);
    _citysPickerView = [[UIPickerView alloc] initWithFrame:pickerRect];
    _citysPickerView.backgroundColor = [UIColor whiteColor];
    _citysPickerView.dataSource = self;
    _citysPickerView.delegate = self;
    _citysPickerView.showsSelectionIndicator = YES;
    [_citysPickerView selectRow: 0 inComponent: 0 animated: YES];
    [_groundView addSubview: _citysPickerView];
    [self showAnimation];
    
}

-(void)sureButtonAction
{
    [self selectActionString];
    [self hideAnimation];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}

//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.groundView.frame;
        frame.origin.y = KScreenH;
        self.groundView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self.groundView removeFromSuperview];
        [self removeFromSuperview];
        self.citysPickerView = nil;
        
    }];
    
}

//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.groundView.frame;
        frame.origin.y = KScreenH-230;
        self.groundView.frame = frame;
    }];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_cityspickerStyle == kCitysPickerStyleDefault) {
        return 3;
    }else if (_cityspickerStyle == kCitysPickerStyleProAndCt || _cityspickerStyle == kCitysPickerStyleSetting) {
        return 2;
    }else if (_cityspickerStyle == kCitysPickerStyleProBack) {
        return 1;
    }
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [_provincesArray count];
    }
    else if (component == 1) {
        return [_citysArray count];
    }
    else {
        return [_districtsArray count];
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_provincesArray objectAtIndex: row];
    }
    else if (component == 1) {
        return [_citysArray objectAtIndex: row];
    }
    else {
        return [_districtsArray objectAtIndex: row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _selectedProvince = [_provincesArray objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_citysDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: _selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray * sortedArray = [NSArray array];
        if (cityArray.count > 1) {
            sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;//递减
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;//上升
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
        }else {
            sortedArray = cityArray;
        }
        
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        _citysArray = array;
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        _districtsArray = [cityDic objectForKey: [_citysArray objectAtIndex: 0]];
        if (_cityspickerStyle != kCitysPickerStyleProBack) {
            [_citysPickerView reloadComponent: 1];
            [_citysPickerView selectRow: 0 inComponent: 1 animated: YES];
        }
        
        
    }
    else if (component == 1) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[_provincesArray indexOfObject: _selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_citysDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: _selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [NSArray array];
        if (dicKeyArray.count > 1) {
            sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
        }else {
            sortedArray = dicKeyArray;
        }
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        _districtsArray = [cityDic objectForKey: [cityKeyArray objectAtIndex:0]];
//        [_citysPickerView reloadComponent: 2];
//        [_citysPickerView selectRow: 0 inComponent: 2 animated: YES];
    }
    
    if (_cityspickerStyle == kCitysPickerStyleDefault) {
        [_citysPickerView reloadComponent: 2];
        [_citysPickerView selectRow: 0 inComponent: 2 animated: YES];
    }else {
    }
    if (_cityspickerStyle != kCitysPickerStyleSetting) {
        [self selectActionString];
    }
    
}

-(void)selectActionString
{
    NSInteger provinceIndex = [_citysPickerView selectedRowInComponent: 0];
    NSInteger cityIndex;
    if (_cityspickerStyle != kCitysPickerStyleProBack) {
        cityIndex = [_citysPickerView selectedRowInComponent: 1];
    }else {
        cityIndex = 0;
    }
    
    NSInteger districtIndex;
    
    if (_cityspickerStyle == kCitysPickerStyleDefault) {
        districtIndex = [_citysPickerView selectedRowInComponent: 2];
    }else {
        districtIndex = 0;
    }
    
    
    NSString *provinceStr = [NSString stringWithFormat:@"%@ ",[_provincesArray objectAtIndex: provinceIndex]];
    NSString *cityStr = [_citysArray objectAtIndex: cityIndex];
    NSString *districtStr = [NSString stringWithFormat:@" %@",[_districtsArray objectAtIndex:districtIndex]];
    
    if (_cityspickerStyle == kCitysPickerStyleProBack) {
        NSString * addressDetail = [NSString stringWithFormat: @"%@", [provinceStr stringByReplacingOccurrencesOfString:@" " withString:@""]];
        [self.delegate selectCityString:addressDetail];
        return;
    }
    
    if ([[provinceStr stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString: cityStr]) {
        provinceStr = @"";
    }
    else if ([cityStr isEqualToString: [districtStr stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
        districtStr = @"";
    }
    
    if (_cityspickerStyle == kCitysPickerStyleDefault) {
        NSString * addressDetail = [NSString stringWithFormat: @"%@%@%@", provinceStr, cityStr, districtStr];
        [self.delegate selectCityString:addressDetail];
    }else if (_cityspickerStyle == kCitysPickerStyleSetting) {
        NSString * addressDetail = [NSString stringWithFormat: @"%@%@",provinceStr,cityStr];
        [self.delegate selectCityString:addressDetail];
    }else {
        NSString * addressDetail = [NSString stringWithFormat: @"%@", cityStr];
        [self.delegate selectCityString:addressDetail];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 80;
    }
    else if (component == 1) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_provincesArray objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == 1) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_citysArray objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_districtsArray objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
