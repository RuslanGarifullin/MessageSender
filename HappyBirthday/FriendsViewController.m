//
//  FriendsViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 31.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "FriendsViewController.h"
#import "TANavigationBar.h"
#import "TAFriendVKCell.h"
#import "TAApplicationStorage.h"
#import "TABirthday.h"
#import "TAFriend.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@interface FriendsViewController () <TANavigationBarDelegate, UITableViewDataSource, UITableViewDelegate, TAFriendVKCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet TANavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@property (weak, nonatomic) IBOutlet UIView *darkView;
@property (strong, nonatomic) UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) NSString *searchingText;
@property (strong, nonatomic) NSMutableArray *filteredFriendsArray;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger subscribersCount = [[[[TAApplicationStorage sharedLocator] changingBirthday] subscribers]count];
    
    [self.navBar.backButton setHidden:NO];
    [self.navBar.searchButton setHidden:NO];
    self.navBar.navBarLabel.text = [NSString stringWithFormat:@"Добавлено %ld",subscribersCount];
    [self.navBar setDelegate:self];
    [self.navBar.searchTextField setDelegate:self];

    UINib *nib = [UINib nibWithNibName:@"TAFriendVKCell" bundle:nil];
    [self.friendsTableView registerNib:nib forCellReuseIdentifier:@"TAFriendVKCell"];
    [self.friendsTableView setDataSource:self];
    [self.friendsTableView setDelegate:self];
    
    if ([[[TAApplicationStorage sharedLocator] friendsArray] count] == 0) {
        self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.loadingView.center = self.view.center;
        [self.loadingView startAnimating];
        [self.loadingView setHidden:NO];
        [self.darkView setHidden:NO];
        [self.view addSubview: self.loadingView];
        [self initFriends];
    }
}

- (void)initFriendsDone
{
    [self.loadingView stopAnimating];
    [self.loadingView setHidden:YES];
    [self.darkView setHidden:YES];
    [self.friendsTableView reloadData];
    NSLog(@"friends download is done");
}

- (void)initFriends
{
    NSURLSession *jsonSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [jsonSession dataTaskWithURL:
       [NSURL URLWithString:[NSString stringWithFormat:@"https://api.vk.com/method/friends.get?lang=ru&user_id=%@&fields=bdate,photo_100",[[TAApplicationStorage sharedLocator] userVkId]]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if(error) {
            NSLog(@"%@", error);
        } else {
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *friendsArray = [[TAApplicationStorage sharedLocator] friendsArray];
        if (error) {
            NSLog(@"JSONObjectWithData error: %@", error);
        } else {
        for (NSMutableDictionary *dictionary in [array objectForKey:@"response"]) {
            NSString *firstName = dictionary[@"first_name"];
            NSString *lastName = dictionary[@"last_name"];
            NSUInteger userId = [dictionary[@"user_id"] unsignedIntegerValue];
            NSString *birthDate = dictionary[@"bdate"];
            NSDateComponents *dateComp;
            if (birthDate) {
                dateComp = [NSDateComponents new];
                NSArray *dates = [birthDate componentsSeparatedByString: @"."];
                if (dates.count > 1) {
                    [dateComp setDay:[[dates objectAtIndex:0] intValue] + 1];
                    [dateComp setMonth:[[dates objectAtIndex:1] intValue]];
                }
                if (dates.count > 2) {
                    [dateComp setYear:[[dates objectAtIndex:2] intValue]];
                }
            }
            NSURL *avatarURL =  [NSURL URLWithString:dictionary[@"photo_100"]];
            [friendsArray addObject:[[TAFriend alloc]
                                     initWithName:[NSString stringWithFormat:@"%@ %@",lastName,firstName]
                                     vkId:userId
                                     imgUrl:avatarURL
                                     andBirthDate:dateComp?[[NSCalendar currentCalendar] dateFromComponents:dateComp]:nil]];
        }
        }
        [self performSelectorOnMainThread:@selector(initFriendsDone) withObject:nil waitUntilDone:YES];
        NSLog(@"End with: %ld friends",friendsArray.count);
        }
    }];
    
    [dataTask resume];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *friendsArray = [[TAApplicationStorage sharedLocator] friendsArray];
    self.filteredFriendsArray = [[NSMutableArray alloc] init];
    if (self.searchingText != nil && ![self.searchingText isEqual:@""]) {
        for (NSInteger i = 0; i < friendsArray.count; i++) {
            if ([[[[friendsArray objectAtIndex:i] name] lowercaseString] rangeOfString:[self.searchingText lowercaseString]].location != NSNotFound) {
                [self.filteredFriendsArray addObject: [friendsArray objectAtIndex:i]];
            }
        }

    } else {
        self.filteredFriendsArray = friendsArray;
    }
    return self.filteredFriendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TAFriendVKCell";
    TAFriend *friend = [self.filteredFriendsArray objectAtIndex:indexPath.row];
    TAFriendVKCell *cell = [self.friendsTableView dequeueReusableCellWithIdentifier:identifier];
    cell.delegate = self;
    [cell initWithFriend:friend];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - TAFriendVKCellDelegate
- (void) wasCheckedFriendCell:(TAFriendVKCell*)cell
{
    NSInteger subscribersCount = [[[[TAApplicationStorage sharedLocator] changingBirthday] subscribers]count];
    self.navBar.navBarLabel.text = [NSString stringWithFormat:@"Добавлено %ld",subscribersCount];
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.friendsTableView deselectRowAtIndexPath:indexPath animated:NO];
    //[self.friendsTableView reloadData];
}


#pragma mark - TANavigationBarDelegate
- (void) navigationBar:(TANavigationBar *)navBar backButtonClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) navigationBar:(TANavigationBar *)navBar cancelButtonClicked:(UIButton *)button
{
    self.searchingText = @"";
    [self.friendsTableView reloadData];
    [self.view endEditing:YES];
}

- (void) navigationBar:(TANavigationBar *)navBar searchButtonClicked:(UIButton *)button
{
    [self.navBar.searchTextField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] > 1) {
        return YES;
    }
    self.searchingText = [NSString stringWithFormat:@"%@%@",[textField.text substringToIndex:textField.text.length-range.length],string];
    [self.friendsTableView reloadData];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"textFieldShouldClear");
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    return YES;
}



@end
