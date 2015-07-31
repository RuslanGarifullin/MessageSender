//
//  VKAuthViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 27.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "VKAuthViewController.h"
#import "ViewController.h"
#import "TANavigationBar.h"
#import "AppDelegate.h"


@interface VKAuthViewController () <UIWebViewDelegate, TANavigationBarDelegate>

@property (nonatomic, strong) TANavigationBar *navBar;

@end

@implementation VKAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Удаление cookie
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    self.navBar = [[TANavigationBar alloc] initWithType:TANavigationBarTypeDefault andTitle:@"Вконтакте"];
    [self.navBar setDelegate:self];
    [self.view addSubview: self.navBar.view];
    
    self.vkAuthWebView.delegate = self;
    [self.vkAuthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://oauth.vk.com/authorize?client_id=4877262&scope=friends,offline,messages&redirect_uri=oauth.vk.com/blank.html&display=touch&response_type=token"]]];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSMutableDictionary *gotValues = [[NSMutableDictionary alloc] init];
    NSString *currentURL = webView.request.URL.absoluteString;
    NSLog(@"%@", currentURL);
    NSRange textRange = [[currentURL lowercaseString] rangeOfString:[@"access_token" lowercaseString]];
    if (textRange.location != NSNotFound) {
        [webView setHidden: YES];
        NSArray *data = [currentURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        [gotValues setObject:[data objectAtIndex:1] forKey:@"access_token"];
        [gotValues setObject:[data objectAtIndex:3] forKey:@"expires_in"];
        [gotValues setObject:[data objectAtIndex:5] forKey:@"user_id"];
        ViewController *viewController = [[ViewController alloc] init];
        [[self navigationController] pushViewController:viewController animated:YES];
    } else {
        NSRange textRange = [[currentURL lowercaseString] rangeOfString:@"error"];
        if(textRange.location != NSNotFound) {
            [webView setHidden: YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    

    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertController *someAlertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Проверьте интернет соединение" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [someAlertController addAction:action];
    [self presentViewController:someAlertController animated:YES completion:nil];
}

- (IBAction)backButtonClick:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - TANavigationBarDelegate
- (void) navigationBar:(TANavigationBar *)navBar backButtonClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
