//
//  DetailsViewController.m
//  SampleCode
//
//  Created by Zebin Yang on 7/20/16.
//  Copyright © 2016 Lucky . All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailsViewController
@synthesize dictHtml = _dictHtml;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Details";
   
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSString *strHTML = [_dictHtml valueForKey:@"Value"];
    //[_webView loadHTMLString:strHTML baseURL:nil];
    
    
    NSString *urlAddress = @"http://yahoo.com";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [_webView loadRequest:requestObj];
    
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

@end
