//
//  FirstViewController.h
//  SQLite Demo
//
//  Created by Suniket Wagh on 05/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
{

     IBOutlet UIButton *findContactButton;
     IBOutlet UIButton *addContactButton;
}
@property(strong, nonatomic)IBOutlet UIButton *findContactButton;

@property (strong, nonatomic) IBOutlet UIButton *addContactButton;
- (IBAction)addContactButton:(id)sender;
- (IBAction)onClickFindButton:(id)sender;

@end
