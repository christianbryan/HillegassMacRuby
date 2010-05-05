//
//  main.m
//  CarLot
//
// Created by daniellopes on 04/05/10.
// Adapted from 'Cocoa Programming for Mac OS X' - 3rd Edition by Aaron Hillegass (http://www.bignerdranch.com/)
//

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
