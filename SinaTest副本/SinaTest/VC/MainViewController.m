//
//  MainViewController.m
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "MainViewController.h"
#import "HttpManager.h"
#import "MainCell.h"
#import "StatusesModel.h"
#import "UserModel.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SendViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray = [NSMutableArray array];
    self.title = @"新浪微博主界面";
    /*[HttpManager getFriendInfo:^(NSArray *array) {
        [_dataArray addObjectsFromArray:array];
        [_myTableView reloadData];
        NSLog(@"===主界面的array===>>>%ld",array.count);
    }];*/
    
    [_myTableView registerNib:[UINib nibWithNibName:@"MainCell" bundle:nil] forCellReuseIdentifier:@"cell"];
   
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"写微博" style:UIBarButtonItemStylePlain target:self action:@selector(goToWriteVC)] autorelease];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"这个是block块中的输出");
        
//      在这个地方去重新请求一下数据
//        这种情况是已经有微博了需要继续去请求最新的微博
        if (_dataArray.count>0) {
           
            StatusesModel *obj = [_dataArray firstObject];
            [HttpManager getFriendInfo:^(NSArray *array) {
                
                if (array.count>0) {
                    
                    NSRange range = NSMakeRange(0, array.count);
                    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
                    [_dataArray insertObjects:array atIndexes:set];
                    [_myTableView reloadData];
                }
                
                
                
                //        把刷新停掉
                [_myTableView.mj_header endRefreshing];
            } withSinceID:obj.idStr];
            
        }
        else {//这种情况是第一次进来刷微博
            [HttpManager getFriendInfo:^(NSArray *array) {
                
                if (array.count>0) {
                   [_dataArray addObjectsFromArray:array];
                    [_myTableView reloadData];
                }
                
                
                
                //        把刷新停掉
                [_myTableView.mj_header endRefreshing];
            } withSinceID:@"0"];
        }
        
        
        
    }];
    //    这个是开始刷新
    [_myTableView.mj_header beginRefreshing];
}
-(void)goToWriteVC{
    
    SendViewController *sendVC = [[SendViewController alloc]init];
    [self.navigationController pushViewController:sendVC animated:YES];
    [sendVC release];
}
#pragma mark- tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    StatusesModel *obj = _dataArray[indexPath.row];
    cell.nameLabel.text = obj.userObj.name;
    cell.contentLabel.text = obj.text;
    cell.contentLabel.numberOfLines=0;
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:obj.userObj.profile_image_url]];
    [cell.sourceBtn setTitle:obj.sourceObj.sourceString forState:UIControlStateNormal];
    cell.sourceBtn.tag = indexPath.row;
    [cell.sourceBtn addTarget:self action:@selector(goToSourceVC:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 250;
}

-(void)goToSourceVC:(UIButton *)btn{
    
    StatusesModel *obj = _dataArray[btn.tag];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:obj.sourceObj.href]];
    
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

- (void)dealloc {
    [_myTableView release];
    [super dealloc];
}
@end
