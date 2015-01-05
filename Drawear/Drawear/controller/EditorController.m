//
//  EditorController.m
//  Drawear
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "EditorController.h"
#import "UIImageViewEx.h"

@interface EditorController (){
    
}

@end

@implementation EditorController

@synthesize drawBoard;

UIImageViewEx *currTop;
UIImageViewEx *background;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: adjust draw board frame
    [self initDrawBoard];

    // add sample images
    [self addImageByPath:@"wukong.png"];
    [self addImageByPath:@"juhua.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)initDrawBoard {
    // init draw board
    drawBoard = [[UIView alloc] initWithFrame:[self.view frame]];
    // init default background
//    background = [[UIImageViewEx alloc] initWithImage:[UIImage imageNamed:@"T-shirt.png"]];
    background = [[UIImageViewEx alloc] init];
    [background setFrame:drawBoard.frame];
    [background setCenter:self.view.center];
    [background setContentMode: UIViewContentModeScaleAspectFit];
    [background setController: self];
    [background enableTapAsBackground];
    
    [self setBackgroundByPath: @"T-shirt.png"];
    
    [drawBoard addSubview:background];
    
    [self.view addSubview:drawBoard];
}

- (void)setCurrTop: (UIImageViewEx*) view {
    if (view == nil) {
        currTop = nil;
    }
    if(currTop != nil){
        [currTop setTop: NO];
    }
    currTop = view;
    [drawBoard bringSubviewToFront:currTop];
    [currTop setTop:YES];
}

- (void)addImageByView: (UIImageViewEx *) view {
    [view setCenter:self.view.center];
    [view setController: self];
    [view enablePan];
    [view enableScaleAndRotation];
    [view enableDelete];
    
    [drawBoard addSubview:view];
}

- (void)addImageByImage: (UIImage *) image {
    UIImageViewEx *imageView = [[UIImageViewEx alloc] initWithImage: image];
    [self addImageByView:imageView];
}

- (void)addImageByPath: (NSString *) path {
    UIImage *image = [UIImage imageNamed:path];
    UIImageViewEx *imageView = [[UIImageViewEx alloc] initWithImage: image];
    [self addImageByView:imageView];
}

- (void)setBackgroundByImage: (UIImage *) image {
    [background setImage:image];
}

- (void)setBackgroundByPath: (NSString *) path {
    UIImage *image = [UIImage imageNamed:path];
    [background setImage:image];
}

- (void)tapBackground
{
    if(currTop != nil){
        [currTop setTop: NO];
        currTop = nil;
    }
}

@end
