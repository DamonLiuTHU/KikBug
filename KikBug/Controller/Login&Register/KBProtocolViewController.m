//
//  KBProtocolViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/4/25.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBProtocolViewController.h"

@implementation KBProtocolViewController
- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.textField = [UITextView new];
    
    self.textField.text = (NSString*)[[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"property" ofType:@"plist"]] objectForKey:@"Protocol"];
    [self.view addSubview:self.textField];
    [self.textField autoPinEdgesToSuperviewEdges];
}
@end
