//
//  StatsViewController.m
//  statistic
//
//  Created by Jane Ching on 8/11/12.
//  Copyright (c) 2012 Software Tracking LLC. All rights reserved.
//

#import "StatsViewController.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
@interface StatsViewController ()

@end

@implementation StatsViewController

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

- (void)dealloc {
    [_textView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextView:nil];
    [super viewDidUnload];
}


-(NSString *)dayToString:(NSDate *) date {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    }
    
    return [dateFormatter stringFromDate:date];
}


- (IBAction)clickStatsRefresh:(id)sender {
    
    NSArray *statsInArray = [self getDataCounters];
    
    if (statsInArray.count > 3) {
        
        NSString *newStat = [NSString stringWithFormat:@"%@\nSent:%dkb\nRecv:%dkb\n", [NSDate date], [[statsInArray objectAtIndex:2] intValue]/1024, [[statsInArray objectAtIndex:3] intValue]/1024] ;
        
        self.textView.text = [self.textView.text stringByAppendingString:newStat];
        NSString *day = [self dayToString:[NSDate date]];
        NSLog(@"%@", day);
    }
}

- (NSArray *)getDataCounters
{
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    
    NSString *name=[[[NSString alloc]init]autorelease];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            //NSLog(@"ifa_name %s == %@\n", cursor->ifa_name,name);
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    NSLog(@"WiFiSent %d ==%d",WiFiSent,networkStatisc->ifi_obytes);
                    NSLog(@"WiFiReceived %d ==%d",WiFiReceived,networkStatisc->ifi_ibytes);
                }
                
                if ([name hasPrefix:@"pdp_ip"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                    NSLog(@"WWANSent %d ==%d",WWANSent,networkStatisc->ifi_obytes);
                    NSLog(@"WWANReceived %d ==%d",WWANReceived,networkStatisc->ifi_ibytes);
                }
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent], [NSNumber numberWithInt:WiFiReceived],[NSNumber numberWithInt:WWANSent],[NSNumber numberWithInt:WWANReceived], nil];
}


@end
