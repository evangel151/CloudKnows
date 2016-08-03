//
//  UIViewController+Extension.m
//  CloudKnows
//
//  Created by  a on 16/8/4.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)


- (void)pushWebViewWithUrl:(NSString *)url {
    UIViewController *vc    = [[UIViewController alloc] init];
    UIWebView *webView      = [[UIWebView alloc] initWithFrame:vc.view.bounds];
    webView.backgroundColor = [UIColor grayColor];
    [vc.view addSubview:webView];
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:vc
                                         animated:YES];
    
}

@end
