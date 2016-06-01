//
//  SendViewController.m
//  SinaTest
//
//  Created by 于苗 on 16/4/26.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "SendViewController.h"
#import "HttpManager.h"

@interface SendViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *topImageView;
@property (retain, nonatomic) IBOutlet UITextField *contentText;

@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)chooseImagebtnClick:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
        
    }
    
    
    
}
- (IBAction)sendBtnClick:(id)sender {
//    这个有值是带图片的
    if (_topImageView.image) {
        
        [HttpManager sendSinaImage:_topImageView.image withContent:_contentText.text withBlock:^(BOOL success) {
            
        }];
        
    }
    else{
        [HttpManager sendSinaInfo:^(BOOL success) {
            
        } withContent:_contentText.text];
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _topImageView.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [_topImageView release];
    [_contentText release];
    [super dealloc];
}
@end
