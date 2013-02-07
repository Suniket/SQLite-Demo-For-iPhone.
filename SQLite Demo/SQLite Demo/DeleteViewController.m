//
//  DeleteViewController.m
//  SQLite Demo
//
//  Created by Suniket Wagh on 07/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import "DeleteViewController.h"
#import "AppDelegate.h"


@interface DeleteViewController ()

@end

@implementation DeleteViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteAction:(id)sender {
    
    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSString* destPath = [del getDestPath];
    
    
    sqlite3 *database;
    if (sqlite3_open([destPath UTF8String], &database)==SQLITE_OK) {
        const char *query="delete from contacts where name=?";
        NSLog(@"%@",[NSString stringWithCString:query encoding:NSASCIIStringEncoding]);
        sqlite3_stmt *queryStatement;
        NSLog(@"database opened");
        if (sqlite3_prepare_v2(database, query, -1, &queryStatement, NULL)==SQLITE_OK) {
           
            NSString *namedoc= nameTextField.text;
            
            sqlite3_bind_text(queryStatement, 1, [namedoc UTF8String], -1, NULL);
            if(sqlite3_step(queryStatement)!=SQLITE_DONE)
            {
                NSLog(@"error");
                statusLabel.text = @"Contact Not Found";
            }
            NSLog(@"prepared deleted");
            statusLabel.text = @"Contact Deleted";
        }
        sqlite3_reset(queryStatement);
    }
    sqlite3_close(database);
    

}
@end
