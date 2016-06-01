//
//  ViewController.m
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"
#import "MainViewController.h"
@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createView];
}

-(void)createView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[HttpManager getLoginURL]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    [webView release];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    NSRange range= [urlStr rangeOfString:@"code"];
    if (range.location!=NSNotFound) {
        
        NSString *codeStr = [[urlStr componentsSeparatedByString:@"code="] lastObject];
//        下面是要用code值来获取token
        [HttpManager getTokenByCode:codeStr withCompleteBlock:^(BOOL succse) {
//            在这个地方判断一下如果登陆（授权）成功则让他跳进主界面
            if (succse) {
               
            MainViewController *mainVC = [[MainViewController alloc]init];
            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:mainVC];
               UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
                [window setRootViewController:navVC];
                [mainVC release];
                [navVC release];
                
            }
            
            
            NSLog(@"===111==>>>%d",succse);
        }];
        
        
        
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
