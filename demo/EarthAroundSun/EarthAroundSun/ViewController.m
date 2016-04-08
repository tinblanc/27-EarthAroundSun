//
//  ViewController.m
//  EarthAroundSun
//
//  Created by Tin Blanc on 4/7/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSTimer* timer;
    UIImageView *sun;
    UIImageView *earth;
    UIImageView *moon;
    CGPoint sunCenter;
    CGFloat distanceEarthToSun; // distance: khoảng cách
    CGFloat angle; // góc quay angle
    
    CGPoint earthCenter;
    CGFloat distanceMoonToEarth;
    CGFloat angleMoonVsEarth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // Sun vs Earth
    [self addSunAndEarth];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(spinEarth)
                                           userInfo:nil
                                            repeats:true];
    
    // Earth vs Moon
    [self addMoon];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(spinMoon)
                                           userInfo:nil
                                            repeats:true];

}


-(void) addSunAndEarth {
    sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun.png"]];
    earth = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth.png"]];
    
    
    CGSize mainViewSize = self.view.bounds.size;
    
    // lấy height của status bar + thanh navigation bar
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height +self.navigationController.navigationBar.bounds.size.height;
    
    sunCenter = CGPointMake(mainViewSize.width * 0.5 , (mainViewSize.height + statusNavigationBarHeight) * 0.5);
    
    distanceEarthToSun = mainViewSize.width * 0.25 + 20.0 ;
    
    sun.center = sunCenter;
    angle = 0.0;
    earth.center = [self computePositionOfEarth:angle];
    
    [self.view addSubview:sun];
    [self.view addSubview:earth];
    
}

-(void) addMoon {
    moon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon.png"]];
    
    CGSize mainViewSize = self.view.bounds.size;
    
    distanceMoonToEarth = mainViewSize.width * 0.25 - 40.0 ;
    angleMoonVsEarth = 0.0;
    moon.center = [self computePositionOfMoon:angleMoonVsEarth];
    
    [self.view addSubview:moon];
    
}

// Tính toán vị trí của Trái Đất
-(CGPoint) computePositionOfEarth:(CGFloat) _angle {
    return CGPointMake( sunCenter.x + distanceEarthToSun * cos(_angle),
                       sunCenter.y + distanceEarthToSun * sin(_angle));
}


-(CGPoint) computePositionOfMoon: (CGFloat) _angleMoonVsEarth {
    return CGPointMake(earth.center.x + distanceMoonToEarth * cos(angleMoonVsEarth),
                       earth.center.y + distanceMoonToEarth * sin(angleMoonVsEarth));
}

-(void) spinEarth {
    angle +=0.01;
    earth.center = [self computePositionOfEarth:angle];
}

-(void) spinMoon {
    angleMoonVsEarth -=0.03;
    moon.center = [self computePositionOfMoon:angleMoonVsEarth];
}



@end
