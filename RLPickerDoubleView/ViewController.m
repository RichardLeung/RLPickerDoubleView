//
//  ViewController.m
//  RLPickerDoubleView
//
//  Created by 梁原 on 15/3/22.
//  Copyright (c) 2015年 RL. All rights reserved.
//

#import "ViewController.h"
#import "RLPickerDoubleView.h"

@interface ViewController ()

@property(nonatomic,strong)NSArray *arrayProvince;

@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property(nonatomic)NSInteger selectSection;
@property(nonatomic)NSInteger selectRow;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *province;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDefaultData];
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:@"province" ofType:@"json"];
    NSData *data =[[NSData alloc]initWithContentsOfFile:path];
    _arrayProvince =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"%@",_arrayProvince);
}

-(void)initDefaultData{
    self.selectSection =0;
    self.selectRow = 0;
}
- (IBAction)buttonCityClick:(UIButton *)sender {
    __weak ViewController *weakself =self;
    RLPickerDoubleView *doubleView =[[[NSBundle mainBundle]loadNibNamed:@"RLPickerDoubleView" owner:self options:nil]lastObject];
    [doubleView initWithTitle:@"选择开户城市"
                    arrayData:_arrayProvince
                      mainkey:@"name"
                    detailKey:@"sub"
                selectSection:self.selectSection
                    selectRow:self.selectRow
                     callback:^(NSInteger selectSection, NSInteger selectRow) {
                         weakself.selectSection =selectSection;
                         weakself.selectRow =selectRow;
                         
                         weakself.province =[[_arrayProvince objectAtIndex:self.selectSection] objectForKey:@"name"];
                         if (self.selectRow !=0) {
                             weakself.city =[[[[_arrayProvince objectAtIndex:self.selectSection] objectForKey:@"sub"] objectAtIndex:self.selectRow] objectForKey:@"name"];
                         }
                         [weakself.buttonCity setTitle:[NSString stringWithFormat:@"%@ %@",weakself.province,weakself.city] forState:UIControlStateNormal];
                     }];
    [doubleView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
