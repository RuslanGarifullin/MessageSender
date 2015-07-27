//
//  ViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "ViewController.h"
#import "TABirthday.h"
#import "ChangingViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init");
        [self.navigationController setDelegate:self];
        self.birthdaysArray = [[NSMutableArray alloc] init];
        [self.birthdaysArray addObject:[[TABirthday alloc]initWithTitle:@"some name 1"]];
        [self.birthdaysArray addObject:[[TABirthday alloc]initWithTitle:@"some name 2"]];
        [self.birthdaysArray addObject:[[TABirthday alloc]initWithTitle:@"some name 3"]];
    }
    return self;
}


- (IBAction)addNewBirthday:(id)sender
{
    ChangingViewController *changintVC = [[ChangingViewController alloc] initWithBirthdaysArray:self.birthdaysArray  atIndex:(NSInteger)self.birthdaysArray.count];
    [self.navigationController pushViewController:changintVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.birthdayTableView.dataSource = self;
    self.birthdayTableView.delegate = self;
    NSLog(@"some message");
}

- (void)viewWillAppear:(BOOL)animated {
    [self.birthdayTableView reloadData];
}
          
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.birthdaysArray.count == 0) {
        [self.haveNothingNotificationView setHidden:NO];
        [self.birthdayTableView setHidden:YES];
    } else {
        [self.haveNothingNotificationView setHidden:YES];
        [self.birthdayTableView setHidden:NO];
    }
    return self.birthdaysArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"birthday";
    UITableViewCell *cell = [self.birthdayTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    TABirthday *birthday = [self.birthdaysArray objectAtIndex:indexPath.row];
    cell.textLabel.text = birthday.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",birthday.subscribers.count];
    cell.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.f];
    [cell.textLabel setTextColor:[UIColor colorWithRed:0.627f green:0.627f blue:0.627f alpha:1.f]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.birthdayTableView deselectRowAtIndexPath:indexPath animated:YES];
        ChangingViewController *changintVC = [[ChangingViewController alloc] initWithBirthdaysArray:self.birthdaysArray  atIndex:(NSInteger)indexPath.row];
    [self.navigationController pushViewController:changintVC animated:YES];
}




@end
