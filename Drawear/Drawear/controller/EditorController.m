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

UIImageViewEx *currTop;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *bg = [UIImage imageNamed:@"/Users/apple/Documents/workspace/Drawear/Drawear/Drawear/Images.xcassets/image/T-shirt.imageset/T-shirt.png"];
    UIImage *image = [UIImage imageNamed:@"/Users/apple/Documents/workspace/Drawear/Drawear/Drawear/Images.xcassets/image/wukong.imageset/wukong.png"];
    UIImage *image2 = [UIImage imageNamed:@"/Users/apple/Documents/workspace/Drawear/Drawear/Drawear/Images.xcassets/image/juhua.imageset/juhua.jpg"];
    
    UIImageViewEx *bgView = [[UIImageViewEx alloc] initWithImage: bg];
    UIImageViewEx *imageView = [[UIImageViewEx alloc] initWithImage: image];
    UIImageViewEx *imageView2 = [[UIImageViewEx alloc] initWithImage: image2];
    
    [bgView setCenter:self.view.center];
    [bgView setContentMode: UIViewContentModeScaleAspectFit];
    [bgView setController: self];
    
    [imageView setCenter:self.view.center];
    [imageView setController: self];
    [imageView enablePan];
    [imageView enableScaleAndRotation];
    [imageView enableDelete];
    
    [imageView2 setCenter:self.view.center];
    [imageView2 setController: self];
    [imageView2 enablePan];
    [imageView2 enableScaleAndRotation];
    [imageView2 enableDelete];
    
    [self.view addSubview:bgView];
    [self.view addSubview:imageView];
    [self.view addSubview:imageView2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setCurrTop: (UIImageViewEx*) view {
    if(currTop != nil){
        [currTop setTop: NO];
    }
    currTop = view;
    [currTop setTop:YES];
}

@end
