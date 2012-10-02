//
//  Stage2View.m
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Stage2View.h"

@implementation Stage2View

@synthesize delegate = _delegate;

#pragma mark - Private Method

- (void)hideTitle {
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	//[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	imageViewStageTitle.alpha = 0.0;
	
	[UIView commitAnimations];
    
}

#pragma mark - Actions

- (IBAction)next:(id)sender {
    [self.delegate nextStage2:self];
    NSLog(@"next");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor]; 
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    imageViewStageTitle = [[UIImageView alloc] initWithFrame:rect];
    imageViewStageTitle.image = [UIImage imageNamed:@"title_stage1.png"];
    
    [self.view addSubview:imageViewStageTitle];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self performSelector:@selector(hideTitle) withObject:nil afterDelay:1.0];
    
}

- (void)viewDidUnload
{
    [imageViewMaru1 release];
    imageViewMaru1 = nil;
    [imageViewMaru2 release];
    imageViewMaru2 = nil;
    [imageViewMaru3 release];
    imageViewMaru3 = nil;
    [imageViewBatsu1 release];
    imageViewBatsu1 = nil;
    [imageViewBatsu2 release];
    imageViewBatsu2 = nil;
    [imageViewBatsu3 release];
    imageViewBatsu3 = nil;
    [imageViewIndicator1 release];
    imageViewIndicator1 = nil;
    [imageViewIndicator2 release];
    imageViewIndicator2 = nil;
    [imageViewIndicator3 release];
    imageViewIndicator3 = nil;
    [imageViewIndicator4 release];
    imageViewIndicator4 = nil;
    [imageViewIndicator5 release];
    imageViewIndicator5 = nil;
    [imageViewIndicator6 release];
    imageViewIndicator6 = nil;
    [imageViewIndicator7 release];
    imageViewIndicator7 = nil;
    [imageViewIndicator8 release];
    imageViewIndicator8 = nil;
    [imageViewIndicator9 release];
    imageViewIndicator9 = nil;
    [imageViewIndicator10 release];
    imageViewIndicator10 = nil;
    [imageViewIndicator11 release];
    imageViewIndicator11 = nil;
    [imageViewIndicator12 release];
    imageViewIndicator12 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imageViewMaru1 release];
    [imageViewMaru2 release];
    [imageViewMaru3 release];
    [imageViewBatsu1 release];
    [imageViewBatsu2 release];
    [imageViewBatsu3 release];
    [imageViewIndicator1 release];
    [imageViewIndicator2 release];
    [imageViewIndicator3 release];
    [imageViewIndicator4 release];
    [imageViewIndicator5 release];
    [imageViewIndicator6 release];
    [imageViewIndicator7 release];
    [imageViewIndicator8 release];
    [imageViewIndicator9 release];
    [imageViewIndicator10 release];
    [imageViewIndicator11 release];
    [imageViewIndicator12 release];
    [super dealloc];
}
@end
