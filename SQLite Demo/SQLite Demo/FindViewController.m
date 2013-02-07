//
//  FindViewController.m
//  SQLite Demo
//
//  Created by Suniket Wagh on 06/02/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import "FindViewController.h"
#import "AppDelegate.h"

@interface FindViewController ()

@end

@implementation FindViewController
@synthesize detailLabel;

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

- (IBAction)findAction:(id)sender {
    
    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSString* destPath = [del getDestPath];
    const char *dbpath=[destPath UTF8String ];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", nameTextField.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                //address.text = addressField;
                
                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                //phone.text = phoneField;
                self.detailLabel.text = [NSString stringWithFormat:@"Address is %@ and Contact Number is %@", addressField, phoneField];
               // statusLabel.text = @"Match found";
                
            } 
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([nameTextField isFirstResponder]) {
        [nameTextField resignFirstResponder];
        
    }
   
    return YES;
}
@end
