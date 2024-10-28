#!/usr/bin/perl
use v5.36;
use builtin qw(
    true false is_bool
);
use Getopt::Long;
use File::HomeDir;
use Perl::OSType ':all';

my $force = false;       # option variable with default value (false)
GetOptions ('force' => \$force);

my $home_dir = File::HomeDir->my_home;
if (os_type() eq "Windows") {
    my $nvim_config_dir = "$home_dir/AppData/Local/nvim";
} elsif (os_type() eq "Unix") {
    my $nvim_config_dir = "$home_dir/.config/nvim";
} else {
    die "Unknown platform @{[os_type()]}";
}

sub create_symlink {
    my (%args) = @_;
    my $link = $args{link};
    my $dest = $args{dest};
}

