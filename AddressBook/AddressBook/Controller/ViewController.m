//
//  ViewController.m
//  AddressBook
//
//  Created by Twinkleo on 16/4/11.
//  Copyright © 2016年 Twinkleo. All rights reserved.
//

#import "ViewController.h"
#import "Tool.h"
#import "PeopleModel.h"
#import "CustomView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView * _tableView;
    NSMutableArray * dataArr;
    NSMutableArray * titleArr;
    UIImageView * image1;
    UIImageView * image2;
    UIImageView * image3;
    CustomView * view1;
    UIView * view;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"544255");
    [self initData];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
   _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    NSLog(@"%@",NSHomeDirectory());
    

   
}

- (void)initData{

    [Tool creatPeople];
     dataArr = @[].mutableCopy;
    titleArr = @[].mutableCopy;
    for (int i = 0; i<2; i++) {
        [titleArr addObject:@"no"];
    }
    
    dataArr = [ Tool selectPeople];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataArr.count;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 100;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    view = [UIView new];

    UIButton * button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 100, 100);
    [button setTitle:@"所有人" forState: UIControlStateNormal ];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(allPeople:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button release];
    
    
    UIButton * button1 = [[UIButton alloc]init];
    button1.frame = CGRectMake(150, 0, 100, 100);
    [button1 setTitle:@"组/群" forState: UIControlStateNormal ];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(zuqun:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button1];
    [button1 release];
    
    UIButton * button2 = [[UIButton alloc]init];
    button2.frame = CGRectMake(300, 0, 100, 100);
    [button2 setTitle:@"新建联系人" forState: UIControlStateNormal ];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(lianxiren:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    [button2 release];

    image1 = [[UIImageView alloc]init];
    image1.image = [UIImage imageNamed:@"TabBarNipple"];
    image1.frame = CGRectMake(45, 60, 10, 10);
    
    [view addSubview:image1];
    
    image2= [[UIImageView alloc]init];
    image2.image = [UIImage imageNamed:@"TabBarNipple"];
    image2.frame = CGRectMake(195, 60, 10, 10);
    image2.hidden = YES;
    [view addSubview:image2];
    
    
     image3 = [[UIImageView alloc]init];
    image3.image = [UIImage imageNamed:@"TabBarNipple"];
    image3.frame = CGRectMake(345, 60, 10, 10);
    image3.hidden = YES;
    
    [view addSubview:image3];
    
    
    return view;
}

- (void)allPeople:(UIButton *)btn{

    image1.hidden = NO;
    image2.hidden = YES;
    image3.hidden = YES;
    [_tableView reloadData];
    

}

- (void)zuqun:(UIButton *)btn{

    image1.hidden = YES;
    image2.hidden = NO;
    image3.hidden = YES;
    
    UIBarButtonItem * b = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(zuqunAdd:)];
    self.navigationItem.rightBarButtonItem = b;
    

}

- (void)zuqunAdd:(UIButton *)btn{



}

- (void)lianxiren:(UIButton *)btn{

    image1.hidden = YES;
    image2.hidden = YES;
    image3.hidden = NO;
    
    view1 = [[CustomView  alloc]initWithFrame:CGRectMake(50, 200, 400, 400)];
                        
    [view release];
    [self.view addSubview:view1];
    
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemSave target:self action:@selector(add:)];
    

  //  barBtn.image = [UIImage imageNamed:@"Completelmage@2x.png"];
    self.navigationItem.rightBarButtonItem = barBtn;
    
   
}

- (void)add:(UIButton *)btn{
    
    PeopleModel * model = [PeopleModel new];
    
    
    if (view1.tf1.text.length>0) {
        model.name = view1.tf1.text;
        model.phone = [view1.tf2.text integerValue];
        NSLog(@"%@",model.name);
        [Tool insertIntoPeopleWithData:model];
    }
    view1.hidden = YES;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        
    }
    
    PeopleModel * model = dataArr[indexPath.row];
    cell.textLabel.text = model.name;

    return cell;
}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];

    self.title = @"通讯录";
    

}

- (void)dealloc{

    _tableView = nil;
    view1 = nil;
    view = nil;
    [super dealloc];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
