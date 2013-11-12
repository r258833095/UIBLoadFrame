//
//  UIBLoadFrame.m
//  UIBLoadFrame
//
//  Created by 斌 on 13-11-10.
//  Copyright (c) 2013年 斌. All rights reserved.
//

#import "UIBLoadFrame.h"

@implementation UIBLoadFrame
static UILabel *txtLoad;
static UIImageView *imgLoadBg;
static UIActivityIndicatorView *activity;
- (id)init{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(operation:) name:@"loadFrame" object:nil];
        
        self.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
        self.frame = [[UIScreen mainScreen] bounds];
        
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        imgLoadBg=[[UIImageView alloc]initWithFrame:CGRectMake(screenWidth/2-43, screenHeight/2-43, 86, 86)];
        imgLoadBg.image = [self getImageWithImageName:@"load_bg.tiff"];
        [self addSubview:imgLoadBg];
        
        activity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activity setCenter:CGPointMake(imgLoadBg.frame.size.width/2,imgLoadBg.frame.size.height/2-10)];
        [activity startAnimating];
        [imgLoadBg addSubview:activity];
        
        txtLoad=[[UILabel alloc]initWithFrame:CGRectMake(0,86-25,86,20)];
        txtLoad.text=@"请 稍 等...";
        txtLoad.font=[UIFont systemFontOfSize:14];
        txtLoad.textAlignment=NSTextAlignmentCenter;
        txtLoad.backgroundColor=[UIColor clearColor];
        txtLoad.textColor=[UIColor whiteColor];
        [imgLoadBg addSubview:txtLoad];
        
        self.alpha = 0;
    }
    return self;
}

-(void)operation:(NSNotification *)notification{
    [UIView animateWithDuration:0.3 animations:^(void){
        if ([[notification object]isEqual:@"show"]) {
            [activity setHidden:NO];    [txtLoad setHidden:NO];
            imgLoadBg.image = [self getImageWithImageName:@"load_bg.tiff"];
            txtLoad.text=@"请 稍 等...";
            self.alpha = 1;
        }else if ([[notification object]isEqual:@"hide"]) {
            self.alpha = 0;
        }else if ([[notification object]isEqual:@"err"]) {
            [activity setHidden:YES];
            [txtLoad setHidden:YES];
            imgLoadBg.image = [self getImageWithImageName:@"errnil.tiff"];
            self.alpha = 1;
            [self performSelector:@selector(hideErr) withObject:nil afterDelay:2];
        }else{
            [activity setHidden:NO];    [txtLoad setHidden:NO];
            imgLoadBg.image = [self getImageWithImageName:@"load_bg.tiff"];
            txtLoad.text=[notification object];
            self.alpha = 1;
        }
    }];
    
}

-(void)hideErr{
    [UIView animateWithDuration:0.3 animations:^(void){
        self.alpha = 0;
    }];
}

-(UIImage*)getImageWithImageName:(NSString*)imageNamed{
    
    NSString *path = [NSString stringWithFormat:
                      @"UIBLoadFrameBundle.bundle/%@",imageNamed];
    
    NSString *FullPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
    
    UIImage *image = [UIImage imageWithCGImage:[UIImage imageWithContentsOfFile:FullPath].CGImage];
    
    return image;
}
@end
