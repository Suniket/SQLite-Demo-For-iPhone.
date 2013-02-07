//
//  FirstViewController.m
//  SQLite Demo
//
//  Created by Suniket Wagh on 05/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import "FirstViewController.h"
#import "AddOrFindContactViewController.h"
#import "FindViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Add/Find a Contact";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addContactButton:(id)sender {
    
    AddOrFindContactViewController *addOrFindViewController = [[AddOrFindContactViewController alloc] init];
    addOrFindViewController.isAddContact = YES;
    [self.navigationController pushViewController:addOrFindViewController animated:YES];
    
}

- (IBAction)onClickFindButton:(id)sender {
    
    FindViewController *findViewController = [[FindViewController alloc] init];
  //  findViewController.isAddContact = NO;
    [self.navigationController pushViewController:findViewController animated:YES];
    
}
@end
