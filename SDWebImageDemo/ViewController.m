//
//  ViewController.m
//  SDWebImageDemo
//
//  Created by John on 15/11/30.
//  Copyright © 2015年 Mr Tang. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Cache.h"
#import "CacheManager.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *imageArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)didClickRefresh:(UIBarButtonItem *)sender {
     [self loadData];
}
- (IBAction)didClickClear:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"显示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL]];
    
    NSString *string = [NSString stringWithFormat:@"清空缓存大小%llu",[CacheManager cacheBytesCount]];
    
    alert.message = string;
    
    [self presentViewController:alert animated:YES completion:NULL];
    
    [CacheManager clearCache];
    
    imageArray = nil;
    [self.tableView reloadData];

}

- (void)loadData {
    NSString *key = @"http://api.tietuku.com/v2/api/getpiclist?key=aJnHxsVik5mYmpaWxWTImWFvn2aVnMNrmWuXZWaYmJqal8qWlGlqmsOblWmZZ5U=";
    NSURL *url = [NSURL URLWithString:key];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *content = [NSData dataWithContentsOfURL:location];
        id dic = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        imageArray = [dic objectForKey:@"pic"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [task resume];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = [imageArray objectAtIndex:indexPath.row];
    NSString *url = item[@"linkurl"];
    cell.textLabel.text = item[@"name"];
    __weak UITableViewCell *wcell = cell;
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:url] completion:^(BOOL flag) {
        [wcell setNeedsLayout];
    }];
    return cell;
}


@end
