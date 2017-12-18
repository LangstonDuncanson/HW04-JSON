//
//  ViewController.m
//  introToJSON
//
//  Created by Entec Department on 12/11/17.
//  Copyright © 2017 cop2658.mdc.edu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tempValueLabel;
@property (weak, nonatomic) NSArray * dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateWeather:(UIButton *)sender {
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"ricardo" ofType:@"json"];
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    
    if(error)
    {
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    
    
    self.dataList = (NSArray *)[NSJSONSerialization
                                JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                options:0 error:NULL];
    
}

-(void) parseWeatherJSON:(NSData *) jsonData{
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if (error){
        NSLog(@"Error no data!");
        return;
    }
        
    if ([object isKindOfClass:[NSDictionary class]] ){
        NSDictionary *mainObject = [object valueForKey:@"main"];
        NSDictionary *weatherObject = [object valueForKey:@"weather"][0];
        NSString *textString = [NSString stringWithFormat:@"%@, %@ degrees celsius", weatherObject[@"description"], mainObject[@"temp"]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{self.tempValueLabel.text = textString;});
    }
}










@end
