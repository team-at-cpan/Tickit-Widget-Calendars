#!/usr/bin/env perl 
use strict;
use warnings;
package Tickit::Widget::Calendar::MonthView;
use parent qw(Tickit::Widget);
use POSIX qw(strftime mktime);
use Tickit::Utils qw(textwidth align distribute);

sub cols { 3 * 7 }
sub lines { 6 }

sub day { shift->{day} ||= 29}
sub month { shift->{month} ||= 9}
sub year { shift->{year} ||= 2013}

sub render_to_rb {
	my ($self, $rb, $rect) = @_;
	my $win = $self->window;

	{ # Month and year
		my $ts = mktime 0, 0, 0, $self->day, $self->month - 1, $self->year - 1900;
		my $txt = strftime('%B %Y', localtime $ts);
		my ($before, $actual, $after) = align(textwidth($txt), $win->cols, 0.5);
		$rb->text_at(0, 0, (' ' x $before) . $txt . (' ' x $after));
	}

	# Days of the week
	my @weekdays = (
		map { base => 3, expand => 1, day => strftime('%a', localtime mktime 0,0,0,17 + $_,11,95) }, 1..7
	);
	distribute($win->cols, @weekdays);
	for (@weekdays) {
		$rb->text_at(1, $_->{start}, $_->{day});
	}

	{ # Days of the month
		my $rows = $win->lines - 2;
		my $days_in_month = (localtime mktime 0, 0, 0, 0, $self->month, $self->year - 1900)[3];
		my $weekday = (localtime mktime 0, 0, 0, 1, $self->month - 1, $self->year - 1900)[6];
#		my @buckets = (
#			map { base => 1, expand => 1, day => $_ }, 1..$days_in_month
#		);
	}
}

package main;
use Tickit::DSL;

vbox {
	customwidget {
		Tickit::Widget::Calendar::MonthView->new
	}
};
tickit->run
